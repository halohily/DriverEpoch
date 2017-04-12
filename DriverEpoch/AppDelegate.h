//
//  AppDelegate.h
//  DriverEpoch
//
//  Created by halohily on 2017/3/9.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

