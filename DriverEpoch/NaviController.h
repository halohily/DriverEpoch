//
//  NaviController.h
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/1.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface NaviController : UIViewController

@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;
@end
