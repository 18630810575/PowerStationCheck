//
//  ListViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "ListViewController.h"
#import "TaskDetailsViewController.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;







@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务列表";
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(64);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(kScreenHeight - 64 - 73);
    }];
}

#pragma mark - tableview -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"任务%ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskDetailsViewController *taskdeVC = [[TaskDetailsViewController alloc]initWithTitle:[NSString stringWithFormat:@"任务 %ld",(long)indexPath.row] AndNeedBack:YES];
    [self.navigationController pushViewController:taskdeVC animated:YES];
}





#pragma mark - getters -
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
        _tableview.backgroundColor = [UIColor clearColor];
        //_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _tableview.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = FALSE;
        }
        _tableview.showsVerticalScrollIndicator = YES;
    }
    return _tableview;
}


@end
