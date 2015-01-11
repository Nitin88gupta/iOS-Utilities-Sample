//
//  NGEnum.h
//  NGGameKit
//
//  Created by Nitin Gupta on 23/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kNoneTimeFormat = 0,
    kDaysFormat = 1,
    kDigitalFormat = 2,
}TimeFormat;


typedef enum {
    kData_OutputType         = 1,
    kDictionary_OutputType   = 2,
} ReadOutputType;

typedef enum {
    kUndefined_FileType      = 0,
    kSaved_Data_FileType = 1,
    kSettings_FileType   = 2,
} FileType;

typedef enum {
    kNone_FolderType        = 0,
    kLibrary_FolderType     = 1,
    kDocument_FolderType   = 2,
    kTemp_FolderType        = 3,
    kCache_FolderType      = 4,
    kBundle_FolderType      = 5,
    kCache_Image_FolderType = 6,
    kOwner_FolderType       = 7,
} FolderType;
