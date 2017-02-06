//
//  HZOrderChooseViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderChooseViewController.h"
#import "HZOrderChooseTableViewController.h"

@interface HZOrderChooseViewController ()<BackScriptDelegate>

@end

@implementation HZOrderChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"筛选";
    //设置右按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(70, 35, 50, 20.25)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    _firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, screenWeith, 50)];
    _firstImage.userInteractionEnabled  = YES;
    _firstImage.image = [UIImage imageNamed:@"backFrame.png"];
    [self.view addSubview:_firstImage];
    
    _kindLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 30)];
    _kindLabel.text = @"  状态 :";
    _kindLabel.textColor = [UIColor colorWithRed:0.52 green:0.56 blue:0.57 alpha:1.00];
    [_firstImage addSubview:_kindLabel];
    
    _coinFirstImage = [[UIImageView alloc] initWithFrame:CGRectMake(screenWeith - 25, 17.5, 15, 15)];
    _coinFirstImage.userInteractionEnabled  = YES;
    _coinFirstImage.image = [UIImage imageNamed:@"right.png"];
    [_firstImage addSubview:_coinFirstImage];
    
    _kindNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWeith - 30 - 5 - 150, 10, 150, 30)];
    _kindNumLabel.text = @"全部";
    _kindString = @"";
    _kindNumLabel.textAlignment = NSTextAlignmentRight;
    [_firstImage addSubview:_kindNumLabel];
    
    _secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _firstImage.frame.origin.y + _firstImage.frame.size.height, screenWeith, 50)];
    _secondImage.userInteractionEnabled  = YES;
    _secondImage.image = [UIImage imageNamed:@"backFrame.png"];
    [self.view addSubview:_secondImage];
    
    _hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 30)];
    _hotLabel.text = @"  目的港 :";
    _hotLabel.textColor = [UIColor colorWithRed:0.52 green:0.56 blue:0.57 alpha:1.00];
    [_secondImage addSubview:_hotLabel];
    
    _coinSecondImage = [[UIImageView alloc] initWithFrame:CGRectMake(screenWeith - 25, 17.5, 15, 15)];
    _coinSecondImage.userInteractionEnabled  = YES;
    _coinSecondImage.image = [UIImage imageNamed:@"right.png"];
    [_secondImage addSubview:_coinSecondImage];
    
    _hotNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWeith - 30 - 5 - 190, 10, 190, 30)];
    _hotNumLabel.text = @"全部";
    _hotString = @"";
    _hotNumLabel.textAlignment = NSTextAlignmentRight;
    [_secondImage addSubview:_hotNumLabel];
    
    
//    _thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _secondImage.frame.origin.y + _secondImage.frame.size.height, screenWeith, 50)];
//    _thirdImage.userInteractionEnabled  = YES;
//    _thirdImage.image = [UIImage imageNamed:@"backFrame.png"];
//    [self.view addSubview:_thirdImage];
//    
//    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 30)];
//    _priceLabel.text = @"  价       格 :";
//    [_thirdImage addSubview:_priceLabel];
//    
//    _coinThirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(screenWeith - 25, 17.5, 15, 15)];
//    _coinThirdImage.userInteractionEnabled  = YES;
//    _coinThirdImage.image = [UIImage imageNamed:@"right.png"];
//    [_thirdImage addSubview:_coinThirdImage];
//    
//    _priceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWeith - 30 - 5 - 120, 10, 120, 30)];
//    _priceNumLabel.text = @"默认";
//    self.priceString = @"";
//    _priceNumLabel.textAlignment = NSTextAlignmentRight;
//    [_thirdImage addSubview:_priceNumLabel];
//    
//    _xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _thirdImage.frame.origin.y + _thirdImage.frame.size.height, screenWeith, 0.5)];
//    _xianLabel.backgroundColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.00];
//    [self.view addSubview:_xianLabel];
    
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake((screenWeith - 100) / 2, _secondImage.frame.origin.y + _secondImage.frame.size.height + 30, 100, 40)];
    [self.button setTitle:@"恢复默认" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor clearColor];
    self.button.layer.masksToBounds = YES;
    self.button.layer.borderWidth = 0.5;
    self.button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.button addTarget:self action:@selector(moren:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(first)];
    [self.firstImage addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(second)];
    [self.secondImage addGestureRecognizer:tap2];
    
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(third)];
//    [self.thirdImage addGestureRecognizer:tap3];
    
    //取缓存值 有则赋值，没有则默认（上面UI里有）
//    NSString *kind = [[NSUserDefaults standardUserDefaults] objectForKey:@"kind"];
//    NSString *kindName = [[NSUserDefaults standardUserDefaults] objectForKey:@"kindName"];
//    NSString *hot = [[NSUserDefaults standardUserDefaults] objectForKey:@"hot"];
    
    
//    if ([kindName isEqualToString:@""] || kindName == nil ) {
        _kindNumLabel.text = @"全部";
        _kindString = @"";
//    } else {
//        _kindNumLabel.text = kindName;
//        self.kindString = kind;
//    }

    
    
//    if ([hot isEqualToString:@""]|| hot == nil) {
        _hotNumLabel.text = @"全部";
        _hotString = @"";
        

    
}

#pragma mark - Action:
- (void)right:(UIButton *)tap{
    
    //确定前 存缓存
//    [[NSUserDefaults standardUserDefaults] setObject:self.kindString forKey:@"kind"];
//    [[NSUserDefaults standardUserDefaults] setObject:self.kindNumLabel.text forKey:@"kindName"];
//    [[NSUserDefaults standardUserDefaults] setObject:self.hotNumLabel.text forKey:@"hot"];
   
    
    [self.tradeBackDelegate tradeBack:self.kindString order_byString:self.hotString];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moren:(UIButton *)tap{
    self.kindNumLabel.text = @"全部";
    self.hotNumLabel.text = @"全部";
    self.kindString = @"";
    self.hotString = @"";
}

- (void)first{
    
    self.number = 1;
    [self next];
}
- (void)second{
    self.number = 2;
    
    [self next];
}
//- (void)third{
//    self.number = 3;
//    
//    [self next];
//}


- (void)next{
    HZOrderChooseTableViewController *chooseVC = [[HZOrderChooseTableViewController alloc] init];
    chooseVC.backDelegate = self;
    chooseVC.tagNumber = self.number;
    
//    chooseVC.statusString = self.kindNumLabel.text;
//    chooseVC.nameString = self.hotNumLabel.text;
    [self pushVc:chooseVC];
}


//协议回调
- (void)BackScript:(NSString *)idString Name:(NSString *)name{
    if (1 == self.number) {
        self.kindNumLabel.text = name;
        self.kindString = idString;
    } else {

        self.hotNumLabel.text = name;
        self.hotString = idString;
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
