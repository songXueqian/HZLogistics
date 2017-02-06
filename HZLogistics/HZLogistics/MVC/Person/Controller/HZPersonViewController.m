//
//  HZPersonViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZPersonViewController.h"
#import "HZPersonCheckViewController.h"
#import "HZLoginViewController.h"
#import "HZPersonTableViewCell.h"
#import "HZPersonPhotoTableViewCell.h"
#import "HZPersonCheckSuccessViewController.h"
#import "GetUserInfoModel.h"
#import "UploadAvatarModel.h"

@interface HZPersonViewController ()<infomationDelegate>
@property (nonatomic, strong)GetUserInfoModel *model;
@property (nonatomic, strong)UploadAvatarModel *avatarModel;

@end

@implementation HZPersonViewController

- (void)viewWillAppear:(BOOL)animated{

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, 190) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(20, self.tableView.frame.origin.y + self.tableView.frame.size.height + 60, screenWeith - 40, 40)];
    self.button.backgroundColor = ButtonColor;
    [self.button setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(quitAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    [self.view addSubview:self.button];
    
    [self getData];

    
}

#pragma mark - AF:接口
- (void)getData{
        
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetUserInfo Dat:@{} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            self.model = [(NSArray *)result_data firstObject];
            self.statuString = self.model.company_status;
            [self.tableView reloadData];            
            [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
                        
        } else {
            NSLog(@"失败");
        }
        
        [self hiddenHud];
        
    }];
    
}


- (void)uploadPhoto{
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] uploadFile:ApiNameUploadAvatar Files:[NSArray arrayWithObject:_fullPath] Dat:@{} Result:^(id result_data, ApiStatus result_status) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"图片上传成功");
            [myToast showWithText:@"上传成功"];
            self.avatarModel = [(NSArray *)result_data firstObject];
            
            [self getData];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"图片上传失败");
            [myToast showWithText:@"上传失败"];
        }
        [self hiddenHud];
    } Progress:^(CGFloat progress) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        return 3;
    } else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        
        switch (indexPath.row) {
            case 0:
            {
                return 90;
            }
                break;
            case 1:
            {
                return 10;
            }
                break;
            case 2:
            {
                return 45;
                
            }
                break;
                
            default:
            {
                return 0;
            }
                break;
        }
        
        
    } else {
        
        switch (indexPath.row) {
            case 0:
            {
                return 90;
            }
                break;
            case 1:
            {
                return 10;
            }
                break;
            case 2:
            {
                return 45;
                
            }
                break;
            case 3:
            {
                return 45;
                
            }
                break;
            default:
            {
                return 0;
            }
                
        }
        
        
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        switch (indexPath.row) {
            case 0:
            {
                
                static NSString *str = @"HZPersonPhotoTableViewCell";
                HZPersonPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[HZPersonPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
                }
                
                cell.photoImage.image = [UIImage imageNamed:@"icon_head_pic.png"];
                cell.phone.text = @"";
                cell.titile.text = @"亲，请登录/免费注册";
                cell.titile.textColor = ButtonColor;
                cell.xianLabel.hidden = NO;
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;

            }
                break;
            case 1:
            {
                static NSString *str = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                }
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;
            }
                break;
            case 2:
            {
                static NSString *str = @"HZPersonTableViewCell";
                HZPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[HZPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
                }
                
                [cell.icon setImage:[UIImage imageNamed:@"icno_about_us"]];
                cell.titile.text = @"关于我们";
                cell.xianLabel.hidden = NO;
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;

            }
                break;
            default:{
                return nil;
            }
                break;
        }
        
    } else {
        switch (indexPath.row) {
            case 0:
            {
                static NSString *str = @"HZPersonPhotoTableViewCell";
                HZPersonPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[HZPersonPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
                }
                
                [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:self.model.user_avatar] placeholderImage:[UIImage imageNamed:@"icon_head_pic.png"]];
                cell.titile.text = self.model.user_name;
                cell.phone.text = self.model.ceilphone;
                cell.xianLabel.hidden = NO;
                cell.titile.textColor = [UIColor blackColor];
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;
                
            }
                break;
            case 1:
            {
                static NSString *str = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                }
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;
                
            }
                break;
            case 2:
            {
                static NSString *str = @"HZPersonTableViewCell";
                HZPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[HZPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
                }
                
                [cell.icon setImage:[UIImage imageNamed:@"icon_identity_check"]];
                cell.titile.text = @"企业认证";
                cell.xianLabel.hidden = YES;
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;
                
            }
                break;
            case 3:
            {
                static NSString *str = @"HZPersonTableViewCell";
                HZPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
                
                if (nil == cell) {
                    cell = [[HZPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
                }
                
                [cell.icon setImage:[UIImage imageNamed:@"icno_about_us"]];
                cell.titile.text = @"关于我们";
                cell.xianLabel.hidden = NO;
                cell.backgroundColor = [UIColor clearColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selected = NO;
                return cell;
                
            }
                break;
                
            default:{
                return nil;
            }
                break;
        }
        
    }
    
    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""] || user_id == nil || [user_id isEqualToString:@"0"]) {
        NSLog(@"没有user_id 未登录~~~");
        switch (indexPath.row) {
            case 0:
            {
                HZLoginViewController *loVC = [[HZLoginViewController alloc] init];
                loVC.infomationDelegate = self;
                [self pushVc:loVC];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
               
                
            }
                break;
            
            default:
                break;
        }

    } else {
        switch (indexPath.row) {
            case 0:
            {
                
                [self PhotoButtonAction];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                NSString *company_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"company_status"];

                if ([company_status isEqualToString:@"active"] || [company_status isEqualToString:@"inactive"] || [company_status isEqualToString:@"faild"]) {
                    
                    HZPersonCheckSuccessViewController *checkVC = [HZPersonCheckSuccessViewController new];
                    [self pushVc:checkVC];
                    
                } else {
                    HZPersonCheckViewController *checkVC = [HZPersonCheckViewController new];
                    [self pushVc:checkVC];
                }
                
                
                
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
        }

    }

    
    
    
    
   
}

#pragma mark - Action:

- (void)quitAction:(UIButton *)button{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ceilphone"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"passwd"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_pwd"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"a"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"b"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"company_id"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"company_status"];
        
        [self getData];

        
    }]];
    
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    
    
        }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

    
    
}

- (void)personInfomation{
    [self getData];

}

- (void)PhotoButtonAction{
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    [sheet showInView:self.view];
    
}




#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        switch (buttonIndex) {
            case 0:
                // 取消
                return;
            case 1:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 2:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else {
        if (buttonIndex == 0) {
            return;
        } else {
            //  不支持调用album(相册)
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        //iOS 8
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 保存图片至沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.1);
    
    // 获取沙盒目录
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);
    NSString *path = [documentPaths firstObject];
    _fullPath = [NSString stringWithFormat:@"%@/UserPhoto.png",path];
#if TARGET_TEST_SERVER
    //Jason 20150629 测试环境地址
    
    NSLog(@"fullPath3333 ========= %@", _fullPath);
#else
    //20150629生产环境地
    
#endif
    
    // 将图片写入文件
    [imageData writeToFile:_fullPath atomically:NO];
}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    [self uploadPhoto];
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
