//
//  BaseViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Type.h"
#import "myToast.h"
#import "MJRefresh.h"
#import "AFAppDotNetAPIClient.h"
#import "UIImageView+WebCache.h"
#import "FeWifiManHub.h"



@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, assign)NSInteger pageCount;
@property (strong, nonatomic) FeWifiManHub *wifiManHubLoader;
@property (strong, nonatomic) FeWifiManHub *wifiManHubPercent;


- (void)showHud;
- (void)showHudWithDetailsLabel:(NSString *)msg Detail:(NSString *)detail;
- (void)hiddenHud;
- (void)LeftAction;
- (void)pushVc:(UIViewController *)vc;


@end
