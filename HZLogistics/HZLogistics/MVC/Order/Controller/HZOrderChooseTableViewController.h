//
//  HZOrderChooseTableViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@protocol BackScriptDelegate <NSObject>

- (void)BackScript:(NSString *)idString Name:(NSString *)name;

@end


@interface HZOrderChooseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign)id<BackScriptDelegate>backDelegate;


@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *dataArray2;
@property (nonatomic, strong)NSMutableArray *dataArray3;

@property (nonatomic, strong)NSMutableArray *idArray;
@property (nonatomic, strong)NSMutableArray *idArray2;

@property (nonatomic, assign)NSInteger tagNumber;
@property (nonatomic, assign)NSInteger number;

@property (nonatomic, strong)NSString *nameString;
@property (nonatomic, strong)NSString *nameID;


@property (nonatomic, strong)NSString *statusString;
@property (nonatomic, strong)NSString *statusID;


@property (nonatomic, strong)NSString *string;

@property (nonatomic, strong)NSString *chuanNumber;
@property (nonatomic, strong)NSString *chuanNumber2;
@property (nonatomic, strong)NSString *chuanNumber3;
@property (nonatomic, strong)NSString *chuanNumber4;


@end
