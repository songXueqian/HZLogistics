//
//  HZLoginViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZLoginViewController.h"
#import "HZCodeViewController.h"
#import "HZSMSViewController.h"
#import "HZRegisterViewController.h"
#import "LoginModel.h"
#import "UMessage.h"

@interface HZLoginViewController ()<getBacPwdDelegate>


@end

@implementation HZLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *phone = [[NSUserDefaults standardUserDefaults
                       ] objectForKey:@"a"];
    NSString *code = [[NSUserDefaults standardUserDefaults
                        ] objectForKey:@"b"];
    if (phone != nil) {
        self.phoneTextField.text = phone;
    }
    if (code != nil) {
        self.codeTextField.text = code;

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";

    
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    self.codeTextField.secureTextEntry = YES;
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 2;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

    
}


- (void)click:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginAction:(id)sender {
    
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [self alertTip:@"请输入手机号"];
    } else if ([self.codeTextField.text isEqualToString:@""]) {
        [self alertTip:@"请输入验证码"];

    } else {
        [self login];

    }

}



- (IBAction)registerAction:(id)sender {
    HZSMSViewController *registerVC = [[HZSMSViewController alloc] init];
    registerVC.number = 1;
    
    [self pushVc:registerVC];
}


- (IBAction)codeAction:(id)sender {
    HZSMSViewController *codeVC = [[HZSMSViewController alloc] init];
    codeVC.number = 2;
    [self pushVc:codeVC];

}


#pragma mark - 通知中心监测键盘出现和回收
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    
//    [UIView animateWithDuration:0.4f animations:^{
//        
//        if ([[UIScreen mainScreen] bounds].size.width == 320) {
//            self.view.frame = CGRectMake(0, -105, self.view.frame.size.width, self.view.frame.size.height);
//        } else {
//            self.view.frame = CGRectMake(0, -30, self.view.frame.size.width, self.view.frame.size.height);
//        }
//        
//    }];
//}

//当键盘隐藏的时候
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//    [UIView animateWithDuration:0.4f animations:^{
//        self.view.frame = CGRectMake(0, 65, self.view.bounds.size.width,  self.view.bounds.size.height);
//        
//    }];
//}

- (void)user:(NSString *)user passWord:(NSString *)passWord
{
    self.phoneTextField.text = user;
    self.codeTextField.text = passWord;
}

- (void)login
{
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameLogin Dat:@{@"ceilphone":self.phoneTextField.text, @"passwd":self.codeTextField.text} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
        
            NSLog(@"成功");
            
            LoginModel *model = [(NSArray *)result_data firstObject];

            
            [[NSUserDefaults standardUserDefaults] setObject:model.ceilphone forKey:@"ceilphone"];
            [[NSUserDefaults standardUserDefaults] setObject:self.codeTextField.text forKey:@"passwd"];
            
            [[NSUserDefaults standardUserDefaults] setObject:model.user_id forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] setObject:model.user_pwd forKey:@"user_pwd"];
            
            [[NSUserDefaults standardUserDefaults] setObject:model.company_id forKey:@"company_id"];
            [[NSUserDefaults standardUserDefaults] setObject:model.company_status forKey:@"company_status"];


            [self pushAction];
            
            [self.infomationDelegate personInfomation];
            [myToast showWithText:@"登录成功"];

            [self.navigationController popViewControllerAnimated:YES];
            
       } else {
            NSLog(@"失败");
            NSString *message = [[(NSError *)result_data userInfo] objectForKey:NSLocalizedDescriptionKey];
            [self alertTip:message];
        }
        [self hiddenHud];
    }];
}

- (void)pushAction
{
    NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    
    if (tokenString != nil) {
        
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameSaveChannelId Dat:@{@"token":tokenString, @"device":@"ios"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                NSLog(@"推送接口成功");
            } else {
                NSLog(@"推送接口失败");
            }
        }];
        
    }

}



- (void)alertTip:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    //    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //
    //
    //    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
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
