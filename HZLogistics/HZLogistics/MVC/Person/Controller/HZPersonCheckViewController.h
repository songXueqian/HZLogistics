//
//  HZPersonCheckViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZPersonCheckViewController : BaseViewController<UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIActionSheet *sheet;
}

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UITextField *comTextField;
@property (weak, nonatomic) IBOutlet UITextField *regTextField;
@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *yeWuTextField;
@property (weak, nonatomic) IBOutlet UITextField *faRenTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UITextField *workTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic, strong)NSString *fullPath;
@property (nonatomic, assign)NSInteger photoNum;
@property (nonatomic, assign)NSInteger pickNum;
@property (nonatomic, strong)NSString *photoString;

@property (nonatomic, strong)NSString *numberString;
@property (nonatomic, strong)NSString *timeString;

@property (nonatomic, assign)NSInteger status;

@end
