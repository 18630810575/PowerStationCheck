//
//  GettingCell.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/25.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "GettingCell.h"
#import "OrderModel.h"
#import "MissionModel.h"

#define kTitleColor UIColorFromRGB(0x333333)
#define kShadowColor UIColorFromRGB(0x58B4FF)
#define kNeedHandleColor UIColorFromRGB(0xFF423A)

static const int kOrderSelectedTag = 999;
static const int kMissionSelectedTag = 1000;
static const int kContentTag = 500;
static const int kLineTag = 600;

@interface GettingCell()



@end


@implementation GettingCell{
    UIView *contentView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndModel:(NSObject *)model AndLevel:(NSString *)level
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedState = NO;
        if ([level isEqualToString:@"0"]) {
            self.model = (OrderModel *)model;
            [self creatLevel0View];
            if (self.model.is_chosen) {
                _chosenButton.selected = YES;
            }
            
        }else if([level isEqualToString:@"1"]){
            self.mission = (MissionModel *)model;
            [self creatMissionView];
            if (self.mission.is_chosen) {
                _chosenButton.selected = YES;
            }
        }
        [self doBaseSettings];
        
        
    }
    return self;
}

-(void)creatLevel0View{
    [self creatTitle];
}

-(void)setBorder{
    
    UIView *content = [self viewWithTag:kContentTag];
    
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:content.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10*ScreenScale, 10*ScreenScale)];
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = content.bounds;
    //    maskLayer.path = maskPath.CGPath;
    //    content.layer.mask = maskLayer;
    content.layer.cornerRadius = 10*ScreenScale;
    UIView *line = [content viewWithTag:kLineTag];
    [line removeFromSuperview];
}

-(void)doBaseSettings{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)creatMissionView{
    UIView *content = [[UIView alloc]init];
    content.layer.masksToBounds = YES;
    content.tag = kContentTag;
    
    NSString *kChosenUnselectedName = @"";
    NSString *kChosenImageName = @"";
    if ([self.mission.is_urgency isEqualToString:@"0"]) {
        kChosenUnselectedName = @"unselected_blue";
        kChosenImageName = @"select_blue";
    }else{
        kChosenUnselectedName = @"unselected_red";
        kChosenImageName = @"select_red";
    }
    
    _chosenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chosenButton setBackgroundImage:[UIImage imageNamed:kChosenUnselectedName] forState:UIControlStateNormal];
    _chosenButton.tag = kMissionSelectedTag;
    [_chosenButton setBackgroundImage:[UIImage imageNamed:kChosenImageName] forState:UIControlStateSelected];
    [_chosenButton addTarget:self action:@selector(chosenThisOrder:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:_chosenButton];
    [_chosenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30*ScreenScale);
        make.centerY.equalTo(content);
        make.width.and.height.equalTo(50*ScreenScale);
    }];
    
    UIButton *hubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hubBtn.backgroundColor = [UIColor clearColor];
    [hubBtn addTarget:self action:@selector(chosenThisOrder:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:hubBtn];
    [hubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.centerY.equalTo(content);
        make.width.and.height.equalTo(content.height);
    }];
    
    
    UIView *shadowView= [[UIView alloc]init];
    [self addSubview:shadowView];
    
    shadowView.frame = CGRectMake((kScreenWidth-1147*ScreenScale)/2, 0, 1147*ScreenScale,165*ScreenScale);
    content.frame = CGRectMake(0, 0, 1147*ScreenScale, 165*ScreenScale);
    [shadowView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.mission.mission_name;
    titleLabel.font = [UIFont systemFontOfSize:48*ScreenScale];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    [content addSubview:titleLabel];
    if ([self.mission.is_update isEqualToString:@"1"]) {
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(100*ScreenScale);
            make.top.equalTo(30*ScreenScale);
            make.width.equalTo(1050*ScreenScale);
            make.height.equalTo(48*ScreenScale);
        }];
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.text = self.mission.update_time;
        timeLabel.font = [UIFont systemFontOfSize:35*ScreenScale];
        timeLabel.textColor = UIColorFromRGB(0x999999);
        [content addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.top.equalTo(titleLabel.bottom).offset(25*ScreenScale);
            make.width.equalTo(500*ScreenScale);
            make.height.equalTo(35*ScreenScale);
        }];
        if ([self.mission.need_handle isEqualToString:@"0"] && [self.mission.is_update isEqualToString:@"1"]) {
            timeLabel.alpha = 0.6;
            titleLabel.alpha = 0.6;
        }else if([self.mission.need_handle isEqualToString:@"0"]){
            titleLabel.textColor = kNeedHandleColor;
        }
    }else{
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(100*ScreenScale);
            make.centerY.equalTo(content);
            make.width.equalTo(1050*ScreenScale);
            make.height.equalTo(48*ScreenScale);
        }];
    }
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xD2D2D2);
    lineView.tag = kLineTag;
    [content addSubview:lineView];
    CGFloat width = content.bounds.size.width-110*ScreenScale;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(55*ScreenScale);
        make.bottom.equalTo(0);
        make.width.equalTo(width);
        make.height.equalTo(2*ScreenScale);
    }];
    
}

-(void)creatTitle{
    UIView *titleView = [[UIView alloc]init];
    titleView.layer.masksToBounds = YES;
    titleView.tag = kContentTag;
    
    
    UIView *shadowView= [[UIView alloc]init];
    [self addSubview:shadowView];
    
    shadowView.frame = CGRectMake((kScreenWidth-1147*ScreenScale)/2, 0, 1147*ScreenScale,130*ScreenScale);
    
    [shadowView addSubview:titleView];
    titleView.frame = CGRectMake(0, 0, 1147*ScreenScale,130*ScreenScale);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10*ScreenScale, 10*ScreenScale)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleView.bounds;
    maskLayer.path = maskPath.CGPath;
    titleView.layer.mask = maskLayer;
    
    NSString * kTopImageName = @"";
    NSString * kChosenImageName = @"select_white";
    NSString * kChosenUnselectedName = @"unselected_white";
    if ([self.model.is_urgency isEqualToString:@"0"]) {
        kTopImageName = @"theme_background";
        
    }else{
        kTopImageName = @"red_background";
    }
    UIImageView *headerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kTopImageName]];
    [titleView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.width.and.height.equalTo(titleView);
    }];

    _chosenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chosenButton setBackgroundImage:[UIImage imageNamed:kChosenUnselectedName] forState:UIControlStateNormal];
    _chosenButton.tag = kOrderSelectedTag;
    [_chosenButton setBackgroundImage:[UIImage imageNamed:kChosenImageName] forState:UIControlStateSelected];
    [_chosenButton addTarget:self action:@selector(chosenThisOrder:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:_chosenButton];
    [_chosenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30*ScreenScale);
        make.centerY.equalTo(titleView);
        make.width.and.height.equalTo(50*ScreenScale);
    }];
    
    UIButton *hubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hubBtn.backgroundColor = [UIColor clearColor];
    [hubBtn addTarget:self action:@selector(chosenThisOrder:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:hubBtn];
    [hubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.centerY.equalTo(titleView);
        make.width.and.height.equalTo(titleView.height);
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.model.order_name;
    titleLabel.font = [UIFont systemFontOfSize:47*ScreenScale];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(100*ScreenScale);
        make.top.equalTo(18*ScreenScale);
        make.width.equalTo(900*ScreenScale);
        make.height.equalTo(47*ScreenScale);
    }];
    
    UILabel *describeLabel = [[UILabel alloc]init];
    describeLabel.text = [NSString stringWithFormat:@"%@ - %@  任务:%d(已下载%d项)",self.model.begin_time,self.model.end_time,(int)self.model.mission.count,0];
    describeLabel.font = [UIFont systemFontOfSize:35*ScreenScale];
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.alpha = 0.8;
    [titleView addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.bottom).offset(15*ScreenScale);
        make.width.equalTo(900*ScreenScale);
        make.height.equalTo(35*ScreenScale);
    }];
    
    NSString *kOpenImageName = @"";
    if(self.model.is_open) {
        kOpenImageName = @"proj_up_white";
    }else{
        kOpenImageName = @"proj_down_white";
    }
    
    self.isOpenImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kOpenImageName]];
    [titleView addSubview:self.isOpenImageView];
    [self.isOpenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleView).offset(-35*ScreenScale);
        make.centerY.equalTo(titleView);
        make.width.equalTo(35*ScreenScale);
        make.height.equalTo(15*ScreenScale);
    }];
}

-(void)addFooter{
    
}

-(void)chosenThisOrder:(UIButton *)sender{
    _chosenButton.selected = !_chosenButton.selected;
    if (_chosenButton.tag == kOrderSelectedTag) {
        self.model.is_chosen = !self.model.is_chosen;
        self.orderBlock(self.model);
    }else{
        self.mission.is_chosen = !self.mission.is_chosen;
        self.missionBlock(self.mission);

    }
}

@end
