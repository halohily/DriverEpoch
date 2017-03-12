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
@interface DrivingViewController ()<DrivingTopViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) NSString *locationStr;
@property (nonatomic, strong) NSArray *collectionItems;
@end

@implementation DrivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)initData
{
    self.collectionItems = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"image", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"s", @"name", @"epoch", @"image", nil], nil];
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

#pragma collectionview delegate
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
@end
