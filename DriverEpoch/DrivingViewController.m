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
#import "DEPOIViewController.h"
#import "WeatherController.h"

#import <CoreLocation/CoreLocation.h>


#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface DrivingViewController ()
<DrivingTopViewDelegate,
LocationViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
CLLocationManagerDelegate,
AMapSearchDelegate>

@property (nonatomic, strong) NSString *locationStr;

@property (nonatomic, strong) AMapReGeocode *locationDic;

@property (nonatomic, strong) NSArray *collectionItems;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D nowCoordinate;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) NSString *weatherKey;
@property (nonatomic, strong) NSMutableDictionary *weatherDic;

@end

@implementation DrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initData];
    [self initProperty];
    [self setupView];
    [self locate];
    
}

- (void)initData
{
    NSArray *itemArr = @[@{@"name": @"加油站", @"image": @"\U0000e64b", @"color": [UIColor redColor], @"bgcolor": DEColor(151, 225, 138)}, @{@"name": @"紧急呼救", @"image": @"\U0000e61b", @"color": [UIColor redColor], @"bgcolor": DEColor(242, 176, 163)}, @{@"name": @"停车场", @"image": @"\U0000e608", @"color": DEColor(255, 233, 35), @"bgcolor": DEColor(108, 209, 253)}, @{@"name": @"养护爱车", @"image": @"\U0000e875", @"color": DEColor(231, 226, 47), @"bgcolor": DENavBarColorBlue}, @{@"name": @"汽车维修", @"image": @"\U0000e6a5", @"color": DEColor(108, 209, 253), @"bgcolor": DEColor(242, 176, 163)}, @{@"name": @"汽车销售", @"image": @"\U0000e613", @"color": [UIColor yellowColor], @"bgcolor": DEColor(151, 225, 138)}, @{@"name": @"限行查询", @"image": @"\U0000e60b", @"color": DEColor(101, 101, 101), @"bgcolor": DEColor(249, 239, 192)}];
    self.collectionItems = itemArr;
}

- (void)initProperty
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAddress) name:@"changeAddress" object:nil];
    
    self.weatherKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"weather_key"];
}
- (void)locate
{
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
    self.topView = topview;
     NSLog(@"%@",self.collectionItems[2][@"name"]);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(DEAppWidth/2 - 0.5, (DEAppHeight - 150)/3 - 1);
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.minimumLineSpacing = 1.0;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, DEAppWidth, DEAppHeight - 150) collectionViewLayout:flowLayout];
    mainView.backgroundColor = DEColor(245, 245, 245);
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

#pragma mark private methods

- (void)changeAddress
{
    NSLog(@"地址已经改变");
    self.locationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
//    self.locationStr = @"这是一个新的地址";
}

- (void)updateWeather
{
    NSString *url = @"https://free-api.heweather.com/v5/now";
//    NSURL *url = [NSURL URLWithString:@"https://free-api.heweather.com/v5/now"];
    
    NSString *city = self.locationDic.addressComponent.city;
    NSDictionary *parameters = @{@"city": city, @"key": self.weatherKey};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
        NSLog(@"%@",responseObject);
        NSMutableArray *HeWeather = [responseObject objectForKey:@"HeWeather5"];
        NSMutableDictionary *object = [HeWeather objectAtIndex:0];
        NSMutableDictionary *now = [object objectForKey:@"now"];
        NSMutableDictionary *con = [now objectForKey:@"cond"];
        NSString *weatherStr = [con objectForKey:@"txt"];
        
        NSString *tmpStr = [now objectForKey:@"tmp"];
        
        NSLog(@"weather: %@,,, tmp: %@", weatherStr, tmpStr);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.topView.weatherLabel.text = weatherStr;
            self.topView.temperatureLabel.text = [NSString stringWithFormat:@"%@°", tmpStr];
        });
            }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
    }];

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
    DrivingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.itemName.text = self.collectionItems[indexPath.item][@"name"];
    cell.itemIcon.text = self.collectionItems[indexPath.item][@"image"];
    cell.itemIcon.textColor = self.collectionItems[indexPath.item][@"color"];
    cell.itemIcon.backgroundColor = self.collectionItems[indexPath.item][@"bgcolor"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 1 || indexPath.item == 6)
    {
        if (indexPath.item == 1){
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:110"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    }
    else
    {
        DEPOIViewController *poiVC = [[DEPOIViewController alloc] init];
        poiVC.location = self.nowCoordinate;
        if (indexPath.item == 0){
            poiVC.titleStr = @"加油站";
        }
        if (indexPath.item == 2){
            poiVC.titleStr = @"停车场";
        }
        if (indexPath.item == 3){
            poiVC.titleStr = @"汽车养护";
        }
        if (indexPath.item == 4){
            poiVC.titleStr = @"汽车维修";
        }
        if (indexPath.item == 5){
            poiVC.titleStr = @"汽车销售";
        }
        [self.navigationController pushViewController:poiVC animated:YES];
    }
    
}

#pragma mark location delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
   
    [self reverseGeoCode];
    
    AMapCoordinateType type = AMapCoordinateTypeGPS;
    _nowCoordinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude), type);
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)reverseGeoCode
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:_nowCoordinate.latitude longitude:_nowCoordinate.longitude];
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];

}

//接收反向地理编码结果
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        self.locationDic = response.regeocode;
        NSLog(@"%@",self.locationDic);
        
        [self updateWeather];
        
        NSString *neighbor = self.locationDic.addressComponent.neighborhood;
        NSString *building = self.locationDic.addressComponent.building;
        NSString *address = [NSString stringWithFormat:@"%@%@",neighbor,building];
        self.locationStr = address;
        if ([address isEqualToString:@""]){
            self.locationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
        }

    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

#pragma mark locationView delegate

- (void)reLocate
{
    [self locate];
}

#pragma mark topview delegate

- (void)reLocateBtnClick
{
    //    self.topView.locationLabel.text = @"s";
    NSLog(@"222");
    NSLog(@"%@",self.collectionItems[2][@"name"]);
    LocationViewController *locationView = [[LocationViewController alloc] init];
    locationView.delegate = self;
    NSString *city = self.locationDic.addressComponent.city;
    NSString *district = self.locationDic.addressComponent.district;
    NSString *neighbor = self.locationDic.addressComponent.neighborhood;
    NSString *building = self.locationDic.addressComponent.building;
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@", city, district, neighbor, building];
    locationView.locationStr = address;
    NSMutableArray *poiArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++)
    {
        if ([self.locationDic.pois count] > i){
            NSString *poiString = self.locationDic.pois[i].name;
            [poiArr addObject:poiString];
        }
    }
    locationView.pois = poiArr;
    [self presentViewController:locationView animated:YES completion:NULL];
    
}

- (void)weatherInfo
{
    NSLog(@"report!!!");
    WeatherController *weatherVC = [[WeatherController alloc] init];
    [self presentViewController:weatherVC animated:YES completion:nil];
}
#pragma mark setter
    
- (void)setLocationStr:(NSString *)locationStr
{
    _locationStr = locationStr;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.topView.locationLabel.text = _locationStr;
    });
    
}
@end
