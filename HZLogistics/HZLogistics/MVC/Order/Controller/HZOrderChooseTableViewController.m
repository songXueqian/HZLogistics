//
//  HZOrderChooseTableViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "HZOrderChooseTableViewController.h"
#import "HZOrderChooseTableViewCell.h"
#import "GetPortsListModel.h"
#import "OrderSelectsModel.h"

@interface HZOrderChooseTableViewController ()

@end

@implementation HZOrderChooseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.dataArray = [NSMutableArray array];
    self.dataArray2 = [NSMutableArray array];
    self.dataArray3 = [NSMutableArray array];

    self.idArray = [NSMutableArray array];
    self.idArray2 = [NSMutableArray array];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, screenWeith, screenHeight - 64 - 10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = BackgroundColor;
    
    //设置右按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(70, 35, 50, 20.25)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    if (1 == self.tagNumber) {
        self.navigationItem.title = @"状态";
        [self getData2];
    } else {
        self.navigationItem.title = @"目的港";
        [self getData];
    }
    
   

}


#pragma mark - AF:接口
- (void)getData{
        [self showHud];
        [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameGetPortsList Dat:@{@"page": @"1", @"rows_per_page":@"10"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
            if (result_status == ApiStatusSuccess) {
                NSLog(@"成功");
                
                NSMutableArray *array = [NSMutableArray array];
                array = (NSMutableArray *)result_data;
                for (GetPortsListModel *model in array) {
                    [self.dataArray addObject:model.port_name];
                    [self.idArray addObject:model.port_id];
                    if ([model.port_name isEqualToString:@"其他"]) {
                        [self.dataArray removeObject:model.port_name];
                        [self.idArray removeObject:model.port_id];
                        
                    }
                }
                [self.tableView reloadData];
                
            } else {
                NSLog(@"失败");
            }
            [self hiddenHud];
        }];
    
}


- (void)getData2 {
    [self showHud];
    [[AFAppDotNetAPIClient sharedClient] apiPost:ApiNameOrderSelects Dat:@{@"page": @"1", @"rows_per_page":@"10"} Result:^(id result_data, ApiStatus result_status, NSString *api) {
        if (result_status == ApiStatusSuccess) {
            NSLog(@"成功");
            
            self.dataArray2 = (NSMutableArray *)result_data;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"失败");
        }
        [self hiddenHud];
    }];

    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (1 == self.tagNumber) {
        return [self.dataArray2 count];

    } else {
        return [self.dataArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *str = @"HZOrderChooseTableViewCell";
    
    HZOrderChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (nil == cell) {
        cell = [[HZOrderChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    
    if (1 == self.tagNumber) {
        OrderSelectsModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
        cell.dataLabel.text = model.status_name;
        cell.yuanImage.hidden = YES;
        [self.dataArray3 addObject:model.status_name];
        [self.idArray2 addObject:model.state_id];

    } else {
        
        cell.dataLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        cell.yuanImage.hidden = YES;
    }
    
    
    cell.backgroundColor = BackgroundColor;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZOrderChooseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.yuanImage.hidden = NO;
    
    if (1 == self.tagNumber) {
        self.chuanNumber3 = [NSString stringWithFormat:@"%@", [self.idArray2 objectAtIndex:indexPath.row]];
        self.chuanNumber4 = [self.dataArray3 objectAtIndex:indexPath.row];

    } else {
        self.chuanNumber = [self.idArray objectAtIndex:indexPath.row];
        self.chuanNumber2 = [self.dataArray objectAtIndex:indexPath.row];
    }
   

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    HZOrderChooseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.yuanImage.hidden = YES;
}

#pragma mark - Action:

- (void)right:(UIButton *)tap{
    
    if (1 == self.tagNumber) {
        
        [_backDelegate BackScript:self.chuanNumber3 Name:self.chuanNumber4];

        
        
    } else {
        [_backDelegate BackScript:self.chuanNumber Name:self.chuanNumber2];

        
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
