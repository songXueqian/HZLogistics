//
//  HZOrderChooseTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderChooseTableViewCell.h"

@implementation HZOrderChooseTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _backImage = [[UIImageView alloc] init];
        _backImage.userInteractionEnabled  = YES;
        _backImage.image = [UIImage imageNamed:@"backFrame.png"];
        [self.contentView addSubview:_backImage];
        
        self.yuanImage = [[UIImageView alloc] init];
        self.yuanImage.userInteractionEnabled = YES;
//        self.yuanImage.backgroundColor = [UIColor lightGrayColor];
        self.yuanImage.image = [UIImage imageNamed:@"btn_pass"];
        [_backImage addSubview:self.yuanImage];
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.font = [UIFont systemFontOfSize:18];
        [_backImage addSubview:_dataLabel];
        
    }
    return self;
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backImage setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    [self.yuanImage setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 15, 20, 20)];
    self.yuanImage.layer.masksToBounds = YES;
    self.yuanImage.layer.cornerRadius = self.yuanImage.frame.size.width / 2;
    
    [self.dataLabel setFrame:CGRectMake(10, 10, 200, 30)];
    
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
