//
//  HZMainTabbarViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZMainTabbarViewController.h"
#import "HZHomeViewController.h"
#import "HZOrderViewController.h"
#import "HZMessageViewController.h"
#import "HZPersonViewController.h"
#import "HZLoginViewController.h"
#import "HZBaseNavigationViewController.h"

@interface HZMainTabbarViewController ()

@end

@implementation HZMainTabbarViewController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:(0 / 255.0f) green:(122 / 255.0f) blue:(228 / 255.0f) alpha:1.0f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllerWithClassname:[HZHomeViewController description] imagename:@"home" title:@"下单"];
    [self addChildViewControllerWithClassname:[HZOrderViewController description] imagename:@"Found" title:@"订单"];
    [self addChildViewControllerWithClassname:[HZMessageViewController description]imagename:@"audit" title:@"信息"];
    [self addChildViewControllerWithClassname:[HZPersonViewController description] imagename:@"newstab" title:@"个人中心"];

}


// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    HZBaseNavigationViewController *nav = [[HZBaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
