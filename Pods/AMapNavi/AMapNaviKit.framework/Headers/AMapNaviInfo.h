//
//  AMapNaviInfo.h
//  AMapNaviKit
//
//  Created by AutoNavi on 14-8-22.
//  Copyright (c) 2014年 Amap. All rights reserved.
//

#import "AMapNaviCommonObj.h"

///导航过程中的导航信息
@interface AMapNaviInfo : NSObject<NSCopying,NSCoding>

///导航信息更新类型
@property (nonatomic, assign) AMapNaviMode naviMode;

///导航段转向图标类型
@property (nonatomic, assign) AMapNaviIconType iconType;

///deprecated.自车方向,单位度(正北为0,顺时针增加) \n since 5.0.0 模拟导航和GPS导航的自车位置更新都会通过 driveManager:updateNaviLocation: 返回,所以AMapNaviInfo不再提供自车方向
@property (nonatomic, assign) NSInteger carDirection __attribute__((deprecated("该字段已废弃 since 5.0.0")));

///deprecated.自车经纬度 \n since 5.0.0 模拟导航和GPS导航的自车位置更新都会通过 driveManager:updateNaviLocation: 返回,所以AMapNaviInfo不再提供自车经纬度
@property (nonatomic, strong) AMapNaviPoint *carCoordinate __attribute__((deprecated("该字段已废弃 since 5.0.0")));

///当前道路名称
@property (nonatomic, strong) NSString *currentRoadName;

///下条道路名称
@property (nonatomic, strong) NSString *nextRoadName;

///离终点剩余距离(单位:米)
@property (nonatomic, assign) NSInteger routeRemainDistance;

///离终点预估剩余时间(单位:秒)
@property (nonatomic, assign) NSInteger routeRemainTime;

///当前所在的segment段的index,从0开始
@property (nonatomic, assign) NSInteger currentSegmentIndex;

///当前路段剩余距离(单位:米)
@property (nonatomic, assign) NSInteger segmentRemainDistance;

///当前路段预估剩余时间(单位:秒)
@property (nonatomic, assign) NSInteger segmentRemainTime;

///当前所在的link段的index,从0开始
@property (nonatomic, assign) NSInteger currentLinkIndex;

// 以下导航信息仅在驾车导航时有效

///deprecated.电子眼在路径上的编号,总是指下一个将要路过的电子眼的编号,若为-1则路上没有电子眼. \n since 5.0.0 导航过程中的电子眼信息更新会通过 driveManager:updateCameraInfos: 返回
@property (nonatomic, assign) NSInteger cameraIndex __attribute__((deprecated("该字段已废弃 since 5.0.0")));

///deprecated.电子眼距离(单位:米; -1为没有电子眼或距离很远). \n since 5.0.0 导航过程中的电子眼信息更新会通过 driveManager:updateCameraInfos: 返回
@property (nonatomic, assign) NSInteger cameraDistance __attribute__((deprecated("该字段已废弃，使用AMapNaviCameraInfo.distance，since 5.0.0")));

///deprecated.电子眼类型(0为测速摄像头,1为监控摄像头). \n since 5.0.0 导航过程中的电子眼信息更新会通过 driveManager:updateCameraInfos: 返回
@property (nonatomic, assign) NSInteger cameraType __attribute__((deprecated("该字段已废弃，使用AMapNaviCameraInfo.cameraType，since 5.0.0")));

///deprecated.电子眼经纬度. \n since 5.0.0 导航过程中的电子眼信息更新会通过 driveManager:updateCameraInfos: 返回
@property (nonatomic, strong) AMapNaviPoint *cameraCoordinate __attribute__((deprecated("该字段已废弃，使用AMapNaviCameraInfo.coordinate，since 5.0.0")));

///deprecated.电子眼限速(0为无限速信息). \n since 5.0.0 导航过程中的电子眼信息更新会通过 driveManager:updateCameraInfos: 返回
@property (nonatomic, assign) NSInteger cameraLimitSpeed __attribute__((deprecated("该字段已废弃，使用AMapNaviCameraInfo.cameraSpeed，since 5.0.0")));

///deprecated.离服务站距离(单位:米; -1为没有服务站). \n since 5.0.0 导航过程中的服务区信息更新会通过 driveManager:updateServiceAreaInfos: 返回
@property (nonatomic, assign) NSInteger serviceAreaDistance __attribute__((deprecated("该字段已废弃，使用AMapNaviServiceAreaInfo.remainDistance，since 5.0.0")));

@end
