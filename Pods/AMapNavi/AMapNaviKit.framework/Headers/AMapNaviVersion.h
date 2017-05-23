//
//  AMapNaviVersion.h
//  AMapNaviKit
//
//  Created by AutoNavi on 16/1/7.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationVersion.h>
#import <MAMapKit/MAMapVersion.h>

#ifndef AMapNaviVersion_h
#define AMapNaviVersion_h

#define AMapNaviVersionNumber                   50000
#define AMapNaviFoundationVersionMinRequired    10304
#define AMapNavi3DMapVersionMinRequired         50000

/// 依赖库版本检测
#if AMapFoundationVersionNumber < AMapNaviFoundationVersionMinRequired
#error "The AMapFoundationKit version is less than minimum required, please update! Any questions please to visit http://lbs.amap.com"
#endif

#if MAMapVersionNumber < AMapNavi3DMapVersionMinRequired
#error "The MAMapKit(3D Version) version is less than minimum required, please update! Any questions please to visit http://lbs.amap.com"
#endif

FOUNDATION_EXTERN NSString * const AMapNaviVersion;
FOUNDATION_EXTERN NSString * const AMapNaviName;

#endif /* AMapNaviVersion_h */
