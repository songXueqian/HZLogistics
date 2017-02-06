//
//  HZRegisterViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZRegisterViewController.h"
#import "HZLoginViewController.h"
#import "RegistUserModel.h"

@interface HZRegisterViewController ()

@end

@implementation HZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    
    self.phoneTextField.delegate = self;
    self.miMaTextField.delegate = self;
    self.miMaAgaTextField.delegate = self;
    self.nameTextField.delegate = self;
    
    self.miMaTextField.secureTextEntry = YES;
    self.miMaAgaTextField.secureTextEntry = YES;
    
    
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.layer.cornerRadius = 5;
    
    
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
- (IBAction)codeAction:(id)sender {
    
    [self registUser];
    
}



- (void)registUser
{
    
    
    if ([self.nameTextField.text isEqualToString:@""] || self.nameTextField.text == nil) {
        [self alertTip:@"请输入姓名"];
        return;
    }
    
    if ([self.miMaTextField.text isEqualToString:@""] || self.miMaTextField.text == nil) {
        [self alertTip:@"请输入密码"];
        return;
    }
    
    if ([self.miMaAgaTextField.text isEqualToString:@""] || self.miMaAgaTextField.text == nil) {
        [self alertTip:@"请输入确认密码"];
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
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否注册" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showHud];
        
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameRegistUser Dat:@{@"ceilphone":self.phoneTextField.text, @"passwd":self.miMaTextField.text, @"user_name":self.nameTextField.text} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            
            

            if (result_status == ApiStatusSuccess) {
                
                RegistUserModel *model = [(NSArray *)result_data firstObject];
            
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"a"];
                [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextField.text forKey:@"b"];
                
                [myToast showWithText:@"注册成功"];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                
            } else {
                NSLog(@"失败");
                NSString *message = [[(NSError *)result_data userInfo] objectForKey:NSLocalizedDescriptionKey];
                [self alertTip:message];
                
                
            }
            [self hiddenHud];
        }];
        
        
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
