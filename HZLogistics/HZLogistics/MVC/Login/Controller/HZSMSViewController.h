//
//  HZSMSViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZSMSViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, assign) NSInteger number;

@end
