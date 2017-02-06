//
//  HZCodeViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZCodeViewController.h"

@interface HZCodeViewController ()

@end

@implementation HZCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"找回密码";
    
    self.phoneTextField.delegate = self;
    self.miMaTextField.delegate = self;
    self.miMaAgaTextField.delegate = self;
    
    self.miMaTextField.secureTextEntry = YES;
    self.miMaAgaTextField.secureTextEntry = YES;
    
    
    
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.cornerRadius = 5;
    
//    self.regButton.hidden = YES;
//    self.forButton.hidden = YES;
    
    self.phoneTextField.text = self.phoneString;
    self.phoneTextField.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];

}


- (void)click:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if ([[UIScreen mainScreen] bounds].size.width == 320) {
        
        if (textField == self.miMaTextField || textField == self.miMaAgaTextField) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
        }
        
    }
}
- (IBAction)commitAction:(id)sender {
    [self getBackPwd];

}



#pragma mark - 通知中心监测键盘出现和回收
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    [UIView animateWithDuration:0.4f animations:^{
        
        if ([[UIScreen mainScreen] bounds].size.width == 320) {
            self.view.frame = CGRectMake(0, -55, self.view.frame.size.width, self.view.frame.size.height);
        } else {
            self.view.frame = CGRectMake(0, -30, self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.01f animations:^{
        self.view.frame = CGRectMake(0, 65, self.view.bounds.size.width,  self.view.bounds.size.height);
    }];
}



- (void)getBackPwd
{
    
    
//    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text == nil) {
//        [self alertTip:@"请输入手机号"];
//        return;
//    }
    
    
    if ([self.miMaTextField.text isEqualToString:@""] || self.miMaTextField.text == nil) {
        [self alertTip:@"请输入密码"];
        return;
    }
    
    if ([self.miMaAgaTextField.text isEqualToString:@""] || self.miMaAgaTextField.text == nil) {
        [self alertTip:@"请确认密码"];
        return;
    }
    
    
    if (self.miMaTextField.text.length >= 16) {
        [self alertTip:@"密码不能大于16位"];
        return;
    }
    
    if (![self.miMaTextField.text isEqualToString:self.miMaAgaTextField.text]) {
        [self alertTip:@"两次输入密码不同"];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要修改密码?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self showHud];
        
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetBackPwd Dat:@{@"ceilphone":self.phoneTextField.text, @"passwd":self.miMaTextField.text} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                
                NSLog(@"成功");                
                [myToast showWithText:@"修改密码成功"];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                
                
            } else {
                NSLog(@"失败");
                NSString *message = [[(NSError *)result_data userInfo] objectForKey:NSLocalizedDescriptionKey];
                [self alertTip:message];
                
                
            }
            [self hiddenHud];
        }];

        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

    
    
    
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
