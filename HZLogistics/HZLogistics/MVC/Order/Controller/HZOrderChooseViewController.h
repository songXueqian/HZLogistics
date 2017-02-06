//
//  HZOrderChooseViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@protocol TradeBackDelegate <NSObject>

- (void)tradeBack:(NSString *)cate_id order_byString:(NSString *)order_by;

@end


@interface HZOrderChooseViewController : BaseViewController
@property (nonatomic, assign)id<TradeBackDelegate>tradeBackDelegate;


@property (nonatomic, strong)UIImageView *firstImage;
@property (nonatomic, strong)UILabel *kindLabel;
@property (nonatomic, strong)UILabel *kindNumLabel;
@property (nonatomic, strong)UIImageView *secondImage;
@property (nonatomic, strong)UILabel *hotLabel;
@property (nonatomic, strong)UILabel *hotNumLabel;
@property (nonatomic, strong)UIImageView *thirdImage;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *priceNumLabel;

@property (nonatomic, strong)UIImageView *forthImage;
@property (nonatomic, strong)UILabel *areaLabel;
@property (nonatomic, strong)UILabel *areaNumLabel;
@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UIImageView *coinFirstImage;
@property (nonatomic, strong)UIImageView *coinSecondImage;
@property (nonatomic, strong)UIImageView *coinThirdImage;
@property (nonatomic, strong)UIImageView *coinForthImage;


@property (nonatomic, assign)NSInteger number;
@property (nonatomic, strong)NSString *kindString;
@property (nonatomic, strong)NSString *hotString;
@property (nonatomic, strong)NSString *priceString;
@property (nonatomic, strong)NSString *areaString;

@property (nonatomic, strong)UILabel *xianLabel;
@property (nonatomic, strong)NSString *addressString;
@property (nonatomic, strong)NSString *addressString2;


@end
