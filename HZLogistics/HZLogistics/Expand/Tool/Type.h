//
//  Type.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#ifndef Type_h
#define Type_h



#import "UIView+Frame.h"

/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define screenWeith self.view.frame.size.width
#define screenHeight self.view.frame.size.height

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]

#define ACTIVITY_COLOR  [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.4]


//主题色
#define MainColor [UIColor colorWithRed:(0 / 255.0f) green:(73 / 255.0f) blue:(136 / 255.0f) alpha:1.0f]

//背景色
#define BackgroundColor [UIColor colorWithRed:(235 / 255.0f) green:(235 / 255.0f) blue:(235 / 255.0f) alpha:1.0f]

#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]

//所有提交按钮颜色
//#define ButtonColor [UIColor colorWithRed:(30 / 255.0f) green:(114 / 255.0f) blue:(182 / 255.0f) alpha:1.0f]

//线框
#define LineColor [UIColor colorWithRed:(204 / 255.0f) green:(204 / 255.0f) blue:(204 / 255.0f) alpha:1.0f]

//重要字体
#define MainTextColor [UIColor colorWithRed:(51 / 255.0f) green:(51 / 255.0f) blue:(51 / 255.0f) alpha:1.0f]

//二级字体
#define SecondTextColor [UIColor colorWithRed:(102 / 255.0f) green:(102 / 255.0f) blue:(102 / 255.0f) alpha:1.0f]

//提示字体
#define TipTextColor [UIColor colorWithRed:(153 / 255.0f) green:(153 / 255.0f) blue:(153 / 255.0f) alpha:1.0f]

//特别标注
#define SpecialTextColor [UIColor colorWithRed:(238 / 255.0f) green:(99 / 255.0f) blue:(35 / 255.0f) alpha:1.0f]

//按钮颜色
#define ButtonColor [UIColor colorWithRed:(0 / 255.0f) green:(122 / 255.0f) blue:(228 / 255.0f) alpha:1.0f]

//灰色字体
#define UIGrayColor [UIColor colorWithRed:(101 / 255.0f) green:(101 / 255.0f) blue:(101 / 255.0f) alpha:1.0f]

//红色字体
#define UIRedColor [UIColor colorWithRed:(255 / 255.0f) green:(55 / 255.0f) blue:(75 / 255.0f) alpha:1.0f]

//textField.placeholder字体
#define UITPlaceholder [UIColor colorWithRed:(199 / 255.0f) green:(199 / 255.0f) blue:(205 / 255.0f) alpha:1.0f]


//话术文字背景颜色
#define tipBackColor [UIColor colorWithRed:(254 / 255.0f) green:(168 / 255.0f) blue:(32 / 255.0f) alpha:1.0f]


//首页横向间隙
#define HorizontalGap 10.0 / 375 * Main_Screen_Width

//首页纵向间隙
#define LongitudinalGap 8.0 / 667 * Main_Screen_Height




//16号字体
#define UIFont16 [UIFont systemFontOfSize:16];

//14号字体
#define UIFont14 [UIFont systemFontOfSize:14];

//12号字体
#define UIFont12 [UIFont systemFontOfSize:12];

//常量定义
#define PAGE_COUNT    1    //请求页数
#define PAGE_START    0    //请求起始

//图片文件名定义
#define IMG_HEAD_BACK    @"head_back.png"
#define IMG_HEAD_MENU    @"head_menu.png"
#define IMG_HEAD_RIGHT   @"head_right.png"

//默认头像
#define DEFAULT_PHOTO_IMAGE [UIImage imageNamed:@""]
//默认网络下载图片
#define DEFAULT_PIC_IMAGE [UIImage imageNamed:@""]

//设置字体大小
#define TEXT_FONT(a)    [UIFont systemFontOfSize:a]

//当前屏幕高宽度
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

//File Path
#define pathDocuments [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]

//客服电话
#define customerServicePhone @"400-880-0353"



#endif /* Type_h */
