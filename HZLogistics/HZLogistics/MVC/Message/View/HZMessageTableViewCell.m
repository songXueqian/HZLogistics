//
//  HZMessageTableViewCell.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/17.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZMessageTableViewCell.h"

@implementation HZMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _picImage = [[UIImageView alloc] init];
        _picImage.userInteractionEnabled  = YES;
        _picImage.image = [UIImage imageNamed:@"backFrame.png"];
        [self.contentView addSubview:_picImage];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_picImage addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_picImage addSubview:_timeLabel];
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UIColor lightGrayColor];
        [_picImage addSubview:_detailLabel];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_picImage setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.contentView.frame.size.height)];
    [_titleLabel setFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, 30)];
    [_timeLabel setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 195, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, 180, 30)];
    [_detailLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _timeLabel.frame.origin.y, 100, 30)];
    
    

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
