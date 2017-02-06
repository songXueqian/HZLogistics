//
//  HZMessageDetailViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZMessageDetailViewController.h"
#import "GetSysMsgInfoModel.h"

@interface HZMessageDetailViewController ()
@property (nonatomic, strong)GetSysMsgInfoModel *model;
@end

@implementation HZMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"消息详情";
    self.view.backgroundColor = BackgroundColor;
    
    
    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, screenHeight)];
    _backScrollView.showsVerticalScrollIndicator = NO;
    _backScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backScrollView];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_backScrollView addSubview:_titleLabel];
    
    
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 190, _titleLabel.frame.size.height + _titleLabel.frame.origin.y, 180, 25)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [_backScrollView addSubview:_timeLabel];
    
    _statusLabel = [[UILabel alloc] init];
    [_statusLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _timeLabel.frame.origin.y, 180, 25)];
    _statusLabel.font = [UIFont systemFontOfSize:14];
    _statusLabel.textColor = [UIColor grayColor];
    [_backScrollView addSubview:_statusLabel];

    
    
    _xianLabel = [[UILabel alloc] init];
    [_xianLabel setFrame:CGRectMake(10, _timeLabel.frame.origin.y + _timeLabel.frame.size.height, [[UIScreen mainScreen] bounds].size.width - 20, 1)];
    _xianLabel.backgroundColor = [UIColor lightGrayColor];;
    [_backScrollView addSubview:_xianLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, _xianLabel.frame.origin.y + _xianLabel.frame.size.height, [[UIScreen mainScreen] bounds].size.width - 20, screenHeight)];
    _textView.delegate = self;
    _textView.editable = NO;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.textColor = [UIColor grayColor];
    _textView.dataDetectorTypes = UIDataDetectorTypeAll;
    [_backScrollView addSubview:_textView];
    _backScrollView.contentSize = CGSizeMake(0, _textView.frame.origin.y + _textView.frame.size.height + 100);
    
    [self getData];

}


#pragma mark - AF:接口
- (void)getData{
    
    if (self.idString == nil) {
        self.idString = @"0";
    }
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetSysMsgInfo Dat:@{@"msg_id":self.idString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            self.model = [(NSArray *)result_data firstObject];
            _timeLabel.text = self.model.add_time;
            _titleLabel.text = self.model.msg_title;
            _textView.text = self.model.msg_content;
            
            if ([self.statuString isEqualToString:@"personal"]) {
                _statusLabel.text = @"个人";

            } else {
                _statusLabel.text = @"系统";

            }
            
        } else {
            NSLog(@"失败");
        }
        [self hiddenHud];
    }];
    
}

- (void)LeftAction
{
    [self.message seeMessage];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
