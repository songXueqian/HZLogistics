//
//  HZOrderDetailViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"
@protocol shouHuoDelegate <NSObject>

- (void)shouDelegate;

@end

@interface HZOrderDetailViewController : BaseViewController

@property (nonatomic, assign)id<shouHuoDelegate>shou;

@property (nonatomic, strong)UIScrollView *backScrollView;
@property (nonatomic, strong)UIButton *rightButton;//nav右按钮
@property (nonatomic, strong)UIView *upView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *xianLabel;
@property (nonatomic, strong)UIImageView *coinImage;
@property (nonatomic, strong)UIImageView *downImage;
@property (nonatomic, strong)UILabel *grayLabel;

@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIImageView *statusImage;

@property (nonatomic, strong)UILabel *numLabel;
@property (nonatomic, strong)UILabel *numNumLabel;

@property (nonatomic, strong)UILabel *weiLabel;
@property (nonatomic, strong)UILabel *weiNumLabel;

@property (nonatomic, strong)UILabel *faLabel;
@property (nonatomic, strong)UILabel *faNumLabel;

@property (nonatomic, strong)UILabel *shouLabel;
@property (nonatomic, strong)UILabel *shouNumLabel;

@property (nonatomic, strong)UILabel *tongLabel;
@property (nonatomic, strong)UILabel *tongNumLabel;

@property (nonatomic, strong)UILabel *huoLabel;
@property (nonatomic, strong)UILabel *huoNumLabel;

@property (nonatomic, strong)UILabel *zhongLabel;
@property (nonatomic, strong)UILabel *zhongNumLabel;

@property (nonatomic, strong)UILabel *shuLabel;
@property (nonatomic, strong)UILabel *shuNumLabel;

@property (nonatomic, strong)UILabel *tiLabel;
@property (nonatomic, strong)UILabel *tiNumLabel;

@property (nonatomic, strong)UILabel *zhuangLabel;
@property (nonatomic, strong)UILabel *zhuangNumLabel;


@property (nonatomic, strong)UILabel *xieLabel;
@property (nonatomic, strong)UILabel *xieNumLabel;

@property (nonatomic, strong)UILabel *muLabel;
@property (nonatomic, strong)UILabel *muNumLabel;

@property (nonatomic, strong)UILabel *chuTimeLabel;
@property (nonatomic, strong)UILabel *chuTimeNumLabel;

@property (nonatomic, strong)UILabel *jietimeLabel;
@property (nonatomic, strong)UILabel *jietimeNumLabel;


@property (nonatomic, strong)UILabel *zhuangTimeLabel;
@property (nonatomic, strong)UILabel *zhuangTimeNumLabel;

@property (nonatomic, strong)UILabel *daoTimeLabel;
@property (nonatomic, strong)UILabel *daoTimeNumLabel;

@property (nonatomic, strong)UILabel *chuanLabel;
@property (nonatomic, strong)UILabel *chuanNumLabel;

@property (nonatomic, strong)UILabel *ciLabel;
@property (nonatomic, strong)UILabel *ciNumLabel;

@property (nonatomic, strong)UILabel *payLabel;
@property (nonatomic, strong)UILabel *payNumLabel;

@property (nonatomic, strong)UILabel *teLabel;
@property (nonatomic, strong)UILabel *teNumLabel;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UILabel *danLabel;
@property (nonatomic, strong)UILabel *danLabel2;
@property (nonatomic, strong)UILabel *danLabel3;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *xianImage;

@property (nonatomic, strong)NSString *idString;
@end
