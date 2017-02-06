//
//  HZPersonCheckSuccessViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZPersonCheckSuccessViewController : BaseViewController

@property (nonatomic, strong)UIScrollView *backScrollView;
@property (nonatomic, strong)UIImageView *statusImage;
@property (nonatomic, strong)UIImageView *upImage;
@property (nonatomic, strong)UIImageView *upStatusImage;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UIImageView *downImage;

@property (nonatomic, strong)UILabel *comLabel;
@property (nonatomic, strong)UILabel *comNumLabel;

@property (nonatomic, strong)UILabel *regLabel;
@property (nonatomic, strong)UILabel *regNumLabel;

@property (nonatomic, strong)UILabel *addLabel;
@property (nonatomic, strong)UILabel *addNumLabel;

@property (nonatomic, strong)UILabel *numLabel;
@property (nonatomic, strong)UILabel *numNumLabel;

@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *timeNumLabel;

@property (nonatomic, strong)UILabel *yeWuLabel;
@property (nonatomic, strong)UILabel *yeWuNumLabel;

@property (nonatomic, strong)UILabel *faRenLabel;
@property (nonatomic, strong)UILabel *faRenNumLabel;

@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *contentNumLabel;

@property (nonatomic, strong)UILabel *workLabel;
@property (nonatomic, strong)UILabel *workNumLabel;

@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *phoneNumLabel;

@property (nonatomic, strong)UILabel *idLabel;
@property (nonatomic, strong)UILabel *idNumLabel;

@property (nonatomic, strong)UILabel *photoLabel;
@property (nonatomic, strong)UIImageView *photoImage;

@property (strong, nonatomic)UIButton *commitButton;

@end
