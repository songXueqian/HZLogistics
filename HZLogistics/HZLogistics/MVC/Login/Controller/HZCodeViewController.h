//
//  HZCodeViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"
@protocol getBacPwdDelegate <NSObject>

- (void)user:(NSString *)user passWord:(NSString *)passWord;

@end

@interface HZCodeViewController : BaseViewController<UITextFieldDelegate>


@property (nonatomic, assign)  id<getBacPwdDelegate>registDelegate;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;


@property (weak, nonatomic) IBOutlet UITextField *miMaTextField;

@property (weak, nonatomic) IBOutlet UITextField *miMaAgaTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (nonatomic, strong)NSString *phoneString;


@end
