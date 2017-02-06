
//  HZHomeViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZHomeViewController.h"
#import "ZHPickView.h"
#import "HZHomeChooseViewController.h"
#import "HZPersonCheckViewController.h"
#import "HZLoginViewController.h"
#import "LoginModel.h"
#import "GetPayTypeListModel.h"
#import "HZPersonCheckSuccessViewController.h"
#import "GetUserInfoModel.h"
@interface HZHomeViewController ()<ZHPickViewDelegate, addressStringDelegate>
@property (nonatomic, strong)ZHPickView *pickView;
@property (nonatomic, strong)NSString *string;
@end

@implementation HZHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetUserInfo Dat:@{} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            GetUserInfoModel *model = [(NSArray *)result_data firstObject];
            
            NSString *string = model.company_status;
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"company_status"];
            
        } else {
            
            NSLog(@"失败");
        }
        
        [self hiddenHud];
        
    }];

}

- (void)autoLogin
{
    
    NSString *ceil_phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"ceilphone"];
    
    NSString *passwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwd"];
    
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameLogin Dat:@{@"ceilphone":ceil_phone, @"passwd":passwd} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            
            NSLog(@"成功");
            [self pushAction];
            [myToast showWithText:@"自动登录成功~~~"];
            
            
            
        } else {
            NSLog(@"失败");
                       
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
    } else {
        //有user_id自动登录
        [self autoLogin];
    }
    
    self.payString = @"";
    self.dataArray = [NSMutableArray array];
    self.navigationItem.title = @"下单";
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.cornerRadius = 5;
    
    self.faHuoTextField.delegate = self;
    self.shouHuoTextField.delegate = self;
    self.tongZhiTextField.delegate = self;
    self.huoMingTextField.delegate = self;
    self.numTextField.delegate = self;
    self.zhongLiangTextField.delegate = self;
    self.tiJiTextField.delegate = self;
    self.specialLabelTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tapPick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPick:)];
    [self.payLabel addGestureRecognizer:tapPick];
    
    
    UITapGestureRecognizer *tapMuDi = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMuDi:)];
    [self.muDiLabel addGestureRecognizer:tapMuDi];
    
    
    UITapGestureRecognizer *tapZhuangHuo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapZhuangHuo:)];
    [self.zhuangHuoLabel addGestureRecognizer:tapZhuangHuo];
    
    [self getData];
    
}


- (void)getData{
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNamePayTypeList Dat:@{} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        
        
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            
            NSMutableArray *array = [NSMutableArray array];
            self.dataArray = (NSMutableArray *)result_data;
            
            for (GetPayTypeListModel *payTypeListModel in self.dataArray) {
                [array addObject:payTypeListModel.value];
            }
            
            self.pickView =[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
            self.pickView.delegate = self;
            
            
        } else {
            NSLog(@"失败");
        }
        [self hiddenHud];
    }];
    
}




- (void)click:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)tapMuDi:(UITapGestureRecognizer *)tap{
    
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请先进行登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZLoginViewController new]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        
    }
    
    NSString *company_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_status"];
    
    if ([company_status isEqualToString:@"inactive"] || [company_status isEqualToString:@"faild"]) {
        
        HZPersonCheckSuccessViewController *checkVC = [HZPersonCheckSuccessViewController new];
        [self pushVc:checkVC];
        
    } else if ([company_status isEqualToString:@"active"]) {
        [_pickView remove];
        [self.view endEditing:YES];
        HZHomeChooseViewController *chooseVC =[[HZHomeChooseViewController alloc] init];
        chooseVC.message = self;
        chooseVC.number = 2;
        [self pushVc:chooseVC];
    } else {
        
        //if (通过认证)
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"请先进行企业认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"企业认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZPersonCheckViewController new]];
        }]];
        
        [self presentViewController:alertController2 animated:YES completion:^{
            
        }];
        
        
    }
}

- (void)tapZhuangHuo:(UITapGestureRecognizer *)tap{
    
    
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请先进行登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZLoginViewController new]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        
    }
    
    NSString *company_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_status"];
    
    if ([company_status isEqualToString:@"inactive"] || [company_status isEqualToString:@"faild"]) {
        
        HZPersonCheckSuccessViewController *checkVC = [HZPersonCheckSuccessViewController new];
        [self pushVc:checkVC];
        
    } else if ([company_status isEqualToString:@"active"]) {
        [_pickView remove];
        [self.view endEditing:YES];
        
        HZHomeChooseViewController *chooseVC =[[HZHomeChooseViewController alloc] init];
        chooseVC.message = self;
        chooseVC.number = 1;
        [self pushVc:chooseVC];
    } else {
        
        //if (通过认证)
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"请先进行企业认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"企业认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZPersonCheckViewController new]];
        }]];
        
        [self presentViewController:alertController2 animated:YES completion:^{
            
        }];
        
        
    }
    
    
}

- (void)addresString:(NSString *)string id:(NSString *)idString differentNum:(NSInteger)number{
    if (1 == number) {
        self.zhuangHuoLabel.text = string;
        self.zhuangHuoLabel.textColor = [UIColor blackColor];
        self.cityString = idString;
    } else {
        self.muDiLabel.text = string;
        self.muDiLabel.textColor = [UIColor blackColor];
        self.cityString = idString;
        
    }
}

- (void)tapPick:(UITapGestureRecognizer *)tap{
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请先进行登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZLoginViewController new]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        
    }
    
    NSString *company_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_status"];
    
    if ([company_status isEqualToString:@"inactive"] || [company_status isEqualToString:@"faild"]) {
        
        HZPersonCheckSuccessViewController *checkVC = [HZPersonCheckSuccessViewController new];
        [self pushVc:checkVC];
        
    } else if ([company_status isEqualToString:@"active"]) {
        [self.view endEditing:YES];
        
        if (_pickView.isShow) {
            
            [_pickView remove];
        }
        else {
            [self.view endEditing:YES];
            [_pickView showInView:self.view];
        }
        
    } else {
        
        //if (通过认证)
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"请先进行企业认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"企业认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZPersonCheckViewController new]];
        }]];
        
        [self presentViewController:alertController2 animated:YES completion:^{
            
        }];
        
        
    }
}


- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    self.payLabel.text = resultString;
    self.payLabel.textColor = [UIColor  blackColor];
    
    
    
    if ([resultString isEqualToString:@"公司转账"]) {
        self.payString = @"b2b";
    } else {
        self.payString = @"online";
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"222");
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请先进行登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZLoginViewController new]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        
    }
    
    NSString *company_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_status"];
    
    if ([company_status isEqualToString:@"inactive"] || [company_status isEqualToString:@"faild"]) {
        
        HZPersonCheckSuccessViewController *checkVC = [HZPersonCheckSuccessViewController new];
        [self pushVc:checkVC];
        
    } else if ([company_status isEqualToString:@"active"]) {
        [self.pickView remove];
        return YES;
    } else {
        
        //if (通过认证)
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"请先进行企业认证" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"企业认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self pushVc:[HZPersonCheckViewController new]];
        }]];
        
        [self presentViewController:alertController2 animated:YES completion:^{
            
        }];
        
        
    }
    
    
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"111");
    
    
}







- (IBAction)commitAction:(id)sender {
    
    if ([self.faHuoTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入发货人"];
    } else if ([self.shouHuoTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入收货人"];
    } else if ([self.tongZhiTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入通知人"];
    } else if ([self.huoMingTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入货名"];
    } else if ([self.numTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入数量"];
    } else if ([self.zhongLiangTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入重量"];
    } else if ([self.tiJiTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入体积"];
    } else if ([self.zhuangHuoLabel.text isEqualToString:@"请选择装货港"]) {
        [myToast showWithText:@"请选择装货港"];
    } else if ([self.muDiLabel.text isEqualToString:@"请选择目的港"]) {
        [myToast showWithText:@"请选择目的港"];
    } else if ([self.specialLabelTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入特殊要求"];
    } else if ([self.payLabel.text isEqualToString:@"请选择支付方式"]) {
        [myToast showWithText:@"请选择支付方式"];
    } else {
        [self commitData];
    }
    
}

- (void)commitData{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要下单吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showHud];
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameSubOrder Dat:@{@"shipper":self.faHuoTextField.text, @"consignee":self.shouHuoTextField.text, @"notifier":self.tongZhiTextField.text, @"cargo":self.huoMingTextField.text, @"amount":self.numTextField.text, @"weight":self.zhongLiangTextField.text, @"volume":self.tiJiTextField.text, @"loading_port":self.cityString, @"destination_port":self.cityString2, @"special_requirements":self.specialLabelTextField.text, @"payment_type":self.payString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                NSLog(@"成功");
                [myToast showWithText:@"下单成功"];
                
                self.faHuoTextField.text = @"";
                self.shouHuoTextField.text = @"";
                self.tongZhiTextField.text = @"";
                self.huoMingTextField.text = @"";
                self.numTextField.text = @"";
                self.zhongLiangTextField.text = @"";
                self.tiJiTextField.text = @"";
                self.zhuangHuoLabel.text = @"请选择装货港";
                self.muDiLabel.text = @"请选择目的港";
                self.specialLabelTextField.text = @"";
                self.payLabel.text = @"请选择支付方式";
                self.payLabel.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];
                self.zhuangHuoLabel.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];
                self.muDiLabel.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.82 alpha:1.00];

            } else {
                NSLog(@"失败");
            }
            [self hiddenHud];
        }];
        
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
    
    
    
    
    
}

- (void)addresString:(NSString *)string idS:(NSString *)idString differentNum:(NSInteger)number{
    if (1 == number) {
        self.zhuangHuoLabel.text = string;
        self.zhuangHuoLabel.textColor = [UIColor blackColor];
        self.cityString = idString;
    } else {
        self.muDiLabel.text = string;
        self.muDiLabel.textColor = [UIColor blackColor];
        self.cityString2 = idString;
        
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
