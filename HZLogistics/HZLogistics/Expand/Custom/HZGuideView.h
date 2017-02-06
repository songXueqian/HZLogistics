//
//  HZGuideView.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/12.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Type.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define currentPageColor [UIColor redColor] //页面控制器选中颜色
#define pageIndicatorColor [UIColor blackColor] //页面控制器未选中颜色
#define placehoderBackImage @"" //获取网络图片时 默认图片

typedef void (^finish_block)(void);

@interface HZGuideView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)finish_block block;

@property(nonatomic,strong)UIPageControl *pageCtr;
@property(nonatomic,strong)UIScrollView *ScrollView;
@property(nonatomic,strong)UIButton *startBtn;


-(void)createLocationImageArr:(NSArray *)ImageArr block:(finish_block)block;

@end
