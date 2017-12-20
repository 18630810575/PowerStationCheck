//
//  MineViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *headerView;
@property (nonatomic,strong)UIButton *headerBtn;
@property (nonatomic,strong)UITableView *tabelView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 私有方法 -
-(void)changeAvater{
    #ifdef IS_OPEN_NSLOG
       NSLog(@"点击了头像");
    #endif
}


#pragma mark - tabview -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark - getters -
-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
        UIImageView *avaterImg = [[UIImageView alloc]init];
        avaterImg.image = image(@"");
        [avaterImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(160 * ScreenScale);
            make.left.equalTo((kScreenWidth - 232 * ScreenScale)/2);
            make.width.equalTo(232 * ScreenScale);
            make.height.equalTo(232 * ScreenScale);
        }];
        avaterImg.image = image(@"");
        avaterImg.layer.cornerRadius = 232 / 2 * ScreenScale;
        avaterImg.layer.borderColor = [[UIColor whiteColor]CGColor];
        avaterImg.layer.borderWidth = 2;
        [_headerView addSubview:avaterImg];
    }
    return _headerView;
}
-(UIButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerBtn setBackgroundColor:[UIColor clearColor]];
        [_headerBtn setBackgroundImage:image(@"") forState:UIControlStateNormal];
        [_headerBtn addTarget:self action:@selector(changeAvater) forControlEvents:UIControlEventTouchUpInside];
     }
    return _headerBtn;
}

-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]init];
        _tabelView.style
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabelView.delegate =self;
        _tabelView.dataSource =self;
        _tabelView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _tabelView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = FALSE;
        }
        _tabelView.showsVerticalScrollIndicator = YES;
    }
}









@end
