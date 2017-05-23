//
//  AMapNaviDriveDataRepresentable.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/1/13.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviCommonObj.h"

NS_ASSUME_NONNULL_BEGIN

@class AMapNaviInfo;
@class AMapNaviRoute;
@class AMapNaviLocation;
@class AMapNaviStatisticsInfo;
@class AMapNaviDriveManager;

/**
 * @brief AMapNaviDriveDataRepresentable协议.实例对象可以通过实现该协议,并将其通过 AMapNaviDriveManager 的addDataRepresentative:方法进行注册,便可获取导航过程中的导航数据更新.
 * 可以根据不同需求,选取使用特定的数据进行导航界面自定义. 
 * AMapNaviDriveView 即通过该协议实现导航过程展示.也可以依据导航数据的更新进行其他的逻辑处理.
 */
@protocol AMapNaviDriveDataRepresentable <NSObject>
@optional

/**
 * @brief 导航模式更新回调
 * @param driveManager 驾车导航管理类
 * @param naviMode 导航模式,参考 AMapNaviMode 值
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviMode:(AMapNaviMode)naviMode;

/**
 * @brief 路径ID更新回调
 * @param driveManager 驾车导航管理类
 * @param naviRouteID 导航路径ID
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviRouteID:(NSInteger)naviRouteID;

/**
 * @brief 路径信息更新回调
 * @param driveManager 驾车导航管理类
 * @param naviRoute 路径信息,参考 AMapNaviRoute 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviRoute:(nullable AMapNaviRoute *)naviRoute;

/**
 * @brief 导航信息更新回调
 * @param driveManager 驾车导航管理类
 * @param naviInfo 导航信息,参考 AMapNaviInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviInfo:(nullable AMapNaviInfo *)naviInfo;

/**
 * @brief 自车位置更新回调 (since 5.0.0，模拟导航和GPS导航的自车位置更新都会走此回调)
 * @param driveManager 驾车导航管理类
 * @param naviLocation 自车位置信息,参考 AMapNaviLocation 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviLocation:(nullable AMapNaviLocation *)naviLocation;

/**
 * @brief 需要显示路口放大图时的回调
 * @param driveManager 驾车导航管理类
 * @param crossImage 路口放大图Image(size:500*320)
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager showCrossImage:(UIImage *)crossImage;

/**
 * @brief 需要隐藏路口放大图时的回调
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerHideCrossImage:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 需要显示车道信息时的回调.可通过 UIImage *CreateLaneInfoImageWithLaneInfo(NSString *laneBackInfo, NSString *laneSelectInfo); 方法创建车道信息图片
 * 0-直行; 1-左转; 2-直行和左转; 3-右转;
 * 4-直行和右转; 5-左转掉头; 6-左转和右转; 7-直行和左转和右转;
 * 8-右转掉头; 9-直行和左转掉头; a-直行和右转掉头; b-左转和左转掉头;
 * c-右转和右转掉头; d-左侧变宽直行; e-左侧变宽左转和左转掉头; f-保留;
 *
 * @param driveManager 驾车导航管理类
 * @param laneBackInfo 车道背景信息，例如：@"1|0|0|0|3|f|f|f"，表示当前道路有5个车道，分别为"左转-直行-直行-直行-右转"
 * @param laneSelectInfo 车道前景信息，例如：@"f|0|0|0|f|f|f|f"，表示选择当前道路的2、3、4三个直行车道
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager showLaneBackInfo:(NSString *)laneBackInfo laneSelectInfo:(NSString *)laneSelectInfo;

/**
 * @brief 需要隐藏车道信息时的回调
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerHideLaneInfo:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 路况光柱信息更新回调
 * @param driveManager 驾车导航管理类
 * @param trafficStatus 路况光柱信息数组,参考 AMapNaviTrafficStatus 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateTrafficStatus:(nullable NSArray<AMapNaviTrafficStatus *> *)trafficStatus;

/**
 * @brief 巡航道路设施信息更新回调.该更新回调只有在detectedMode开启后有效
 * @param driveManager 驾车导航管理类
 * @param trafficFacilities 道路设施信息数组,参考 AMapNaviTrafficFacilityInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateTrafficFacilities:(nullable NSArray<AMapNaviTrafficFacilityInfo *> *)trafficFacilities;

/**
 * @brief 巡航信息更新回调.该更新回调只有在detectedMode开启后有效
 * @param driveManager 驾车导航管理类
 * @param cruiseInfo 巡航信息,参考 AMapNaviCruiseInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateCruiseInfo:(nullable AMapNaviCruiseInfo *)cruiseInfo;

/**
 * @brief 电子眼信息更新回调 since 5.0.0
 * @param driveManager 驾车导航管理类
 * @param cameraInfos 电子眼信息,参考 AMapNaviCameraInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateCameraInfos:(nullable NSArray<AMapNaviCameraInfo *> *)cameraInfos;

/**
 * @brief 服务区和收费站信息更新回调 since 5.0.0
 * @param driveManager 驾车导航管理类
 * @param serviceAreaInfos 服务区信息,参考 AMapNaviServiceAreaInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateServiceAreaInfos:(nullable NSArray<AMapNaviServiceAreaInfo *> *)serviceAreaInfos;

@end

NS_ASSUME_NONNULL_END
