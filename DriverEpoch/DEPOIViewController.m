//
//  DEPOIViewController.m
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/30.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DEPOIViewController.h"
#import "DEPOICell.h"
#import "NaviController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface DEPOIViewController ()<UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate, DEPOICellDelegate>
{
    CGRect listFrame;
    CGRect listFullFrame;
    BOOL showMap;
}
@property (nonatomic, strong) UITableView *poiList;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapPOISearchResponse *response;
@property (nonatomic, strong) UIView *loading;
@end

@implementation DEPOIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperty];
    [self fetchData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchData
{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.location.latitude longitude:self.location.longitude];
    request.keywords            = self.titleStr;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    NSLog(@"%@",response);
    self.response = response;
    
    listFrame = CGRectMake(0, 300, DEAppWidth, 100 * response.pois.count >= DEAppHeight -  300 ? DEAppHeight - 300  : 100 * response.pois.count);
    listFullFrame = CGRectMake(0, 64, DEAppWidth, 100 * response.pois.count >= DEAppHeight - 64? DEAppHeight - 64 : 100 * response.pois.count);
    self.poiList.frame = listFrame;
    
    [self.poiList reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.loading removeFromSuperview];
    });
}

- (void)initProperty
{
    showMap = YES;
    [self initloading];
    [self.view addSubview:self.loading];
    
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 300)];
    mapView.showsScale = NO;
    mapView.showsCompass = NO;
    mapView.logoCenter = CGPointMake(DEAppWidth - 50, 285);
    mapView.zoomLevel = 16;
    mapView.minZoomLevel = 14;
    mapView.maxZoomLevel = 17;
    
    ///把地图添加至view
    [self.view insertSubview:mapView atIndex:0];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MAUserTrackingModeFollow;

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
    
    [backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    backBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    backBtn.layer.cornerRadius = 15;
    backBtn.layer.masksToBounds = YES;
    [self.view insertSubview:backBtn aboveSubview:mapView];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView *list = [[UITableView alloc] init];
    list.delegate = self;
    list.dataSource = self;
    list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view insertSubview:list atIndex:1];

    [list registerClass:[DEPOICell class] forCellReuseIdentifier:@"poiCell"];
    self.poiList = list;
    
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.response.pois.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEPOICell *cell = [self.poiList dequeueReusableCellWithIdentifier:@"poiCell"];
    cell.delegate = self;
    cell.name.text = self.response.pois[indexPath.row].name;
    cell.location.text = self.response.pois[indexPath.row].address;
    
    if (indexPath.row == 0){
        [cell.contentView addSubview:cell.datingBtn];
    }
    
    CGFloat distance = self.response.pois[indexPath.row].distance;
    if (distance/1000 >= 1){
        cell.distance.text = [NSString stringWithFormat:@"%.1f公里",distance/1000];
    }
    else{
        cell.distance.text = [NSString stringWithFormat:@"%d米",(int)distance];
    }
    cell.tel = self.response.pois[indexPath.row].tel;
    cell.index = indexPath.row;
    return cell;
}
//判断滑动手势方向，决定tableview的frame改变
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (translation.y>0) {
        NSLog(@"ssssss");
        {
            NSIndexPath *dic = self.poiList.indexPathsForVisibleRows.firstObject;
            if (self.poiList.frame.origin.y == 64 && dic.row == 0){
                [UIView animateWithDuration:0.2 animations:^{
                    
                    NSLog(@"visible:::%@",dic);
                    showMap = YES;
                    self.navigationController.navigationBar.hidden = YES;
                    self.poiList.frame = listFrame;
                }];
            }
        }
    }else if(translation.y<0){
        NSLog(@"tttt");
        if (self.poiList.frame.origin.y == 300){
            [UIView animateWithDuration:0.2 animations:^{
                showMap = NO;
                self.navigationController.navigationBar.hidden = NO;
                self.poiList.frame = listFullFrame;
            }];
        }
    }
}

#pragma mark loadingView
- (void)initloading
{
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    loadingView.backgroundColor = DEColor(245, 245, 245);
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 30, 30, 30)];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30.0];
    
    [backBtn setTitle:@"\U0000e604" forState:UIControlStateNormal];
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    backBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    backBtn.layer.cornerRadius = 15;
    backBtn.layer.masksToBounds = YES;
    [loadingView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(DEAppWidth / 2 - 50, 200, 100, 100)];
    [logo setImage:[UIImage imageNamed:@"logo"]];
    [loadingView addSubview:logo];
    
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 0.5f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [logo.layer addAnimation:animation forKey:@"aAlpha"];
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, DEAppWidth, 20)];
    tips.textColor = DENavBarColorBlue;
    tips.text = @"加载中...";
    tips.textAlignment =  NSTextAlignmentCenter;
    tips.font = [UIFont systemFontOfSize:20.0];
    [loadingView addSubview:tips];
    
    self.loading = loadingView;
    
}
#pragma mark depoicell delegate
- (void)callNumber:(NSString *)tel
{
    NSLog(@"clicked!!!");
    if ([tel isEqualToString:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抱歉，该商户无电话" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
    
}

- (void)naviForIndex:(NSUInteger)index
{
    NaviController *naviVC = [[NaviController alloc] init];
    naviVC.startPoint = [AMapNaviPoint locationWithLatitude:self.location.latitude longitude:self.location.longitude];
    naviVC.endPoint = [AMapNaviPoint locationWithLatitude:self.response.pois[index].location.latitude longitude:self.response.pois[index].location.longitude];
    [self.navigationController pushViewController:naviVC animated:YES];
}

- (void)date
{
    NSLog(@"1111");
}
- (void)viewWillAppear:(BOOL)animated
{
    self.title = self.titleStr;
    if (!showMap){
        self.navigationController.navigationBar.hidden = NO;
    }
    else{
        self.navigationController.navigationBar.hidden = YES;
    }
    
    
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
