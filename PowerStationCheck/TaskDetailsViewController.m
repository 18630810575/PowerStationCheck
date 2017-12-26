//
//  TaskDetailsViewController.m
//  PowerStationCheck
//
//  Created by 常奕帆 on 2017/12/25.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "TaskDetailsViewController.h"



@interface TaskDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImage *backImg;
@property (nonatomic,strong)UITableView *taskTableView;


@end

@implementation TaskDetailsViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kNavBackgroundImageName]];
    [self.view addSubview:backImageView];
    float height = kScreenHeight-self.navBar.bounds.size.height;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.top.equalTo(self.navBar.bottom);
        make.height.equalTo(height);
    }];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.taskTableView];
    float statusBarHeight = kStatusBarHeight;
    [self.taskTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusBarHeight + 49);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(kScreenHeight - statusBarHeight - 44);
    }];

}
-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewWillAppear:animated];
    
    
    
}




#pragma mark - 私有方法 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)PopVC{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return [self getFirstCell];
            break;
        case 1:
            return [self getSecondCell];
            break;
        case 2:
            return [self getThirdCell];
            break;
        case 3:
            return [self getForstCell];
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 415 * ScreenScale;
            break;
        case 1:
            return 750 * ScreenScale;
            break;
        case 2:
            return 385 * ScreenScale;
            break;
        case 4:
            return 235 * ScreenScale;
            break;
        default:
            break;
    }
    return 0;
}







#pragma mark - getters -
-(UITableView *)taskTableView{
    if (!_taskTableView) {
        _taskTableView = [[UITableView alloc]init];
        UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        _taskTableView = tvc.tableView;
        
        
        _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _taskTableView.backgroundColor = [UIColor clearColor];
        _taskTableView.delegate =self;
        _taskTableView.dataSource =self;
        _taskTableView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _taskTableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = FALSE;
        }
        _taskTableView.showsVerticalScrollIndicator = YES;
        [self addChildViewController:tvc];
    }
    return _taskTableView;
}



#pragma mark - 私有方法 -
-(UITableViewCell *)getFirstCell{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *whiteView = [[UIView alloc]init];
    [cell addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(kScreenWidth - 90 * ScreenScale);
        make.height.equalTo(390 * ScreenScale);
    }];
    whiteView.layer.cornerRadius = 10 * ScreenScale;
    
    
    UILabel *code_label = [[UILabel alloc]init];
    code_label.text = [NSString stringWithFormat:@"事件编码   %@",@""];
    code_label.font = font(47 * ScreenScale);
    code_label.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:code_label];
    [code_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(40 * ScreenScale);
        make.left.equalTo(57 *ScreenScale);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(105 * ScreenScale);
    }];
    
    
    UILabel *date_label = [[UILabel alloc]init];
    date_label.text = [NSString stringWithFormat:@"事件时间   %@",@""];
    date_label.font = font(47 * ScreenScale);
    code_label.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:date_label];
    [date_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(code_label.bottom);
        make.left.equalTo(57 *ScreenScale);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(105 * ScreenScale);
    }];
    
    UILabel *time_label = [[UILabel alloc]init];
    time_label.text = [NSString stringWithFormat:@"事件周期   %@",@""];
    time_label.font = font(47 * ScreenScale);
    time_label.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:time_label];
    [time_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(date_label.bottom);
        make.left.equalTo(57 *ScreenScale);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(105 * ScreenScale);
    }];
    
    
    return cell;
}

-(UITableViewCell *)getSecondCell{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    UIView *whiteView = [[UIView alloc]init];
    [cell addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(kScreenWidth - 90 * ScreenScale);
        make.height.equalTo(730 * ScreenScale);
    }];
    whiteView.layer.cornerRadius = 10 * ScreenScale;
    
    UILabel *currentLabel = [[UILabel alloc]init];
    currentLabel.text = @"现场情况";
    currentLabel.font = font(60 * ScreenScale);
    currentLabel.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:currentLabel];
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(kScreenWidth - 57 * ScreenScale);
        make.height.equalTo(158 * ScreenScale);
    }];
    
    UIView *line1  = [[UIView alloc]init];
    line1.backgroundColor = UIColorFromRGB(0xD2D2D2);
    [whiteView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentLabel.bottom);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(2 * ScreenScale);
    }];
    
    UILabel *questionLabel1 = [[UILabel alloc]init];
    questionLabel1.text= @"叶片运行无异音,且无裂纹、腐蚀、雷击损伤情况";
    questionLabel1.font = font(46 * ScreenScale);
    questionLabel1.numberOfLines = 0;
    [whiteView addSubview:questionLabel1];
    [questionLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.bottom);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(700 * ScreenScale);
        make.height.equalTo(238 * ScreenScale);
    }];
    
    UIView *line2  = [[UIView alloc]init];
    line2.backgroundColor = UIColorFromRGB(0xD2D2D2);
    [whiteView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questionLabel1.bottom);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(2 * ScreenScale);
    }];
    
    UILabel *questionLabel2 = [[UILabel alloc]init];
    questionLabel2.text= @"墙筒外壁无油污、防腐无脱落等";
    questionLabel2.font = font(46 * ScreenScale);
    questionLabel2.numberOfLines = 0;
    [whiteView addSubview:questionLabel2];
    [questionLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.bottom);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(700 * ScreenScale);
        make.height.equalTo(170 * ScreenScale);
    }];
    
    UIView *line3  = [[UIView alloc]init];
    line3.backgroundColor = UIColorFromRGB(0xD2D2D2);
    [whiteView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questionLabel2.bottom);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(2 * ScreenScale);
    }];
    
    UILabel *questionLabel3 = [[UILabel alloc]init];
    questionLabel3.text= @"墙筒外壁无油污、防腐无脱落等";
    questionLabel3.font = font(46 * ScreenScale);
    questionLabel3.numberOfLines = 0;
    [whiteView addSubview:questionLabel3];
    [questionLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.bottom);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(700 * ScreenScale);
        make.height.equalTo(170 * ScreenScale);
    }];
    
    return cell;
}
-(UITableViewCell *)getThirdCell{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *whiteView = [[UIView alloc]init];
    [cell addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(kScreenWidth - 90 * ScreenScale);
        make.height.equalTo(355 * ScreenScale);
    }];
    whiteView.layer.cornerRadius = 10 * ScreenScale;
    
    
    UILabel *nounLabel = [[UILabel alloc]init];
    nounLabel.text= @"墙筒外壁无油污、防腐无脱落等";
    nounLabel.font = font(46 * ScreenScale);
    nounLabel.numberOfLines = 0;
    [whiteView addSubview:nounLabel];
    [nounLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(700 * ScreenScale);
        make.height.equalTo(168 * ScreenScale);
    }];
    
    UIView *line1  = [[UIView alloc]init];
    line1.backgroundColor = UIColorFromRGB(0xD2D2D2);
    [whiteView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nounLabel.bottom);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(2 * ScreenScale);
    }];
    
    UITextField *field = [[UITextField alloc]init];
    field.placeholder = @"现场需要其他说明，请填写";
    field.font = font(46 * ScreenScale);
    [whiteView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.bottom);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth - 90 * ScreenScale);
        make.height.equalTo(185 * ScreenScale);
    }];
    field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,57 * ScreenScale , 185 * ScreenScale)];
    field.leftViewMode =  UITextFieldViewModeAlways;
    
    return cell;
}
-(UITableViewCell *)getForstCell{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    const float viewWidth = kScreenWidth - 90 * ScreenScale;
    UIView *whiteView = [[UIView alloc]init];
    [cell addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(57 * ScreenScale);
        make.width.equalTo(viewWidth);
        make.height.equalTo(230 * ScreenScale);
    }];
    whiteView.layer.cornerRadius = 10 * ScreenScale;
    whiteView.layer.masksToBounds = YES;
    
    
    UIButton *danger_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [danger_btn setBackgroundColor:[UIColor whiteColor]];
    danger_btn.tag = 11;
    [whiteView addSubview:danger_btn];
    [danger_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(0);
        make.width.equalTo(viewWidth / 4);
        make.height.equalTo(230 * ScreenScale);
    }];
    
   
    
    
    
    
    
    
    
    return cell;
}








@end
