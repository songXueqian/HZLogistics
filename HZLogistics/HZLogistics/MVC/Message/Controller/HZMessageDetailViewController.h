//
//  HZMessageDetailViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"


@protocol messageDelegate <NSObject>

- (void)seeMessage;

@end


@interface HZMessageDetailViewController : BaseViewController<UITextViewDelegate>

@property (nonatomic, assign)id<messageDelegate>message;

@property (nonatomic, strong)UIScrollView *backScrollView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *xianLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)NSString *idString;
@property (nonatomic, strong)NSString *statuString;

@end
