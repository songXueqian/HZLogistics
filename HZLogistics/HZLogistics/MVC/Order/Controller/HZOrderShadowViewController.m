//
//  HZOrderShadowViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderShadowViewController.h"
#import "HZOrderShadowTableViewCell.h"
#import "OrderStatusListModel.h"

@interface HZOrderShadowViewController ()

@end

@implementation HZOrderShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"货运跟踪";
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, screenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = BackgroundColor;
    
    [self GetData];
    
}

#pragma mark -- AF
- (void)GetData{
    
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameoOrderStatusList Dat:@{@"order_id":self.idString} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            self.dataArray = (NSMutableArray *)result_data;
            [self.tableView reloadData];
            NSLog(@"成功");
            
        } else {
            NSLog(@"失败");
        }
        [self hiddenHud];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderStatusListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    CGRect rect1 = [model.current_status boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 120, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    
    return rect1.size.height + 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderStatusListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    static NSString *str = @"HZOrderShadowTableViewCell";
    HZOrderShadowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (nil == cell) {
        cell = [[HZOrderShadowTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    cell.titleLabel.text = model.add_time;
    cell.numberLabel.text = model.current_status;
    cell.portLabel.text = model.current_port;
    
    
    //上下线
    if (model == [self.dataArray firstObject]) {
        cell.xianImage2.hidden = YES;
        cell.xianImage.hidden = NO;
    } else if (model == [self.dataArray lastObject]) {
        cell.xianImage.hidden = YES;
        cell.xianImage2.hidden = NO;
    } else {
        cell.xianImage.hidden = NO;
        cell.xianImage2.hidden = NO;
    }
    
    if (0 == indexPath.row) {
        cell.yuanImage.image = [UIImage imageNamed:@"icon_trace_processing"];
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.numberLabel.textColor = [UIColor blackColor];
        cell.portLabel.textColor = [UIColor blackColor];
        
    } else {
        cell.yuanImage.image = [UIImage imageNamed:@"icon_traced_done"];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        cell.numberLabel.textColor = [UIColor lightGrayColor];
        cell.portLabel.textColor = [UIColor lightGrayColor];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    return cell;
    
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
