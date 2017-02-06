//
//  HZOrderTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZOrderTableViewCell.h"
#import "Type.h"


@implementation HZOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.backImage setImage:[UIImage imageNamed:@"backFrame.png"]];
        [self.contentView addSubview:_backImage];
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectZero];
//        self.icon.backgroundColor = [UIColor yellowColor];
        [self.backImage addSubview:_icon];
        
        self.titile = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titile.font = [UIFont systemFontOfSize:15];
        self.titile.textColor = [UIColor colorWithRed:0.52 green:0.56 blue:0.57 alpha:1.00];
        [self.backImage addSubview:_titile];
        
        
        _xianLabel = [[UILabel alloc] init];
        _xianLabel.backgroundColor = [UIColor lightGrayColor];
        [self.backImage addSubview:_xianLabel];
        
        self.chuFaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.chuFaLabel.font = [UIFont systemFontOfSize:16];
        [self.backImage addSubview:self.chuFaLabel];
        
        self.toLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.toLabel.font = [UIFont systemFontOfSize:16];
        [self.backImage addSubview:self.toLabel];

        self.chuFaImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.chuFaImage.image = [UIImage imageNamed:@"icon_goods_name"];
        [self.backImage addSubview:self.chuFaImage];

        self.toImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.toImage.image = [UIImage imageNamed:@"icon_location"];
        [self.backImage addSubview:self.toImage];

        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor colorWithRed:0.52 green:0.56 blue:0.57 alpha:1.00];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.backImage addSubview:self.timeLabel];

        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backImage setFrame:CGRectMake(10, 0, Main_Screen_Width - 20, 115)];
    
    [self.icon setFrame:CGRectMake(self.backImage.frame.size.width - 60 - 10, 5, 60, 25)];
    
    [self.titile setFrame:CGRectMake(10, 2.5, 200, 30)];
    
    
    [self.xianLabel setFrame:CGRectMake(10, 35, _backImage.frame.size.width - 20, 0.5)];
    
    [self.chuFaImage setFrame:CGRectMake(10, self.xianLabel.frame.origin.y + self.xianLabel.frame.size.height + 10, 20, 20)];
    [self.chuFaLabel setFrame:CGRectMake(self.chuFaImage.frame.origin.x + self.chuFaImage.frame.size.width + 5, self.chuFaImage.frame.origin.y - 5, 200, 30)];
    [self.toImage setFrame:CGRectMake(10, self.chuFaLabel.frame.origin.y + self.chuFaLabel.frame.size.height + 5, 20, 20)];
    [self.toLabel setFrame:CGRectMake(self.toImage.frame.origin.x + self.toImage.frame.size.width + 5, self.toImage.frame.origin.y - 5, 200, 30)];
    [self.timeLabel setFrame:CGRectMake(self.backImage.frame.size.width - 200, self.toLabel.frame.origin.y + self.toLabel.frame.size.height - 20, 190, 30)];
    
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
