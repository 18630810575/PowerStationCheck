//
//  ProjectCell.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "ProjectCell.h"
#import "OrderModel.h"
#import "MissionModel.h"

#define kTitleColor UIColorFromRGB(0x333333)
#define kShadowColor UIColorFromRGB(0x58B4FF)
#define kNeedHandleColor UIColorFromRGB(0xFF423A)

static const int kContentTag = 500;
static const int kLineTag = 600;

@interface ProjectCell ()

@property (nonatomic , strong) OrderModel *model;
@property (nonatomic , strong) MissionModel *mission;
@end

@implementation ProjectCell{
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
        if ([level isEqualToString:@"0"]) {
            self.model = (OrderModel *)model;
            [self creatLevel0View];
        }else if([level isEqualToString:@"1"]){
            self.mission = (MissionModel *)model;
            [self creatMissionView];
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
            make.left.equalTo(55*ScreenScale);
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
            make.left.equalTo(55*ScreenScale);
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

//-(void)creatContentView{
//    int count = (int)self.model.mission.count;
//    CGFloat height = count* 165*ScreenScale+130*ScreenScale;

//
//    contentView = [[UIView alloc]init];
//    contentView.backgroundColor = [UIColor whiteColor];
//    contentView.layer.cornerRadius = 10*ScreenScale;
//    contentView.layer.masksToBounds = YES;
//    [shadowView addSubview:contentView];
//
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(0);
//        make.width.equalTo(1147*ScreenScale);
//        make.height.equalTo(height);
//    }];
//}

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
    
    NSString *kLeftTypeImage = @"";
    if ([self.model.order_type isEqualToString:@"1"]) {
        kLeftTypeImage = @"normal";
    }else{
        kLeftTypeImage = @"urgency";
    }
    UIImageView *leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kLeftTypeImage]];
    [titleView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView);
        make.left.equalTo(35*ScreenScale);
        make.width.and.height.equalTo(51*ScreenScale);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.model.order_name;
    titleLabel.font = [UIFont systemFontOfSize:47*ScreenScale];
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageView.right).offset(20*ScreenScale);
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
}

-(void)addFooter{

}




@end
