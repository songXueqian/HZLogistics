//
//  UIBarButtonItem+Addition.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addition)

/**
 *  快速创建一个UIBarButtonItem对象 通过给定的图片
 */
+ (instancetype)itemWithImagename:(NSString *)imagename hightImagename:(NSString *)hightImagename target:(id)target action:(SEL)action;


/**
 *  快速创建一个UIBarButtonItem对象 通过给定的图片
 */
+ (instancetype)itemWithImagename:(NSString *)imagename hightImagename:(NSString *)hightImagename touchBlock:(void(^)())block;


/**
 *  快速创建一个UIBarButtonItem对象 通过给定的标题和tintColor
 */
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action tintColor:(UIColor *)tintColor;

/**
 *  快速创建一个UIBarButtonItem对象 通过给定的标题和tintColor
 */
+ (instancetype)itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor touchBlock:(void(^)())block;

@end
