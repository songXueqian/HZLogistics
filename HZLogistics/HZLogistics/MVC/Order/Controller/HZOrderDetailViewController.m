//
//  HZOrderDetailViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderDetailViewController.h"
#import "HZOrderShadowViewController.h"
#import "HZOrderMapWayPointRouteViewController.h"
#import "GetOrderInfoModel.h"

@interface HZOrderDetailViewController ()
@property (nonatomic, strong)GetOrderInfoModel *model;
@end

@implementation HZOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    
    //设置右按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(20, 20, 30, 30)];
    [_rightButton setImage:[UIImage imageNamed:@"icon_map_location"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    
    [self creatView];

    
}

- (void)creatView{
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.backScrollView.backgroundColor = [UIColor clearColor];
    self.backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backScrollView];
    
    self.upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
    self.upView.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.upView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.upView addGestureRecognizer:tap];

    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7.5, 70, 30)];
    self.titleLabel.text = @"货运跟踪";
    self.titleLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upView addSubview:self.titleLabel];
    
    self.xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.upView.frame.size.height - 0.5, Main_Screen_Width, 0.5)];
    self.xianLabel.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];
    [self.upView addSubview:self.xianLabel];
    
    self.coinImage = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width - 10 - 15, 15, 15, 15)];
    self.coinImage.image = [UIImage imageNamed:@"right"];
    [self.upView addSubview:self.coinImage];

   
//    self.upView.frame = CGRectMake(0, 0, Main_Screen_Width, 0);
    
    self.downImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.upView.frame.origin.y + self.upView.frame.size.height + 15, Main_Screen_Width - 20, Main_Screen_Height)];
    self.downImage.backgroundColor = [UIColor whiteColor];
    self.downImage.layer.masksToBounds = YES;
    self.downImage.layer.borderColor = [[UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00] CGColor];
    self.downImage.layer.borderWidth = 0.5;
    self.downImage.userInteractionEnabled = YES;
    [self.backScrollView addSubview:self.downImage];
    
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
    self.contentLabel.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];
    self.contentLabel.text = @"SE16523716";
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    [self.downImage addSubview:self.contentLabel];
    
    self.statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.downImage.frame.size.width - 60 - 10, 7.5, 60, 25)];
//    self.statusImage.image = [UIImage imageNamed:@"right"];
//    self.statusImage.backgroundColor = [UIColor redColor];
    [self.downImage addSubview:self.statusImage];

    self.grayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.downImage.frame.size.width - 20, 0.5)];
    self.grayLabel.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];
    [self.downImage addSubview:self.grayLabel];

    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.grayLabel.frame.origin.y + self.grayLabel.frame.size.height + 5, 90, 30)];
    self.numLabel.text = @"提单号:";
    self.numLabel.font = UIFont16;
    self.numLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.numLabel];
    
    self.numNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.numLabel.frame.origin.x + self.numLabel.frame.size.width, self.numLabel.frame.origin.y, self.downImage.frame.size.width - self.numLabel.frame.origin.x - self.numLabel.frame.size.width - 10, 30)];
//    self.numNumLabel.text = @"公司地址";
    self.numNumLabel.font = UIFont16;
    self.numNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.numNumLabel];
    
    self.weiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.numLabel.frame.origin.y + self.numLabel.frame.size.height + 5, 90, 30)];
    self.weiLabel.text = @"委托人:";
    self.weiLabel.font = UIFont16;
    self.weiLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.weiLabel];
    
    self.weiNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.weiLabel.frame.origin.x + self.weiLabel.frame.size.width, self.weiLabel.frame.origin.y, self.downImage.frame.size.width - self.weiLabel.frame.origin.x - self.weiLabel.frame.size.width - 10, 30)];
//    self.weiNumLabel.text = @"公司地址";
    self.weiNumLabel.font = UIFont16;
    self.weiNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.weiNumLabel];
    
    self.faLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.weiLabel.frame.origin.y + self.weiLabel.frame.size.height + 5, 90, 30)];
    self.faLabel.text = @"发货人:";
    self.faLabel.font = UIFont16;
    self.faLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.faLabel];
    
    self.faNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.faLabel.frame.origin.x + self.faLabel.frame.size.width, self.faLabel.frame.origin.y, self.downImage.frame.size.width - self.faLabel.frame.origin.x - self.faLabel.frame.size.width - 10, 30)];
//    self.faNumLabel.text = @"公司地址";
    self.faNumLabel.font = UIFont16;
    self.faNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.faNumLabel];
    
    self.shouLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.faLabel.frame.origin.y + self.faLabel.frame.size.height + 5, 90, 30)];
    self.shouLabel.text = @"收货人:";
    self.shouLabel.font = UIFont16;
    self.shouLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.shouLabel];
    
    self.shouNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shouLabel.frame.origin.x + self.shouLabel.frame.size.width, self.shouLabel.frame.origin.y, self.downImage.frame.size.width - self.shouLabel.frame.origin.x - self.shouLabel.frame.size.width - 10, 30)];
//    self.shouNumLabel.text = @"公司地址";
    self.shouNumLabel.font = UIFont16;
    self.shouNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.shouNumLabel];
    
    self.tongLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shouLabel.frame.origin.y + self.shouLabel.frame.size.height + 5, 90, 30)];
    self.tongLabel.text = @"通知人:";
    self.tongLabel.font = UIFont16;
    self.tongLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.tongLabel];
    
    self.tongNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tongLabel.frame.origin.x + self.tongLabel.frame.size.width, self.tongLabel.frame.origin.y, self.downImage.frame.size.width - self.tongLabel.frame.origin.x - self.tongLabel.frame.size.width - 10, 30)];
//    self.tongNumLabel.text = @"公司地址";
    self.tongNumLabel.font = UIFont16;
    self.tongNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.tongNumLabel];
    
    self.huoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.tongLabel.frame.origin.y + self.tongLabel.frame.size.height + 10, 90, 30)];
    self.huoLabel.text = @"货名:";
    self.huoLabel.font = UIFont16;
    self.huoLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.huoLabel];
    
    self.huoNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.huoLabel.frame.origin.x + self.huoLabel.frame.size.width, self.huoLabel.frame.origin.y, self.downImage.frame.size.width - self.huoLabel.frame.origin.x - self.huoLabel.frame.size.width - 10, 30)];
//    self.huoNumLabel.text = @"公司地址";
    self.huoNumLabel.font = UIFont16;
    self.huoNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.huoNumLabel];
    
    self.shuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.huoLabel.frame.origin.y + self.huoLabel.frame.size.height + 5, 90, 30)];
    self.shuLabel.text = @"包数/件数:";
    self.shuLabel.font = UIFont16;
    self.shuLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.shuLabel];
    
    self.shuNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shuLabel.frame.origin.x + self.shuLabel.frame.size.width, self.shuLabel.frame.origin.y, 120, 30)];
//    self.shuNumLabel.text = @"公司地址";
    self.shuNumLabel.font = UIFont16;
    self.shuNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.shuNumLabel];

    
    self.danLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.downImage.frame.size.width - 100, self.shuLabel.frame.origin.y, 90, 30)];
    self.danLabel.text = @"包/件";
    self.danLabel.font = UIFont14;
    self.danLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    self.danLabel.textAlignment = NSTextAlignmentRight;
    [self.downImage addSubview:self.danLabel];
    
    
    self.zhongLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.shuLabel.frame.origin.y + self.shuLabel.frame.size.height + 5, 90, 30)];
    self.zhongLabel.text = @"重量(吨):";
    self.zhongLabel.font = UIFont16;
    self.zhongLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.zhongLabel];
    
    self.zhongNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zhongLabel.frame.origin.x + self.zhongLabel.frame.size.width, self.zhongLabel.frame.origin.y, 120, 30)];
//    self.zhongNumLabel.text = @"公司地址";
    self.zhongNumLabel.font = UIFont16;
    self.zhongNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.zhongNumLabel];

    self.danLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.downImage.frame.size.width - 100, self.zhongLabel.frame.origin.y, 90, 30)];
    self.danLabel2.text = @"吨(t)";
    self.danLabel2.font = UIFont14;
    self.danLabel2.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    self.danLabel2.textAlignment = NSTextAlignmentRight;
    [self.downImage addSubview:self.danLabel2];
    
    
    self.tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.zhongLabel.frame.origin.y + self.zhongLabel.frame.size.height + 5, 90, 30)];
    self.tiLabel.text = @"体积:";
    self.tiLabel.font = UIFont16;
    self.tiLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.tiLabel];
    
    self.tiNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tiLabel.frame.origin.x + self.tiLabel.frame.size.width, self.tiLabel.frame.origin.y, 120, 30)];
//    self.tiNumLabel.text = @"公司地址";
    self.tiNumLabel.font = UIFont16;
    self.tiNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.tiNumLabel];

    self.danLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(self.downImage.frame.size.width - 100, self.tiLabel.frame.origin.y, 90, 30)];
    self.danLabel3.text = @"立方米(m³)";
    self.danLabel3.font = UIFont14;
    self.danLabel3.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    self.danLabel3.textAlignment = NSTextAlignmentRight;
    [self.downImage addSubview:self.danLabel3];

    
    self.zhuangLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.tiLabel.frame.origin.y + self.tiLabel.frame.size.height + 10, 90, 30)];
    self.zhuangLabel.text = @"装货港:";
    self.zhuangLabel.font = UIFont16;
    self.zhuangLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.zhuangLabel];
    
    self.zhuangNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zhuangLabel.frame.origin.x + self.zhuangLabel.frame.size.width, self.zhuangLabel.frame.origin.y, self.downImage.frame.size.width - self.zhuangLabel.frame.origin.x - self.zhuangLabel.frame.size.width - 10, 30)];
//    self.zhuangNumLabel.text = @"公司地址";
    self.zhuangNumLabel.font = UIFont16;
    self.zhuangNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.zhuangNumLabel];
    
    self.xieLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.zhuangLabel.frame.origin.y + self.zhuangLabel.frame.size.height + 5, 90, 30)];
    self.xieLabel.text = @"卸货港:";
    self.xieLabel.font = UIFont16;
    self.xieLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.xieLabel];
    
    self.xieNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.xieLabel.frame.origin.x + self.xieLabel.frame.size.width, self.xieLabel.frame.origin.y, self.downImage.frame.size.width - self.xieLabel.frame.origin.x - self.xieLabel.frame.size.width - 10, 30)];
//    self.xieNumLabel.text = @"公司地址";
    self.xieNumLabel.font = UIFont16;
    self.xieNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.xieNumLabel];
    
    self.muLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.xieLabel.frame.origin.y + self.xieLabel.frame.size.height + 5, 90, 30)];
    self.muLabel.text = @"目的港:";
    self.muLabel.font = UIFont16;
    self.muLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.muLabel];
    
    self.muNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.muLabel.frame.origin.x + self.muLabel.frame.size.width, self.muLabel.frame.origin.y, self.downImage.frame.size.width - self.muLabel.frame.origin.x - self.muLabel.frame.size.width - 10, 30)];
//    self.muNumLabel.text = @"公司地址";
    self.muNumLabel.font = UIFont16;
    self.muNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.muNumLabel];
    
    self.chuTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.muLabel.frame.origin.y + self.muLabel.frame.size.height + 10, 90, 30)];
    self.chuTimeLabel.text = @"出口时间:";
    self.chuTimeLabel.font = UIFont16;
    self.chuTimeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.chuTimeLabel];
    
    self.chuTimeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chuTimeLabel.frame.origin.x + self.chuTimeLabel.frame.size.width, self.chuTimeLabel.frame.origin.y, self.downImage.frame.size.width - self.chuTimeLabel.frame.origin.x - self.chuTimeLabel.frame.size.width - 10, 30)];
//    self.chuTimeNumLabel.text = @"公司地址";
    self.chuTimeNumLabel.font = UIFont16;
    self.chuTimeNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.chuTimeNumLabel];
    
    self.jietimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.chuTimeLabel.frame.origin.y + self.chuTimeLabel.frame.size.height + 5, 90, 30)];
    self.jietimeLabel.text = @"接货日期:";
    self.jietimeLabel.font = UIFont16;
    self.jietimeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.jietimeLabel];
    
    self.jietimeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.jietimeLabel.frame.origin.x + self.jietimeLabel.frame.size.width, self.jietimeLabel.frame.origin.y, self.downImage.frame.size.width - self.jietimeLabel.frame.origin.x - self.jietimeLabel.frame.size.width - 10, 30)];
//    self.jietimeNumLabel.text = @"公司地址";
    self.jietimeNumLabel.font = UIFont16;
    self.jietimeNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.jietimeNumLabel];
    
    self.zhuangTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.jietimeLabel.frame.origin.y + self.jietimeLabel.frame.size.height + 5, 90, 30)];
    self.zhuangTimeLabel.text = @"装船日期:";
    self.zhuangTimeLabel.font = UIFont16;
    self.zhuangTimeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.zhuangTimeLabel];
    
    self.zhuangTimeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.zhuangTimeLabel.frame.origin.x + self.zhuangTimeLabel.frame.size.width, self.zhuangTimeLabel.frame.origin.y, self.downImage.frame.size.width - self.zhuangTimeLabel.frame.origin.x - self.zhuangTimeLabel.frame.size.width - 10, 30)];
//    self.zhuangNumLabel.text = @"公司地址";
    self.zhuangTimeNumLabel.font = UIFont16;
    self.zhuangTimeNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.zhuangTimeNumLabel];
    
    self.daoTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.zhuangTimeNumLabel.frame.origin.y + self.zhuangTimeNumLabel.frame.size.height + 5, 90, 30)];
    self.daoTimeLabel.text = @"到港日期:";
    self.daoTimeLabel.font = UIFont16;
    self.daoTimeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.daoTimeLabel];
    
    self.daoTimeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.daoTimeLabel.frame.origin.x + self.daoTimeLabel.frame.size.width, self.daoTimeLabel.frame.origin.y, self.downImage.frame.size.width - self.daoTimeLabel.frame.origin.x - self.daoTimeLabel.frame.size.width - 10, 30)];
//    self.daoTimeNumLabel.text = @"公司地址";
    self.daoTimeNumLabel.font = UIFont16;
    self.daoTimeNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.daoTimeNumLabel];
    
    self.chuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.daoTimeLabel.frame.origin.y + self.daoTimeLabel.frame.size.height + 10, 90, 30)];
    self.chuanLabel.text = @"船名:";
    self.chuanLabel.font = UIFont16;
    self.chuanLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.chuanLabel];
    
    self.chuanNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chuanLabel.frame.origin.x + self.chuanLabel.frame.size.width, self.chuanLabel.frame.origin.y, self.downImage.frame.size.width - self.chuanLabel.frame.origin.x - self.chuanLabel.frame.size.width - 10, 30)];
//    self.chuanNumLabel.text = @"公司地址123123";
    self.chuanNumLabel.font = UIFont16;
    self.chuanNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.chuanNumLabel];
    
    self.ciLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.chuanLabel.frame.origin.y + self.chuanLabel.frame.size.height + 5, 90, 30)];
    self.ciLabel.text = @"航次:";
    self.ciLabel.font = UIFont16;
    self.ciLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.ciLabel];
    
    self.ciNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ciLabel.frame.origin.x + self.ciLabel.frame.size.width, self.ciLabel.frame.origin.y, self.downImage.frame.size.width - self.ciLabel.frame.origin.x - self.ciLabel.frame.size.width - 10, 30)];
//    self.ciNumLabel.text = @"公司地址";
    self.ciNumLabel.font = UIFont16;
    self.ciNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.ciNumLabel];
    
    self.payLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.ciLabel.frame.origin.y + self.ciLabel.frame.size.height + 5, 90, 30)];
    self.payLabel.text = @"付费方式:";
    self.payLabel.font = UIFont16;
    self.payLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.payLabel];
    
    self.payNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payLabel.frame.origin.x + self.payLabel.frame.size.width, self.payLabel.frame.origin.y, self.downImage.frame.size.width - self.payLabel.frame.origin.x - self.payLabel.frame.size.width - 10, 30)];
//    self.payNumLabel.text = @"公司地址";
    self.payNumLabel.font = UIFont16;
    self.payNumLabel.textColor = [UIColor blackColor];
    [self.downImage addSubview:self.payNumLabel];
    
    self.xianImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.payLabel.frame.origin.y + self.payLabel.frame.size.height + 5, self.downImage.frame.size.width - 20, 0.5)];
    self.xianImage.image = [UIImage imageNamed:@"bg_dotted_line"];
    [self.downImage addSubview:self.xianImage];

    
    self.teLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.xianImage.frame.origin.y + self.xianImage.frame.size.height + 5, 90, 30)];
    self.teLabel.text = @"特殊要求:";
    self.teLabel.font = UIFont16;
    self.teLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.teLabel];
    
    self.teNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.teLabel.frame.origin.y + self.teLabel.frame.size.height, self.downImage.frame.size.width - 20, 30)];
//    self.teNumLabel.text = @"公司地址公司地址公司地址公司地址公司地址公司地址公司地址公司地址公司地址公司地址公司地址公司地址";
    self.teNumLabel.font = UIFont16;
    self.teNumLabel.textColor = [UIColor blackColor];
    self.teNumLabel.numberOfLines = 0;
    [self.teNumLabel sizeToFit];
    [self.downImage addSubview:self.teNumLabel];


    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.downImage.frame.size.width - 160, self.teNumLabel.frame.origin.y + self.teNumLabel.frame.size.height + 5, 150, 30)];
//    self.timeLabel.text = @"2013-12-12 12:09:09";
    self.timeLabel.font = UIFont14;
    self.timeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.downImage addSubview:self.timeLabel];

    
    [self.downImage setFrame:CGRectMake(10, self.upView.frame.origin.y + self.upView.frame.size.height + 15, Main_Screen_Width - 20, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 5)];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setFrame:CGRectMake(20, self.downImage.frame.origin.y + self.downImage.frame.size.height + 30, screenWeith - 40, 40)];
    self.button.backgroundColor = ButtonColor;
    [self.button setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    [self.button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.backScrollView addSubview:self.button];

    
    self.backScrollView.contentSize = CGSizeMake(0, self.button.frame.origin.y + self.button.frame.size.height + 100);
    
    [self getData];
}

#pragma mark - AF:
- (void)getData{
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetOrderInfo Dat:@{@"order_id":self.idString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            self.model = [(NSArray *)result_data firstObject];
            NSLog(@"成功");
            
            [self fuZhi];
        } else {
            NSLog(@"失败");
        }
        [self hiddenHud];
    }];

}

- (void)fuZhi{
    
    NSLog(@"status_name ===== %@", self.model.status_name);
    
    if ([self.model.status_name isEqualToString:@"待审核"] || [self.model.status_name isEqualToString:@"审核失败"]) {
        [self.upView setFrame:CGRectMake(0, 0, Main_Screen_Width, 0)];
        self.rightButton.hidden = YES;

    }
    
    if ([self.model.status_name isEqualToString:@"待审核"] || [self.model.status_name isEqualToString:@"审核成功"] || [self.model.status_name isEqualToString:@"运输中"]) {
        self.button.hidden = NO;

    } else {
        self.button.hidden = YES;

    }

    
    if ([self.model.status_name isEqualToString:@"确认收货"]) {
        self.statusImage.image = [UIImage imageNamed:@"icon_confirmed"];
    } else if ([self.model.status_name isEqualToString:@"审核成功"]) {
        self.statusImage.image = [UIImage imageNamed:@"icon_succeed"];
        
    } else if ([self.model.status_name isEqualToString:@"审核失败"]) {
        self.statusImage.image = [UIImage imageNamed:@"icon_failed"];
    } else if ([self.model.status_name isEqualToString:@"运输中"]) {
        self.statusImage.image = [UIImage imageNamed:@"icon_transporting"];
    } else {
        self.statusImage.image = [UIImage imageNamed:@"icon_waiting"];
    }

    
    self.contentLabel.text = self.model.order_no;
    self.numNumLabel.text = self.model.order_no;
    self.weiNumLabel.text = self.model.company_name;
    self.faNumLabel.text = self.model.shipper;
    self.shouNumLabel.text = self.model.consignee;
    self.tongNumLabel.text = self.model.notifier;
    self.huoNumLabel.text = self.model.cargo;
    self.zhongNumLabel.text = self.model.weight;
    self.shuNumLabel.text = self.model.amount;
    self.tiNumLabel.text = self.model.volume;
    self.zhuangNumLabel.text = self.model.loading_port;
    
    self.xieNumLabel.text = self.model.unloading_port;
    self.muNumLabel.text = self.model.destination_port;
    self.chuTimeNumLabel.text = self.model.export_time;
    self.jietimeNumLabel.text = self.model.delivery_time;
    self.zhuangTimeNumLabel.text = self.model.loading_time;
    self.daoTimeNumLabel.text = self.model.arrive_time;
    self.chuanNumLabel.text = self.model.cargoboat_name;
    self.ciNumLabel.text = self.model.cargoboat_voyage_no;
    self.payNumLabel.text = self.model.payment_type;

    self.teNumLabel.text = self.model.special_requirements;
    self.timeLabel.text = self.model.add_time;
    
    self.teNumLabel.numberOfLines = 0;
    [self.teNumLabel sizeToFit];
    
    if (self.teNumLabel.frame.size.height <= 30) {
        [self.teNumLabel setFrame:CGRectMake(10, self.teLabel.frame.origin.y + self.teLabel.frame.size.height, self.downImage.frame.size.width - 20, 30)];
    }
    
    
    [self.timeLabel setFrame:CGRectMake(self.downImage.frame.size.width - 160, self.teNumLabel.frame.origin.y + self.teNumLabel.frame.size.height + 5, 150, 30)];
    
    
    [self.downImage setFrame:CGRectMake(10, self.upView.frame.origin.y + self.upView.frame.size.height + 15, Main_Screen_Width - 20, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 5)];
    
    [self.button setFrame:CGRectMake(20, self.downImage.frame.origin.y + self.downImage.frame.size.height + 30, screenWeith - 40, 40)];
    
    
    
    self.backScrollView.contentSize = CGSizeMake(0, self.button.frame.origin.y + self.button.frame.size.height + 100);
    
    

   
}


#pragma mark - Action:

- (void)map{
    
    HZOrderMapWayPointRouteViewController *mapVC = [[HZOrderMapWayPointRouteViewController alloc] init];
    mapVC.string = @"辽宁省大连市大连港";
    mapVC.string2 = @"河北省黄骅市黄骅港";
    [self pushVc:mapVC];
    
}

- (void)click:(UITapGestureRecognizer *)tap{
    HZOrderShadowViewController *shadowVC = [[HZOrderShadowViewController alloc] init];
    shadowVC.idString = self.idString;
    [self pushVc:shadowVC];
}


- (void)button:(UIButton *)button{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认要收货吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showHud];
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameOrderComplete Dat:@{@"order_id":self.idString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                NSLog(@"成功");
                [myToast showWithText:@"确认收货成功"];
                [self.shou shouDelegate];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"失败");
            }
            [self hiddenHud];
        }];
        
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

    
    
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
