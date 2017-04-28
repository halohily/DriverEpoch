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


#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface DrivingViewController ()
<DrivingTopViewDelegate,
LocationViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
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
    self.collectionItems = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"image", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], nil];
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
        
        self.topView.weatherLabel.text = weatherStr;
        self.topView.temperatureLabel.text = [NSString stringWithFormat:@"%@°", tmpStr];
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
    }];
//    AFHTTPRequestSerializer *manager = [AFHTTPRequestSerializer serializer];
//    [manager GET:url parameters:parameters progress:<#^(NSProgress * _Nonnull downloadProgress)downloadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>]
//    [manager requestBySerializingRequest:<#(nonnull NSURLRequest *)#> withParameters:<#(nullable id)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
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

#pragma mark collection delegate
    
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
}
#pragma mark setter
    
- (void)setLocationStr:(NSString *)locationStr
{
    _locationStr = locationStr;
    self.topView.locationLabel.text = _locationStr;
}
@end
