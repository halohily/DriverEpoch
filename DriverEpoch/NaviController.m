//
//  NaviController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/1.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "NaviController.h"

@interface NaviController ()<AMapNaviDriveManagerDelegate, MAMapViewDelegate, AMapNaviDriveViewDelegate>

//@property (nonatomic ,strong) MAMapView *map;
@property (nonatomic, strong) AMapNaviDriveManager *driveManager;
@property (nonatomic, strong) AMapNaviDriveView *driveView;
@end

@implementation NaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperty];
    [self calculateRoutes];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperty
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
    }
    if (self.driveView == nil)
    {
        AMapNaviDriveView *driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 20, DEAppWidth, DEAppHeight - 20)];
        driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [driveView setDelegate:self];
        [self.view addSubview:driveView];
        self.driveView = driveView;
        
        //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
        [self.driveManager addDataRepresentative:self.driveView];
    }
}
- (void)calculateRoutes
{
    [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:17];
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    //算路成功后开始GPS导航
    [self.driveManager startGPSNavi];
    //显示路径或开启导航
}

#pragma mark driveView delegate

-(void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出导航?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确认");
        [alert dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark view config
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    UIColor *color = DEColor(40, 44, 55);
    [self setStatusBarBackgroundColor:color];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self setStatusBarBackgroundColor:nil];
}
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}
@end
