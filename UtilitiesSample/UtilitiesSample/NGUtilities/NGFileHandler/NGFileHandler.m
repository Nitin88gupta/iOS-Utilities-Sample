//
//  NGFileHandler.m
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGFileHandler.h"

@implementation NGFileHandler

static NGFileHandler *_sharedFileManager = nil;

#pragma mark - Singelton Methods
+ (instancetype) sharedFileManager {
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^ {
            _sharedFileManager = [[self alloc] init];
        });
        return _sharedFileManager;
    }
}

#pragma mark - Init Methods
-(id) init {
	if( (self = [super init]) ) {
		_fileManager = [[NSFileManager alloc] init];
        _pathCache = [[NSMutableDictionary alloc] init];
	}
	return self;
}

#pragma mark - dealloc Methods
- (void)dealloc {
    _fileManager = nil;
    _pathCache = nil;
#if !__has_feature(objc_arc)
//    Do manual memory management...
//    Use For Non ARC Project
    if (_fileManager) {
        [_fileManager release];
        _fileManager = nil;
    }
    _pathCache = nil;
    if (_pathCache) {
        [_pathCache release];
        _pathCache = nil;
    }
    [super dealloc];
#else
    //Usually do nothing...
#endif
}

#pragma mark - Path Creation Methods
- (BOOL) createDirectoryFor:(NSString *) _path {
    if (![self checkForPathValidity:_path]) {
        NSError *error = nil;
        [_fileManager createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:NULL error:&error];
        if (error) {
            kNSLogWithObjectDescription(error)
            return FALSE;
        }
    }
    return TRUE;
}

- (NSString *) createPathFor:(FolderType)_folderType withPathComponent:(NSString *) _pathComponent shouldValidate:(BOOL) _doesValidate {
    @synchronized(self) {
        NSAssert( (_folderType != kNone_FolderType), @"_folderType should not be nil");
        NSArray *keyArray = [_pathCache allKeys];
        BOOL _isPathInCahce = [keyArray containsObject:[NSNumber numberWithInt:_folderType]];
        if (_isPathInCahce) {
            NSString *fullPath = [[_pathCache objectForKey:[NSNumber numberWithInt:_folderType]] stringByAppendingPathComponent:_pathComponent];
            if ([self checkForPathValidity:fullPath]) {
                return fullPath;
            } else {
                kNSLogFunction
                if (!_doesValidate) {
                    return fullPath;
                } else {
                    return nil;
                }
            }
        } else {
            NSString *fullPath = nil;
            switch (_folderType) {
                case kLibrary_FolderType:
                    fullPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    break;
                case kDocument_FolderType:
                    fullPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    break;
                case kTemp_FolderType:
                    fullPath = NSTemporaryDirectory();
                    break;
                case kCache_FolderType:
                    fullPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    break;
                case kBundle_FolderType:
                    fullPath = [[NSBundle mainBundle] resourcePath];
                    break;
                case kCache_Image_FolderType:
                    fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:Cache_Image_Folder];
                    break;
                case kOwner_FolderType:
                    fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:Cache_Owner_Folder];
                    [self createDirectoryFor:fullPath];
                    break;
                case kNone_FolderType:
                default:
                    break;
            }
            
            if (fullPath) {
                [_pathCache setObject:fullPath forKey:[NSNumber numberWithInt:_folderType]];
                if (_pathComponent) {
                    /*! Appending Path Component Here*/
                    fullPath = [fullPath stringByAppendingPathComponent:_pathComponent];
                }
                return fullPath;
            } else {
                kNSLogFunction
                return nil;
            }
        }
    }
}

- (NSString *) pathForFileType:(FileType)_fileType {
    NSString *_aPath = nil;
    switch (_fileType) {
        case kSaved_Data_FileType:
            _aPath = [self createPathFor:kOwner_FolderType withPathComponent:Saved_Data_Info shouldValidate:NO];
            break;
        case kSettings_FileType:
            _aPath = [self createPathFor:kOwner_FolderType withPathComponent:Setting_Info shouldValidate:NO];
            break;
        default:
            _aPath = nil;
            kNSLogFunction
            break;
    }
    return _aPath;
}

#pragma mark - Validation Methods
- (BOOL) checkForPathValidity:(NSString *) _fullPath {
    
    if ([_fileManager fileExistsAtPath:_fullPath]) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (BOOL) checkForPathValidityForFile:(FileType)_fileType {
    NSString *_aPath = [self pathForFileType:_fileType];
    return [self checkForPathValidity:_aPath];
}

#pragma mark - Save/Read/Move/Delete Methods
- (BOOL) saveFile:(FileType) _fileType For:(id) _data {
	@synchronized(self){
        NSString *_savePath = [self pathForFileType:_fileType];
        NSAssert(_data, @"_data Cant be a Null value");
        
        if ([_fileManager fileExistsAtPath:_savePath]) {
            [_fileManager removeItemAtPath:_savePath error:NULL];
        }
        BOOL result = [_data writeToFile:_savePath atomically:YES];
        if (!result) {
            kNSLogFunction
        }
        return result;
    }
}

- (id) readFile:(FileType) _fileType isAsync:(BOOL) _aSync outputType:(ReadOutputType) _outputType {
    @synchronized(self) {
        NSFileHandle *_fileHandler = nil;
        NSMutableData *_fileContent = nil;
        NSMutableDictionary *_fileDict = nil;
        NSString *_savePath = [self pathForFileType:_fileType];
        
        if (_aSync) {
            _fileHandler = [NSFileHandle fileHandleForReadingAtPath:_savePath];
            if (_fileHandler != nil) {
                [_fileHandler readInBackgroundAndNotify];
                [[NSNotificationCenter defaultCenter]
                 addObserver:self
                 selector:@selector(fileReadCompleted:)
                 name: NSFileHandleReadCompletionNotification
                 object:_fileHandler];
            }
        } else {
            if (_outputType == kData_OutputType) {
                _fileContent = [[NSMutableData alloc] initWithContentsOfFile:_savePath];
                return _fileContent;
            } else if (_outputType == kDictionary_OutputType) {
                _fileDict = [[NSMutableDictionary alloc] initWithContentsOfFile:_savePath];
                return _fileDict;
            }
        }
        return NULL;
    }
}

- (BOOL) moveFilesFrom:(FolderType)_sourceFolder to:(FolderType)_destFolder {
    
    NSError *error = nil;
    NSString *_sourcePath = [self createPathFor:_sourceFolder withPathComponent:NULL shouldValidate:FALSE];
    NSString *_destPath = [self createPathFor:_destFolder withPathComponent:NULL shouldValidate:FALSE];
    
    [_fileManager copyItemAtPath:_sourcePath toPath:_destPath error:&error];
    
    if (error) {
        kNSLogWithObjectDescription(error)
        return FALSE;
    }
    return TRUE;
}

- (BOOL) deleteFilesFrom:(FolderType) _folder {
    
    NSError *error = nil;
    NSString *_folderPath = [self createPathFor:_folder withPathComponent:NULL shouldValidate:TRUE];
    NSAssert(_folder,@"_folderPath shouldn't NIL");
    [_fileManager removeItemAtPath:_folderPath error:&error];
    
    if (error) {
        kNSLogWithObjectDescription(error)
        return FALSE;
    }
    return TRUE;
}

#pragma mark - Notification Methods
- (void) fileReadCompleted:(NSNotification *) _notification {
    
    NSData *_tempData = [[_notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSPropertyListFormat plistFormat;
    NSError *error = nil;
    [NSPropertyListSerialization propertyListWithData:_tempData options:NSPropertyListImmutable format:&plistFormat error:&error];
    if (!error) {
        NSLog(@"File Reading Succuess");
    } else {
        kNSLogWithObjectDescription(error)
    }
}

@end
