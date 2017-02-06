//
//  HZOrderTableViewCell.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZOrderTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titile;
@property (nonatomic, strong) UILabel *xianLabel;

@property (nonatomic, strong) UILabel *chuFaLabel;
@property (nonatomic, strong) UILabel *toLabel;
@property (nonatomic, strong) UIImageView *chuFaImage;
@property (nonatomic, strong) UIImageView *toImage;
@property (nonatomic, strong) UILabel *timeLabel;

@end
