//
//  HZOrderShadowTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderShadowTableViewCell.h"

@implementation HZOrderShadowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = [UIColor redColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_titleLabel];
        
        _yuanImage = [[UIImageView alloc] init];
        _yuanImage.userInteractionEnabled  = YES;
        [self.contentView addSubview:_yuanImage];
        
        _xianImage = [[UIImageView alloc] init];
        _xianImage.userInteractionEnabled  = YES;
        _xianImage.image = [UIImage imageNamed:@"img_search_background"];
        [self.contentView addSubview:_xianImage];
        
        _xianImage2 = [[UIImageView alloc] init];
        _xianImage2.userInteractionEnabled  = YES;
        _xianImage2.image = [UIImage imageNamed:@"img_search_background"];
        [self.contentView addSubview:_xianImage2];

        
        
        _portLabel = [[UILabel alloc] init];
        _portLabel.font = [UIFont systemFontOfSize:15];
//        _portLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_portLabel];
        
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:15];
//        _numberLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_numberLabel];
        

        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel setFrame:CGRectMake(10, (self.contentView.frame.size.height - 30) / 2 - 5, 80, 30)];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    if (self.titleLabel.frame.size.height <= 30) {
        [self.titleLabel setFrame:CGRectMake(10, (self.contentView.frame.size.height - 30) / 2 - 5, 80, 30)];
    }

    
    [self.yuanImage setFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 5, self.titleLabel.frame.origin.y + 7.5, 15, 15)];
    
    [self.xianImage setFrame:CGRectMake(self.yuanImage.frame.origin.x + 6.5, self.yuanImage.frame.origin.y + self.yuanImage.frame.size.height, 3, self.contentView.frame.size.height - self.yuanImage.frame.origin.y - self.yuanImage.frame.size.height)];
    [self.xianImage2 setFrame:CGRectMake(self.xianImage.frame.origin.x, 0, 3, self.yuanImage.frame.origin.y)];
    
    
    [self.portLabel setFrame:CGRectMake(self.yuanImage.frame.origin.x + self.yuanImage.frame.size.width + 5, 0, [UIScreen mainScreen].bounds.size.width - self.yuanImage.frame.origin.x - self.yuanImage.frame.size.width - 15, 20)];
    
    [self.numberLabel setFrame:CGRectMake(self.portLabel.frame.origin.x, self.portLabel.frame.origin.y + self.portLabel.frame.size.height, self.portLabel.frame.size.width, 30)];
    self.numberLabel.numberOfLines = 0;
    [self.numberLabel sizeToFit];
    
    if (self.numberLabel.frame.size.height <= 30) {
        [self.numberLabel setFrame:CGRectMake(self.portLabel.frame.origin.x, self.portLabel.frame.origin.y + self.portLabel.frame.size.height, self.portLabel.frame.size.width, 30)];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
