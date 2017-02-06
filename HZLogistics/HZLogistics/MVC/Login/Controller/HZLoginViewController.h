//
//  HZLoginViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"
@protocol infomationDelegate <NSObject>

- (void)personInfomation;

@end


@interface HZLoginViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, assign)  id<infomationDelegate>infomationDelegate;


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *findCode;

@end
