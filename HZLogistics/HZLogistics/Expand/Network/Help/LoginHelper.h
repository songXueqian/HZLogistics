//
//  LoginHelper.h
//  Houses
//
//  Created by Liang Zhang on 14/12/16.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelper : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
