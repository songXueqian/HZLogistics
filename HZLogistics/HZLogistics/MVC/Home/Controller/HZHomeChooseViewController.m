//
//  HZHomeChooseViewController.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/30.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "HZHomeChooseViewController.h"
#import "HZHomeChooseTableViewCell.h"
#import "GetPortsListModel.h"

@interface HZHomeChooseViewController ()

@end

@implementation HZHomeChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (1 == self.number) {
        self.navigationItem.title = @"请选择装货港";

    } else {
        self.navigationItem.title = @"请选择目的港";

    }
    
    self.dataArray = [NSMutableArray array];
    self.idArray = [NSMutableArray array];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWeith, screenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self getData];
    

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
                if ([model.port_name isEqualToString:@"全部"]) {
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *str = @"HZHomeChooseTableViewCell";
    HZHomeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (nil == cell) {
        cell = [[HZHomeChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    cell.titile.text = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.message addresString:[self.dataArray objectAtIndex:indexPath.row] idS:[self.idArray objectAtIndex:indexPath.row] differentNum:self.number];
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
