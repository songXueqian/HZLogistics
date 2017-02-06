//
//  HZPersonViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"



@interface HZPersonViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIActionSheet *sheet;
}



@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)NSString *fullPath;
@property (nonatomic, assign)NSInteger photoNum;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *statuString;

@end
