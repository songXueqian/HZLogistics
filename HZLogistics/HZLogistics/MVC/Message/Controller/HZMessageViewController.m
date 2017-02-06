//
//  HZMessageViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZMessageViewController.h"
#import "HZCustomSegmentView.h"
#import "HZMessageDetailViewController.h"
#import "GetSysMsgListModel.h"
#import "HZMessageTableViewCell.h"

@interface HZMessageViewController ()<messageDelegate>

@end



@implementation HZMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message) name:@"Message" object:nil];
}

// 通知中心
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)message{
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"信息";
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    self.dataArray = [NSMutableArray array];
    self.typeString = @"personal";

    HZCustomSegmentView *segment = [[HZCustomSegmentView alloc] initWithItemTitles:@[@"个人消息", @"系统消息"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 200, 30);
    WeakSelf(weakSelf);
    segment.NHCustomSegmentViewBtnClickHandle = ^(HZCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
    };
    [segment clickDefault];
    
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
    
    [self getData];
    [self headerPull];
    [self footerPull];
    

}

#pragma mark - AF:接口
- (void)getData{
    
    [self showHud];
    self.pageCount = 1;
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetSysMsgList Dat:@{@"msg_type":self.typeString, @"page":@"1", @"rows_per_page":@"10"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            self.dataArray = (NSMutableArray *)result_data;
            [self.tableView reloadData];
            
            
            
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
    
    __weak HZMessageViewController *weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.pageCount = 1;
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetSysMsgList Dat:@{@"msg_type":self.typeString, @"page":@"1", @"rows_per_page":@"10"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
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
    
    __weak HZMessageViewController *weakSelf = self;
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.pageCount =  weakSelf.pageCount + PAGE_COUNT;
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetSysMsgList Dat:@{@"msg_type":weakSelf.typeString, @"page":[NSString stringWithFormat:@"%ld", (long)weakSelf.pageCount], @"rows_per_page":@"10"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GetSysMsgListModel *model = [self.dataArray objectAtIndex:indexPath.row];

    static NSString *str = @"HZMessageTableViewCell";
    HZMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (nil == cell) {
        cell = [[HZMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }

    cell.titleLabel.text = model.msg_title;
    if ([self.typeString isEqualToString:@"personal"]) {
        cell.detailLabel.text = @"个人";

    } else {
        cell.detailLabel.text = @"系统";

    }
    cell.timeLabel.text = model.add_time;
    
    if ([model.msg_status isEqualToString:@"read"]) {
//        cell.statusImage.backgroundColor = [UIColor clearColor];
    } else {
//        cell.statusImage.backgroundColor = [UIColor blueColor];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetSysMsgListModel *model = [self.dataArray objectAtIndex:indexPath.row];
//
    HZMessageDetailViewController *messageVC = [[HZMessageDetailViewController alloc] init];
    messageVC.idString = model.msg_id;
    messageVC.statuString = self.typeString;
    messageVC.message = self;
    [self pushVc:messageVC];
    
}


// 可以编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPat
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        GetSysMsgListModel *model = [self.dataArray objectAtIndex:indexPath.row];
//        self.msgID = model.msg_id;
//        self.indexPath = indexPath;
//        [self mesShan];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}
////
//- (void)mesShan{
//    [self showHud];
//    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameDeleteMsg Dat:@{@"msg_id":self.msgID} Result:^(id result_data, ApiStatus result_status, NSString *api) {
//        if (result_status == ApiStatusSuccess) {
//            NSLog(@"成功");
//            [self.dataArray removeObjectAtIndex:self.indexPath.row];  //删除数组里的数据
//            [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
//            [self.tableView reloadData];
//        } else {
//            NSLog(@"失败");
//        }
//        [self hiddenHud];
//    }];
//    
//    
//}

#pragma mark - Action

- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex {
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 个人
        self.typeString = @"personal";
    } else { // 系统
        self.typeString = @"system";

    }
    [self getData];
}


#pragma mark - Delegate(协议回调):
- (void)seeMessage{
    
    [self getData];
    
    
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
