//
//  DrivingViewController.m
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import "DrivingViewController.h"
#import "LocationViewController.h"
#import "DrivingCollectionViewCell.h"
#import "AFNetworking.h"

#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface DrivingViewController ()
<DrivingTopViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
CLLocationManagerDelegate,
BMKGeoCodeSearchDelegate>

@property (nonatomic, weak) NSString *locationStr;
@property (nonatomic, strong) NSArray *collectionItems;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D nowCoordinate;

@end

@implementation DrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self locate];
    [self setupView];
}

- (void)initData
{
    self.collectionItems = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"image", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], nil];
}
- (void)locate
{
    // 1.创建定位管理者
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUseAuthorization");
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    DrivingTopView *topview = [[DrivingTopView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, 100)];
    [self.view addSubview:topview];
    topview.delegate = self;
    self.locationStr = topview.locationLabel.text;
    self.topView = topview;
     NSLog(@"%@",self.collectionItems[2][@"name"]);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(DEAppWidth/2 - 2, DEAppWidth/2 - 2);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, DEAppWidth, DEAppHeight - 100) collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.delegate = self;
    mainView.dataSource = self;
    [mainView registerClass:[DrivingCollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:mainView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reLocateBtnClick
{
//    self.topView.locationLabel.text = @"s";
    NSLog(@"222");
    NSLog(@"%@",self.collectionItems[2][@"name"]);
    LocationViewController *locationView = [[LocationViewController alloc] init];
    locationView.locationStr = self.locationStr;
    [self presentViewController:locationView animated:YES completion:NULL];
    
}

#pragma mark collectionview delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_collectionItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrivingCollectionViewCell *cell = (DrivingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.itemName.text = _collectionItems[indexPath.item][@"name"];
    cell.itemName.text = @"search";
    cell.itemImage.image = [UIImage imageNamed:_collectionItems[indexPath.item][@"image"]];
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(DEAppWidth/2 - 2, DEAppWidth/2 - 2);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}
//- (UICollectionViewCell *)co

#pragma mark cllocaton delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    NSDictionary *tempDic = BMKConvertBaiduCoorFrom(coordinate,BMK_COORDTYPE_COMMON);
    NSLog(@"x=%@,y=%@",[tempDic objectForKey:@"x"],[tempDic objectForKey:@"y"]);
    _nowCoordinate = BMKCoorDictionaryDecode(tempDic);
    NSLog(@"nowCoor::x=%f, y=%f",_nowCoordinate.latitude,_nowCoordinate.longitude);
    [self reverseGeoCode];
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)reverseGeoCode
{
    //初始化检索对象
    BMKGeoCodeSearch *searcher =[[BMKGeoCodeSearch alloc]init];
    searcher.delegate = self;
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){39.915, 116.404};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [searcher reverseGeoCode:reverseGeoCodeSearchOption];

    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
//      在此处理正常结果
      NSString *address = result.address;
      self.topView.locationLabel.text = address;
      NSLog(@"%@",address);
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}
@end
