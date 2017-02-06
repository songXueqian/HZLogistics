//
//  BaseViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self isNetWork];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    //设置标题
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
 
    
    //加载起始页
    self.pageCount = 1;
    
    //设置左按钮
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
    [left setImage:[UIImage imageNamed:@"common_back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    [left addTarget:self action:@selector(LeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    //设置nav字体
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //开启手势拖动
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
    
    //设置view的颜色
    [self.view setBackgroundColor:BackgroundColor];
    
    _wifiManHubLoader = [[FeWifiManHub alloc] initWithView:self.view withMode:FeWifiManHubModeOnlyLoader];

    
}


- (void)isNetWork
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    NetworkStatus status = [r currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"您的网络连接失败" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }]];
        
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
    
}


- (void)LeftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma -mark MBProgressHUD
- (void)showHudWithDetailsLabel:(NSString *)msg Detail:(NSString *)detail {
    [_wifiManHubLoader show];
    
    
    [self.view addSubview:_wifiManHubLoader];
    [self.view bringSubviewToFront:_wifiManHubLoader];
}

- (void)showHud{
    
    [_wifiManHubLoader show];
    [self.view addSubview:_wifiManHubLoader];
    [self.view bringSubviewToFront:_wifiManHubLoader];
}

- (void)hiddenHud {
    [_wifiManHubLoader dismiss];
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
