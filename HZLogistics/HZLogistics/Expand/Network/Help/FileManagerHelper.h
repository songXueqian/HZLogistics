//
//  FileManagerHelper.h
//  LoveSport
//
//  Created by Liang Zhang on 14/11/28.
//  Copyright (c) 2014年 bangtianxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerHelper : NSObject

+ (void)CreatFilePath:(NSString *)name;
+ (void)DeleteFilePath:(NSString *)name;

@end
