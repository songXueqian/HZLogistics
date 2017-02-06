//
//  HZPersonCheckSuccessViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZPersonCheckSuccessViewController.h"
#import "GetCompanyInfoModel.h"
#import "HZPersonCheckViewController.h"

@interface HZPersonCheckSuccessViewController ()
@property (nonatomic, strong)GetCompanyInfoModel *model;
@end

@implementation HZPersonCheckSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"企业认证";
    
    [self creatView];
    [self getData];
}


#pragma mark -- UI
- (void)creatView{
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.backScrollView.showsVerticalScrollIndicator = NO;
    self.backScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backScrollView];
    
    self.statusImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    self.statusImage.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.statusImage];
    
    self.upStatusImage = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - 150) / 2 - 25, 35, 25, 25)];
//    self.upStatusImage.backgroundColor = [UIColor redColor];
    self.upStatusImage.layer.masksToBounds = YES;
    self.upStatusImage.layer.cornerRadius = self.upStatusImage.frame.size.width / 2;
    [self.statusImage addSubview:self.upStatusImage];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.upStatusImage.frame.origin.x + self.upStatusImage.frame.size.width + 5, self.upStatusImage.frame.origin.y - 3, 200, 30)];
    self.statusLabel.textColor = [UIColor blueColor];
    self.statusLabel.font = [UIFont systemFontOfSize:18];
    [self.statusImage addSubview:self.statusLabel];

    
    self.upImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.statusImage.frame.origin.y + self.statusImage.frame.size.height + 10, Main_Screen_Width, 500)];
    self.upImage.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.upImage];
    
   
    
    self.comLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 70, 30)];
    self.comLabel.text = @"企业名称";
    self.comLabel.font = UIFont16;
    self.comLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.comLabel];
    
    self.comNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comLabel.frame.origin.x + self.comLabel.frame.size.width + 20, 15, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.comNumLabel.text = @"企业名称";
    self.comNumLabel.font = UIFont16;
    self.comNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.comNumLabel];
    
    self.regLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.comLabel.frame.origin.y + self.comLabel.frame.size.height, 70, 30)];
    self.regLabel.text = @"注册地";
    self.regLabel.font = UIFont16;
    self.regLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.regLabel];
    
    self.regNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.regLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.regNumLabel.text = @"注册地";
    self.regNumLabel.font = UIFont16;
    self.regNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.regNumLabel];
    
    self.addLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.regLabel.frame.origin.y + self.regLabel.frame.size.height, 70, 30)];
    self.addLabel.text = @"公司地址";
    self.addLabel.font = UIFont16;
    self.addLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.addLabel];
    
    self.addNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.addLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.addNumLabel.text = @"公司地址";
    self.addNumLabel.font = UIFont16;
    self.addNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.addNumLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.addLabel.frame.origin.y + self.addLabel.frame.size.height, 70, 30)];
    self.numLabel.text = @"公司人数";
    self.numLabel.font = UIFont16;
    self.numLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.numLabel];
    
    self.numNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.numLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.numNumLabel.text = @"公司人数";
    self.numNumLabel.font = UIFont16;
    self.numNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.numNumLabel];
    
    self.yeWuLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.numLabel.frame.origin.y + self.numLabel.frame.size.height, 70, 30)];
    self.yeWuLabel.text = @"主营业务";
    self.yeWuLabel.font = UIFont16;
    self.yeWuLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.yeWuLabel];
    
    self.yeWuNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.yeWuLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.yeWuNumLabel.text = @"主营业务";
    self.yeWuNumLabel.font = UIFont16;
    self.yeWuNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.yeWuNumLabel];
    
    self.faRenLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.yeWuLabel.frame.origin.y + self.yeWuLabel.frame.size.height, 70, 30)];
    self.faRenLabel.text = @"法人代表";
    self.faRenLabel.font = UIFont16;
    self.faRenLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.faRenLabel];
    
    self.faRenNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.faRenLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.faRenNumLabel.text = @"法人代表";
    self.faRenNumLabel.font = UIFont16;
    self.faRenNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.faRenNumLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.faRenLabel.frame.origin.y + self.faRenLabel.frame.size.height, 70, 30)];
    self.timeLabel.text = @"成立时间";
    self.timeLabel.font = UIFont16;
    self.timeLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.timeLabel];
    
    self.timeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.timeLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.timeNumLabel.text = @"成立时间";
    self.timeNumLabel.font = UIFont16;
    self.timeNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.timeNumLabel];
    
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 20, 70, 30)];
    self.contentLabel.text = @"联系人";
    self.contentLabel.font = UIFont16;
    self.contentLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.contentLabel];
    
    self.contentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.contentLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.contentNumLabel.text = @"联系人";
    self.contentNumLabel.font = UIFont16;
    self.contentNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.contentNumLabel];
    
    self.workLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height , 70, 30)];
    self.workLabel.text = @"职务";
    self.workLabel.font = UIFont16;
    self.workLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.workLabel];
    
    self.workNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.workLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.workNumLabel.text = @"职务";
    self.workNumLabel.font = UIFont16;
    self.workNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.workNumLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.workLabel.frame.origin.y + self.workLabel.frame.size.height , 70, 30)];
    self.phoneLabel.text = @"电话";
    self.phoneLabel.font = UIFont16;
    self.phoneLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.phoneLabel];
    
    self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.phoneLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.phoneNumLabel.text = @"电话";
    self.phoneNumLabel.font = UIFont16;
    self.phoneNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.phoneNumLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.phoneLabel.frame.origin.y + self.phoneLabel.frame.size.height , 70, 30)];
    self.idLabel.text = @"身份证号";
    self.idLabel.font = UIFont16;
    self.idLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.upImage addSubview:self.idLabel];
    
    
    self.idNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.idLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    self.idNumLabel.text = @"身份证号";
    self.idNumLabel.font = UIFont16;
    self.idNumLabel.textColor = [UIColor blackColor];
    [self.upImage addSubview:self.idNumLabel];



    [self.upImage setFrame:CGRectMake(0, self.statusImage.frame.origin.y + self.statusImage.frame.size.height + 10, Main_Screen_Width, self.idNumLabel.frame.origin.y + self.idNumLabel.frame.size.height + 15)];

    self.downImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.upImage.frame.origin.y + self.upImage.frame.size.height + 10, Main_Screen_Width, 101 + 15)];
    self.downImage.backgroundColor = [UIColor whiteColor];
    [self.backScrollView addSubview:self.downImage];

    self.photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 70, 30)];
    self.photoLabel.text = @"营业执照";
    self.photoLabel.font = UIFont16;
    self.photoLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.34 alpha:1.00];
    [self.downImage addSubview:self.photoLabel];

    self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.photoLabel.frame.origin.y + self.photoLabel.frame.size.height, 72, 56)];
    self.photoImage.image = [UIImage imageNamed:@""];
    [self.downImage addSubview:self.photoImage];
    


    self.backScrollView.contentSize = CGSizeMake(0, self.downImage.frame.origin.y + self.downImage.frame.size.height + 200);
    
    
}

- (void)getData{
    
    NSString *company_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_id"];
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetCompanyInfo Dat:@{@"company_id":company_id} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            self.model = [(NSArray *)result_data firstObject];
            
            [self fuzhi];
            
        } else {
            NSLog(@"失败");
        }
        
        [self hiddenHud];
        
    }];

}

- (void)fuzhi{
    
    if ([self.model.company_status isEqualToString:@"inactive"]) {
//        审核中
        self.upStatusImage.image = [UIImage imageNamed:@"icon_identity_check_waiting"];
        self.statusLabel.text = @"审核中,请耐心等待";
        self.statusLabel.textColor = [UIColor colorWithRed:0.14 green:0.53 blue:1.00 alpha:1.00];
    } else if ([self.model.company_status isEqualToString:@"active"]) {
//        成功
        self.upStatusImage.image = [UIImage imageNamed:@"icon_identity_check_success"];
        self.statusLabel.text = @"企业认证成功";
        self.statusLabel.textColor = [UIColor colorWithRed:0.00 green:0.65 blue:0.31 alpha:1.00];

    } else {
        //失败
        self.upStatusImage.image = [UIImage imageNamed:@"icon_identity_check_failed"];
        self.statusLabel.text = @"企业认证失败";
        self.statusLabel.textColor = [UIColor colorWithRed:1.00 green:0.00 blue:0.18 alpha:1.00];

        //重新上传按钮
        self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.commitButton setFrame:CGRectMake(20, self.downImage.frame.origin.y + self.downImage.frame.size.height + 20, screenWeith - 40, 40)];
        [self.commitButton setTitle:@"重新上传" forState:UIControlStateNormal];
        [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.commitButton.backgroundColor = ButtonColor;
        self.commitButton.layer.masksToBounds = YES;
        self.commitButton.layer.cornerRadius = 5;
        [self.commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        [self.backScrollView addSubview:self.commitButton];

 
        self.backScrollView.contentSize = CGSizeMake(0, self.commitButton.frame.origin.y + self.commitButton.frame.size.height + 200);
    }
    
    self.comNumLabel.text = self.model.company_name;
    self.regNumLabel.text = self.model.create_city;
    self.addNumLabel.text = self.model.address;
    self.numNumLabel.text = self.model.employees;
    self.timeNumLabel.text = self.model.create_time;
    self.yeWuNumLabel.text = self.model.businesses;
    self.faRenNumLabel.text = self.model.corporation;
    self.contentNumLabel.text = self.model.contact;
    self.workNumLabel.text = self.model.position;
    self.phoneNumLabel.text = self.model.telphone;
    self.idNumLabel.text = self.model.corporation_id_no;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:self.model.company_business_listen] placeholderImage:[UIImage imageNamed:@""]];
    
    
    [self.addLabel setFrame:CGRectMake(15, self.regLabel.frame.origin.y + self.regLabel.frame.size.height, 70, 30)];
    self.addNumLabel.numberOfLines = 0;
    [self.addNumLabel sizeToFit];
    if (self.addNumLabel.frame.size.height <= 30) {
        [self.addNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.addLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    }
    [self.numLabel setFrame:CGRectMake(15, self.addNumLabel.frame.origin.y + self.addNumLabel.frame.size.height + 5, 70, 30)];
    [self.numNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.numLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.yeWuLabel setFrame:CGRectMake(15, self.numLabel.frame.origin.y + self.numLabel.frame.size.height, 70, 30)];
    [self.yeWuNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.yeWuLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.faRenLabel setFrame:CGRectMake(15, self.yeWuLabel.frame.origin.y + self.yeWuLabel.frame.size.height, 70, 30)];
    [self.faRenNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.faRenLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.timeLabel setFrame:CGRectMake(15, self.faRenLabel.frame.origin.y + self.faRenLabel.frame.size.height, 70, 30)];
    [self.timeNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.timeLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.contentLabel setFrame:CGRectMake(15, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + 20, 70, 30)];
    [self.contentNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.contentLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.workLabel setFrame:CGRectMake(15, self.contentLabel.frame.origin.y + self.contentLabel.frame.size.height , 70, 30)];
    [self.workNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.workLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.phoneLabel setFrame:CGRectMake(15, self.workLabel.frame.origin.y + self.workLabel.frame.size.height , 70, 30)];
    [self.phoneNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.phoneLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.idLabel setFrame:CGRectMake(15, self.phoneLabel.frame.origin.y + self.phoneLabel.frame.size.height , 70, 30)];
    [self.idNumLabel setFrame:CGRectMake(self.comNumLabel.frame.origin.x, self.idLabel.frame.origin.y, Main_Screen_Width - self.comLabel.frame.origin.x - self.comLabel.frame.size.width - 20 - 10, 30)];
    [self.upImage setFrame:CGRectMake(0, self.statusImage.frame.origin.y + self.statusImage.frame.size.height + 10, Main_Screen_Width, self.idNumLabel.frame.origin.y + self.idNumLabel.frame.size.height + 15)];
    [self.downImage setFrame:CGRectMake(0, self.upImage.frame.origin.y + self.upImage.frame.size.height + 10, Main_Screen_Width, 101 + 15)];
    [self.photoLabel setFrame:CGRectMake(15, 15, 70, 30)];
    [self.photoImage setFrame:CGRectMake(15, self.photoLabel.frame.origin.y + self.photoLabel.frame.size.height, 72, 56)];
    self.backScrollView.contentSize = CGSizeMake(0, self.downImage.frame.origin.y + self.downImage.frame.size.height + 200);

}

- (void)commit{
    HZPersonCheckViewController *checkVC = [HZPersonCheckViewController new];
    checkVC.status = 1;
    [self pushVc:checkVC];
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
