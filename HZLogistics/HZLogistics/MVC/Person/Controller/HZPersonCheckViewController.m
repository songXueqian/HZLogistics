//
//  HZPersonCheckViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZPersonCheckViewController.h"
#import "ZHPickView.h"
#import "UploadListenPhotoModel.h"
#import "CreateNewCompanyModel.h"

@interface HZPersonCheckViewController ()<ZHPickViewDelegate>
@property (nonatomic, strong)ZHPickView *pickView;
@property (nonatomic, strong)ZHPickView *pickViewData;

@end

@implementation HZPersonCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"企业认证";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
    
    self.photoString = @"";
    self.comTextField.delegate = self;
    self.regTextField.delegate = self;
    self.addTextField.delegate = self;
    self.yeWuTextField.delegate = self;
    self.faRenTextField.delegate = self;
    self.contentTextField.delegate = self;
    self.workTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.idTextField.delegate = self;
    
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.layer.cornerRadius = 5;
    self.numLabel.layer.borderWidth = 0.5;
    self.numLabel.layer.borderColor = [[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00] CGColor];
    UITapGestureRecognizer *numTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numTap:)];
    [self.numLabel addGestureRecognizer:numTap];
    
    
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.layer.cornerRadius = 5;
    self.timeLabel.layer.borderWidth = 0.5;
    self.timeLabel.layer.borderColor = [[UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00] CGColor];
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeTap:)];
    [self.timeLabel addGestureRecognizer:timeTap];
    
    
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.cornerRadius = 5;
    
    NSArray *array = [NSArray arrayWithObjects:@"1-50", @"51-100", @"101-200", @"201-500", @"501-1000", @"1001-5000", @"5001+", nil];
    self.pickView =[[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    self.pickView.delegate = self;
    
    self.pickViewData =[[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    self.pickViewData.delegate = self;
    
    
    
}

- (void)LeftAction{
    
    if (![self.regTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.addTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.yeWuTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.faRenTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.workTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.idTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.numberString isEqualToString:@""] && ![self.numLabel.text isEqualToString:@"  请选择公司人数"]) {
        [self alertAction];
        return;
    }
    if (![self.timeString isEqualToString:@""] && ![self.timeLabel.text isEqualToString:@"  请选择成立时间"]) {
        [self alertAction];
        return;
    }
    if (![self.photoString isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.comTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.contentTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    if (![self.phoneTextField.text isEqualToString:@""]) {
        [self alertAction];
        return;
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    



}

- (void)alertAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要放弃编写的内容吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [_pickView remove];
        [_pickViewData remove];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}


- (void)click:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_pickView remove];
    [_pickViewData remove];
}

- (void)numTap:(UITapGestureRecognizer *)tap{
    
    if (_pickView.isShow) {
        
        [_pickView remove];
    }
    else {
        self.pickNum = 1;
        [self.view endEditing:YES];
        [_pickViewData remove];
        [_pickView showInView:self.view];
    }
    
}


- (void)timeTap:(UITapGestureRecognizer *)tap{
    if (_pickViewData.isShow) {
        [_pickViewData remove];
    }
    else {
        self.pickNum = 2;
        [self.view endEditing:YES];
        [_pickView remove];
        [_pickViewData showInView:self.view];
    }
    
}


- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (1 == self.pickNum) {
        self.numLabel.text = [NSString stringWithFormat:@"  %@", resultString];
        self.numLabel.textColor = [UIColor blackColor];
        self.numberString = resultString;
    } else {
        NSString *string = [resultString substringToIndex:10];
        self.timeLabel.text = [NSString stringWithFormat:@"  %@", string];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeString = string;
        
    }
}




- (IBAction)photoAction:(id)sender {
    [self PhotoButtonAction];
}
- (IBAction)comAction:(id)sender {
    
    //    } else if ([self.workTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请输入职务"];

    //    } else if ([self.regTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请输入注册地"];
    //    } else if ([self.addTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请输入公司地址"];
    //    } else if ([self.yeWuTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请选择主营业务"];
    //    } else if ([self.faRenTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请输入法人代表"];

    //    } else if ([self.idTextField.text isEqualToString:@""]) {
    //        [myToast showWithText:@"请输入身份证号"];
    //    } else if ([self.numLabel.text isEqualToString:@"  请选择公司人数"]) {
    //        [myToast showWithText:@"  请选择公司人数"];
    //    } else if ([self.timeLabel.text isEqualToString:@"  请选择成立时间"]) {
    //        [myToast showWithText:@"  请选择成立时间"];
    //    } else if (1 != self.photoNum) {
    //        [myToast showWithText:@"请添加营业执照"];
    
    if ([self.regTextField.text isEqualToString:@""] || self.regTextField.text == nil) {
        self.regTextField.text = @"";
    }
    if ([self.addTextField.text isEqualToString:@""] || self.addTextField.text == nil) {
        self.addTextField.text = @"";
    }
    if ([self.yeWuTextField.text isEqualToString:@""] || self.yeWuTextField.text == nil) {
        self.yeWuTextField.text = @"";
    }
    if ([self.faRenTextField.text isEqualToString:@""] || self.faRenTextField.text == nil) {
        self.faRenTextField.text = @"";
    }
    if ([self.workTextField.text isEqualToString:@""] || self.workTextField.text == nil) {
        self.workTextField.text = @"";
    }
    if ([self.idTextField.text isEqualToString:@""] || self.idTextField.text == nil) {
        self.idTextField.text = @"";
    }
    if ([self.numberString isEqualToString:@""] || self.numberString == nil) {
        self.numberString = @"";
    }
    if ([self.timeString isEqualToString:@""] || self.timeString == nil) {
        self.timeString = @"";
    }
    if ([self.photoString isEqualToString:@""] || self.photoString == nil) {
        self.photoString = @"";
    } 
    
    
    if ([self.comTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入企业名称"];
        
    } else if ([self.contentTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入联系人"];
        
    } else if ([self.phoneTextField.text isEqualToString:@""]) {
        [myToast showWithText:@"请输入电话"];
    } else {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要企业认证吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self upData];

            
        }]];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    
        
    }
    
    
    
    
    
    
}

- (void)upData{
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameCreateNewCompany Dat:@{@"company_business_listen":self.photoString, @"company_name":self.comTextField.text, @"address":self.addTextField.text, @"create_city":self.regTextField.text, @"employees":self.numberString, @"businesses":self.yeWuTextField.text, @"corporation":self.faRenTextField.text, @"create_time":self.timeString, @"contact":self.contentTextField.text, @"position":self.workTextField.text, @"telphone":self.phoneTextField.text, @"corporation_id_no":self.idTextField.text} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            CreateNewCompanyModel *model = [(NSArray *)result_data firstObject];
            
            [[NSUserDefaults standardUserDefaults] setObject:model.company_id forKey:@"company_id"];
            [[NSUserDefaults standardUserDefaults] setObject:@"inactive" forKey:@"company_status"];
            [myToast showWithText:@"提交成功"];
            
            if (1 == self.status) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
                
            }

            
            
            
        } else {
            NSLog(@"失败");
        }
        
        [self hiddenHud];
        
    }];
    
    
    
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
    //    self.photoNum = 1;
}

- (void)uploadPhoto{
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] uploadFile:ApiNameUploadListenPhoto Files:[NSArray arrayWithObject:_fullPath] Dat:@{} Result:^(id result_data, ApiStatus result_status) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"图片上传成功");
            [myToast showWithText:@"上传成功"];
            UploadListenPhotoModel *model = [(NSArray *)result_data firstObject];
            self.photoString = model.company_business_listen;
            
            [self.photoButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoString]]] forState:UIControlStateNormal];
            
        } else {
            NSLog(@"图片上传失败");
            [myToast showWithText:@"上传失败"];
        }
        [self hiddenHud];
    } Progress:^(CGFloat progress) {
        
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
