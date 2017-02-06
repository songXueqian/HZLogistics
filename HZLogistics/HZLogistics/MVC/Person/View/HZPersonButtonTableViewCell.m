//
//  HZPersonButtonTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZPersonButtonTableViewCell.h"

@implementation HZPersonButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_backImage];
//        
//        self.photoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_photoImage];
//        
//        self.titile = [[UILabel alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_titile];
//        
//        self.phone = [[UILabel alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_phone];
//        
//        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        _xianLabel = [[UILabel alloc] init];
//        _xianLabel.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_xianLabel];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self.backImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [self.backImage setImage:[UIImage imageNamed:@"strip.png"]];
//    
//    [self.photoImage setFrame:CGRectMake(15, 15, 60, 60)];
//    
//    [self.titile setFrame:CGRectMake(self.photoImage.frame.size.width + self.photoImage.frame.origin.x + 10, self.photoImage.frame.origin.y, 200, 30)];
//    [self.phone setFrame:CGRectMake(self.titile.frame.origin.x, self.titile.frame.size.height + self.titile.frame.origin.y, 200, 30)];
//    
//    [self.xianLabel setFrame:CGRectMake(0, _backImage.frame.size.height - 0.5, _backImage.frame.size.width, 0.5)];
    
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
