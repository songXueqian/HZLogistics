//
//  HZHomeViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZHomeViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *faHuoTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouHuoTextField;
@property (weak, nonatomic) IBOutlet UITextField *tongZhiTextField;
@property (weak, nonatomic) IBOutlet UITextField *huoMingTextField;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UITextField *zhongLiangTextField;
@property (weak, nonatomic) IBOutlet UITextField *tiJiTextField;
@property (weak, nonatomic) IBOutlet UILabel *zhuangHuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *muDiLabel;
@property (weak, nonatomic) IBOutlet UITextField *specialLabelTextField;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (nonatomic, strong)NSString *cityString;
@property (nonatomic, strong)NSString *cityString2;

@property (nonatomic, strong)NSString *payString;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end
