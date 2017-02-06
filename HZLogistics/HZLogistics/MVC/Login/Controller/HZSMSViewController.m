//
//  HZSMSViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZSMSViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "HZRegisterViewController.h"
#import "HZCodeViewController.h"

@interface HZSMSViewController ()

@end

@implementation HZSMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"获取验证码";
    self.second = 60;
    
    
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.cornerRadius = 5;
    
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.layer.cornerRadius = 5;
    
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

- (IBAction)codeAction:(id)sender {
    [self.view endEditing:YES];
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入电话号码"];
        return;
    }
    if (self.phoneTextField.text.length < 11 || self.phoneTextField.text.length > 11) {
        [myToast showWithText:@"请输入正确的手机号"];
        return;
    }
    
    
    
    [self.codeButton setTitle:@"60s" forState:UIControlStateNormal];
    [self.codeButton setUserInteractionEnabled:NO];
    [self.codeButton setBackgroundColor:ButtonColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondAction) userInfo:nil repeats:YES];
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error){
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
    
    
    
}



- (void)secondAction
{
    self.second = self.second - 1;
    
    [self.codeButton setTitle:[NSString stringWithFormat:@"%lds", (long)self.second] forState:UIControlStateNormal];
    
    if (self.second == 0) {
        [self.timer invalidate];
        self.second = 60;
        [self.codeButton setUserInteractionEnabled:YES];
        self.codeButton.backgroundColor = ButtonColor;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }
}



- (IBAction)commitAction:(id)sender {
    [self.view endEditing:YES];
    if ([self.phoneTextField.text isEqualToString:@""] && [self.codeTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"手机号和验证码不能为空"];
    } else if ([self.phoneTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"手机号不能为空"];
    } else if ([self.codeTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"验证码不能为空"];
    } else {
        
        
        [SMSSDK commitVerificationCode:self.codeTextField.text phoneNumber:self.phoneTextField.text zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                HZRegisterViewController *reVC = [HZRegisterViewController new];
                reVC.phoneString = self.phoneTextField.text;
                [self pushVc:reVC];
                NSLog(@"验证成功");
            } else {
             NSLog(@"错误信息：%@",error);
            }
            
         }];
        
        
    }
    
    
    
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
