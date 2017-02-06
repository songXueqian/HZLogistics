
//
//  HZHomeChooseTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZHomeChooseTableViewCell.h"
#import "Type.h"

@implementation HZHomeChooseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_backImage];
        
        
        self.titile = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titile.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titile];
        
        //        self.grayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        //        [self.contentView addSubview:_grayLabel];
        
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _xianLabel = [[UILabel alloc] init];
        _xianLabel.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_xianLabel];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.backImage setImage:[UIImage imageNamed:@"strip.png"]];
    
    [self.titile setFrame:CGRectMake(10, 7.5, 200, 30)];
    
    
    [self.xianLabel setFrame:CGRectMake(0, _backImage.frame.size.height - 0.5, _backImage.frame.size.width, 0.5)];
    
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
