//
//  HZCustomSegmentView.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

//  切换视图，类似于系统的UISegmentControl

#import <UIKit/UIKit.h>
#import "Type.h"

@interface HZCustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic, copy) void(^NHCustomSegmentViewBtnClickHandle)(HZCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;

@end
