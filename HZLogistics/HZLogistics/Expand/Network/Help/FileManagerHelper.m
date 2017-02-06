//
//  FileManagerHelper.m
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import "FileManagerHelper.h"
#import "Type.h"

@implementation FileManagerHelper

+ (void)CreatFilePath:(NSString *)name {
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", pathDocuments, name];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if (!(isDir==YES && existed==YES)) {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (void)DeleteFilePath:(NSString *)name {
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@", pathDocuments, name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageDir error:nil];
}

@end
