//
//  ScanViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP (SCREEN_HEIGHT-220)/2
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

static NSString *kAlertString = @"请将设备二维码放入框内，耐心等待";

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

#pragma mark - 二维码相关
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIImageView * line;

@end

@implementation ScanViewController{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    [self configView];
    [self.view bringSubviewToFront:self.navBar];
    // Do any additional setup after loading the view.
}

-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor blackColor];
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self doBaseSettings];
    [self doNavBarSettings];
    
    [self setCropRect:kScanRect];
    self.view.backgroundColor = [UIColor blackColor];

    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
    [self addItems];
    
}

-(void)addItems{

    UILabel *alertLabel = [[UILabel alloc]init];
    alertLabel.text = kAlertString;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.font = [UIFont systemFontOfSize:50*ScreenScale];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.alpha = 0.8;
    [self.view addSubview:alertLabel];
    
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(1550*ScreenScale);
        make.width.equalTo(self.view);
        make.height.equalTo(50*ScreenScale);
    }];
    
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightButton setBackgroundImage:[UIImage imageNamed:@"click_show_left"] forState:UIControlStateNormal];
    [lightButton addTarget:self action:@selector(turnOnTheLight: ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightButton];
    
    [lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-80*ScreenScale);
        make.centerX.equalTo(self.view);
        make.width.equalTo(195*ScreenScale);
        make.height.equalTo(215*ScreenScale);
    }];
    
}

-(void)turnOnTheLight:(UIButton *)sender{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) { // 判断是否有闪光灯
            // 请求独占访问硬件设备
            [device lockForConfiguration:nil];
            if (sender.tag == 0) {
                
                sender.tag = 1;
                [device setTorchMode:AVCaptureTorchModeOn]; // 手电筒开
            }else{
                
                sender.tag = 0;
                [device setTorchMode:AVCaptureTorchModeOff]; // 手电筒关
            }
            // 请求解除独占访问硬件设备
            [device unlockForConfiguration];
        }
    }
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num  = 0;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}
- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGFloat statusBarHeight =kStatusBarHeight;
    CGFloat y = statusBarHeight + 44.0;
    CGRect mainBounds = CGRectMake(0, y, kScreenWidth, kScreenHeight-y);
    CGPathAddRect(path, nil, mainBounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}
- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSData *needData =[[NSData alloc]initWithBase64EncodedString:stringValue options:0];
        NSDictionary *scanJsonDict = [NSJSONSerialization JSONObjectWithData:needData options:NSJSONReadingMutableContainers error:nil];
        if (scanJsonDict != nil) {
            if (scanJsonDict[@"deviceCode"]!=nil) {
                NSString *deviceCode = scanJsonDict[@"deviceCode"];
                NSLog(@"%@",deviceCode);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:deviceCode preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (_session != nil && timer != nil) {
                        [_session startRunning];
                        [timer setFireDate:[NSDate date]];
                    }
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"查看任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (_session != nil && timer != nil) {
                        [_session startRunning];
                        [timer setFireDate:[NSDate date]];
                    }
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                NSLog(@"Sorry! The devicecode is null");
            }
        }else{
            NSLog(@"无扫描信息");
        }
        
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@",temp);
        }
        
        

        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}





#pragma mark -----do settings-----
-(void)doNavBarSettings{
    float statusBarHeight = kStatusBarHeight;
    float navBarHeight = 44+statusBarHeight;
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(navBarHeight);
    }];
    [self.navBar setBackgroundImage];
    [self.navBar setNavTitle:self.title];
    
    UIImageView *backImg = [[UIImageView alloc]initWithImage:image(@"white_close")];
    [self.navBar addSubview:backImg];
    
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10 + 12);
        make.top.equalTo(20 + 12);
        make.width.and.height.equalTo(20);
    }];
    UIButton *backHudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backHudBtn.backgroundColor = [UIColor clearColor];
    [backHudBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:backHudBtn];
    [backHudBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.left.equalTo(10);
        make.width.and.height.equalTo(44);
    }];
}

-(void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
