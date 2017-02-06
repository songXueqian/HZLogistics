//
//  HZOrderViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZOrderViewController.h"
#import "HZOrderTableViewCell.h"
#import "HZOrderDetailViewController.h"
#import "HZOrderChooseViewController.h"
#import "GetOrdersListModel.h"

@interface HZOrderViewController ()<TradeBackDelegate, shouHuoDelegate>

@end

@implementation HZOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationItem.title = @"订单";
    self.dataArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    self.order_noArray = [NSMutableArray array];
    self.searchString = @"0";
    self.statuString = @"0";
    self.addressString = @"all";
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //设置右按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(20, 20, 30, 30)];
    //    LoginModel *model = [AFAppDotNetAPIClient sharedClient].login_model;
    //    if (![model.unread_res isEqualToString:@"0"]) {
    [_rightButton setImage:[UIImage imageNamed:@"icon_choose_info"] forState:UIControlStateNormal];
    //    } else {
    //        [_rightButton setBackgroundImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    //    }
    
    [_rightButton addTarget:self action:@selector(buyRight) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.navigationItem.titleView = self.searchController.searchBar;
    
    
    self.searchController.searchBar.placeholder = @"搜索委托单号";
    self.searchController.searchBar.showsCancelButton = NO;
    
    
    self.picImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, screenHeight - 64 - 49)];
    self.picImage.image = [UIImage imageNamed:@"list_bg_news"];
    self.picImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.picImage];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, screenHeight - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
//    [self getData];
    [self headerPull];
    [self footerPull];
    
    //背景图片上增加毛玻璃特效
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    self.effectView.frame = self.view.bounds;
    self.effectView.userInteractionEnabled = YES;
    [self.view addSubview:self.effectView];
    //设置模糊透明度
    self.effectView.alpha = .3f;
    self.effectView.hidden = YES;
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    //    [self.effectView addGestureRecognizer:tap];
    
    
    
}


#pragma mark - AF:接口
- (void)getData{
    
    [self showHud];
    self.pageCount = 1;
    
    if ([self.statuString isEqualToString:@"0"]) {
        self.statuString = @"0";
    }
    if ([self.addressString isEqualToString:@""]) {
        self.addressString = @"all";
        
    }
    
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetOrdersList Dat:@{@"order_no":self.searchString, @"page":@"1", @"rows_per_page":@"10", @"state_id":self.statuString, @"destination_port":self.addressString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            self.dataArray = (NSMutableArray *)result_data;
            [self.tableView reloadData];
            
            [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
            
        } else {
            NSLog(@"失败");
        }
        
        if (self.dataArray.count == 0) {
            self.picImage.hidden = NO;
            self.tableView.hidden = YES;
        } else {
            self.picImage.hidden = YES;
            self.tableView.hidden = NO;
            
        }
        
        [self hiddenHud];
    }];
    
}

- (void)headerPull {
    
    __weak HZOrderViewController *weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.pageCount = 1;
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetOrdersList Dat:@{@"order_no":weakSelf.searchString, @"page":@"1", @"rows_per_page":@"10", @"state_id":weakSelf.statuString, @"destination_port":weakSelf.addressString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                weakSelf.dataArray = (NSMutableArray *)result_data;
                [weakSelf.tableView reloadData];
            } else {
                
            }
        }];
        [weakSelf.tableView headerEndRefreshing];
    }];
}

- (void)footerPull {
    
    __weak HZOrderViewController *weakSelf = self;
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.pageCount =  weakSelf.pageCount + PAGE_COUNT;
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetOrdersList Dat:@{@"order_no":weakSelf.searchString, @"page":[NSString stringWithFormat:@"%ld", (long)weakSelf.pageCount], @"rows_per_page":@"10", @"state_id":weakSelf.statuString, @"destination_port":weakSelf.addressString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                NSArray *array = (NSArray *)result_data;
                if (array.count == 0) {
                    [myToast showWithText:@"没有更多信息"];
                    weakSelf.pageCount =  weakSelf.pageCount - PAGE_COUNT;
                } else {
                    [weakSelf.dataArray addObjectsFromArray:array];
                    [weakSelf.tableView reloadData];
                }
            } else {
                weakSelf.pageCount =  weakSelf.pageCount - PAGE_COUNT;
            }
        }];
        [weakSelf.tableView footerEndRefreshing];
        
    }];
}

#pragma mark - searchBar
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.effectView.hidden = YES;
    self.effectNum = 1;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    self.effectView.hidden = YES;
    self.effectNum = 1;
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (1 == self.effectNum) {
        self.effectView.hidden = YES;
        self.effectNum = 2;
    } else {
        self.effectView.hidden = NO;
    }
    
    NSString *searchString = [self.searchController.searchBar text];
    self.searchString = searchString;
    [self getData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray count];//原始数据
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    GetOrdersListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    static NSString *str = @"HZOrderTableViewCell";
    HZOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (nil == cell) {
        cell = [[HZOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    
    cell.titile.text = model.order_no;
    [self.order_noArray addObject:model.order_no];
    cell.chuFaLabel.text = model.loading_port;
    cell.toLabel.text = model.destination_port;
    cell.timeLabel.text = model.add_time;
    
    if ([model.status_name isEqualToString:@"确认收货"]) {
        cell.icon.image = [UIImage imageNamed:@"icon_confirmed"];
    } else if ([model.status_name isEqualToString:@"审核成功"]) {
        cell.icon.image = [UIImage imageNamed:@"icon_succeed"];
        
    } else if ([model.status_name isEqualToString:@"审核失败"]) {
        cell.icon.image = [UIImage imageNamed:@"icon_failed"];
    } else if ([model.status_name isEqualToString:@"运输中"]) {
        cell.icon.image = [UIImage imageNamed:@"icon_transporting"];
    } else {
        cell.icon.image = [UIImage imageNamed:@"icon_waiting"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetOrdersListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    HZOrderDetailViewController *detailVC = [[HZOrderDetailViewController alloc] init];
    detailVC.idString = model.order_id;
    [self pushVc:detailVC];
    
    
    
    
}

#pragma mark - Action:

- (void)buyRight{
    
    HZOrderChooseViewController *orderVC = [HZOrderChooseViewController alloc];
    orderVC.tradeBackDelegate = self;
    [self pushVc:orderVC];
    
    
}


//协议回调
- (void)tradeBack:(NSString *)cate_id order_byString:(NSString *)order_by{
    
    self.statuString = cate_id;
    self.addressString = order_by;
    [self getData];
    
}

- (void)shouDelegate{
    [self getData];
}

//- (void)click{
//    self.effectView.hidden = YES;
//    self.effectNum = 1;
//}

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
