//
//  NGFileHandler.h
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGEnum.h"
#import "NGMacros.h"
#import "NGContants.h"

@interface NGFileHandler : NSObject {
    /*! File manager object */
    NSFileManager           *_fileManager;
    
    /*! Dcitionary to keep calculated path */
    NSMutableDictionary     *_pathCache;
    
}

#pragma mark - Singelton Methods
/*! Singleton of the NGFileManager */
+ (instancetype) sharedFileManager ;

#pragma mark - Path Creation Methods
/*! Directory Maker for path type */
- (BOOL) createDirectoryFor:(NSString *) _path ;

/*! Create Path for Path Type including path compont or without path component */
- (NSString *) createPathFor:(FolderType)_folderType withPathComponent:(NSString *) _pathComponent shouldValidate:(BOOL) _doesValidate ;

/*! Getting Path For Reading & Writing Based On File Type*/
- (NSString *) pathForFileType:(FileType)_fileType ;

#pragma mark - Validation Methods
/*! Check Path validity */
- (BOOL) checkForPathValidity:(NSString *) _fullPath ;

/*! Check Path Validation for File Type*/
- (BOOL) checkForPathValidityForFile:(FileType)_fileType;

#pragma mark - Save/Read/Move/Delete Methods
/*! Save File for File type with user session */
- (BOOL) saveFile:(FileType) _fileType For:(id) _data ;

/*! Read File for File Type with Synchronous or asynchronous */
- (id) readFile:(FileType) _fileType isAsync:(BOOL) _aSync outputType:(ReadOutputType) _outputType ;

/*! Move files from one location to other */
- (BOOL) moveFilesFrom:(FolderType)_sourceFolder to:(FolderType)_destFolder ;

/*! Delete File From Path Location*/
- (BOOL) deleteFilesFrom:(FolderType) _folder ;

#pragma mark - Notification Methods
/*! Notifies for file read operations*/
- (void) fileReadCompleted:(NSNotification *) _notification;


@end
