//
//  HZHomeChooseViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@protocol addressStringDelegate <NSObject>

- (void)addresString:(NSString *)string idS:(NSString *)idString differentNum:(NSInteger )number;

@end

@interface HZHomeChooseViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign)id<addressStringDelegate>message;
@property (nonatomic, assign)NSInteger number;


@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *idArray;

@end
