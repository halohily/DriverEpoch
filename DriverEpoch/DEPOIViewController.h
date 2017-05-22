//
//  DEPOIViewController.h
//  DriverEpoch
//
//  Created by 刘毅 on 2017/4/30.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface DEPOIViewController : UIViewController

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, assign) BOOL canDate;
@end
