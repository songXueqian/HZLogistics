//
//  HZRegisterViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"




@interface HZRegisterViewController : BaseViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *miMaTextField;
@property (weak, nonatomic) IBOutlet UITextField *miMaAgaTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong)NSString *phoneString;


@end
