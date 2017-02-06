//
//  HZMessageTableViewCell.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/17.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZMessageTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *picImage;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *detailLabel;

@end
