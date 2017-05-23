//
//  AMapNaviDriveManager.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/1/12.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviBaseManager.h"
#import "AMapNaviDriveDataRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AMapNaviDriveManagerDelegate;

#pragma mark - AMapNaviDriveManager

///驾车导航管理类
@interface AMapNaviDriveManager : AMapNaviBaseManager

#pragma mark - Delegate

///实现了 AMapNaviDriveManagerDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviDriveManagerDelegate> delegate;

#pragma mark - Data Representative

/**
 * @brief 增加用于展示导航数据的DataRepresentative.注意:该方法不会增加实例对象的引用计数(Weak Reference)
 * @param aRepresentative 实现了 AMapNaviDriveDataRepresentable 协议的实例
 */
- (void)addDataRepresentative:(id<AMapNaviDriveDataRepresentable>)aRepresentative;

/**
 * @brief 移除用于展示导航数据的DataRepresentative
 * @param aRepresentative 实现了 AMapNaviDriveDataRepresentable 协议的实例
 */
- (void)removeDataRepresentative:(id<AMapNaviDriveDataRepresentable>)aRepresentative;

#pragma mark - Navi Route

///当前导航路径的ID
@property (nonatomic, readonly) NSInteger naviRouteID;

///当前导航路径的信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) AMapNaviRoute *naviRoute;

///多路径规划时的所有路径ID,路径ID为 NSInteger 类型.
@property (nonatomic, readonly, nullable) NSArray<NSNumber *> *naviRouteIDs;

///多路径规划时的所有路径信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes;

/**
 * @brief 多路径规划时选择路径.注意:该方法仅限于在开始导航前使用,开始导航后该方法无效.
 * @param routeID 路径ID
 * @return 是否选择路径成功
 */
- (BOOL)selectNaviRouteWithRouteID:(NSInteger)routeID;

#pragma mark - Options

///是否播报摄像头信息,默认YES.
@property (nonatomic, assign) BOOL updateCameraInfo;

///是否播报交通信息,默认YES(需要联网).
@property (nonatomic, assign) BOOL updateTrafficInfo;

///偏航时是否重新计算路径,默认YES(需要联网). 已废弃，默认进行重算，since 5.0.0
@property (nonatomic, assign) BOOL isRecalculateRouteForYaw __attribute__((deprecated("已废弃，默认进行重算，since 5.0.0")));

///前方拥堵时是否重新计算路径,默认YES(需要联网). 已废弃，默认进行重算，since 5.0.0
@property (nonatomic, assign) BOOL isRecalculateRouteForTrafficJam __attribute__((deprecated("已废弃，默认进行重算，since 5.0.0")));

///智能播报模式,默认为 AMapNaviDetectedModeNone (需要联网).智能播报适用于不设置目的驾车过程中,播报电子眼、特殊道路设施等信息.巡航信息参考 AMapNaviCruiseInfo ,  AMapNaviTrafficFacilityInfo 类及相关回调.
@property (nonatomic, assign) AMapNaviDetectedMode detectedMode;

#pragma mark - Calculate Route

// 以下算路方法需要高德坐标(GCJ02)

/**
 * @brief 不带起点的驾车路径规划
 * @param endPoints    终点坐标.终点列表的尾点为实际导航终点.
 * @param wayPoints    途经点坐标,最多支持16个途经点.
 * @param strategy     路径的计算策略
 * @return 规划路径是否成功
 */
- (BOOL)calculateDriveRouteWithEndPoints:(NSArray<AMapNaviPoint *> *)endPoints
                               wayPoints:(nullable NSArray<AMapNaviPoint *> *)wayPoints
                         drivingStrategy:(AMapNaviDrivingStrategy)strategy;

/**
 * @brief 带起点的驾车路径规划
 * @param startPoints  起点坐标.起点列表的尾点为实际导航起点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @param endPoints    终点坐标.终点列表的尾点为实际导航终点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @param wayPoints    途经点坐标,最多支持16个途经点.
 * @param strategy     路径的计算策略
 * @return 规划路径是否成功
 */
- (BOOL)calculateDriveRouteWithStartPoints:(NSArray<AMapNaviPoint *> *)startPoints
                                 endPoints:(NSArray<AMapNaviPoint *> *)endPoints
                                 wayPoints:(nullable NSArray<AMapNaviPoint *> *)wayPoints
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy;

/**
 * @brief 导航过程中重新规划路径(起点为当前位置,途经点和终点位置不变)
 * @param strategy 路径的计算策略
 * @return 规划路径是否成功
 */
- (BOOL)recalculateDriveRouteWithDrivingStrategy:(AMapNaviDrivingStrategy)strategy;

#pragma mark - Manual

/**
 * @brief 设置车牌信息
 * @param province 车牌省份缩写，例如："京"
 * @param number 除省份及标点之外，车牌的字母和数字，例如："NH1N11"
 */
- (void)setVehicleProvince:(NSString *)province number:(NSString *)number;

/**
 * @brief 设置播报模式,默认新手详细播报( AMapNaviBroadcastModeDetailed )
 * @return 是否成功
 */
- (BOOL)setBroadcastMode:(AMapNaviBroadcastMode)mode;

/**
 * @brief 手动刷新路况信息,调用后会刷新路况光柱. 已废弃，since 5.0.0.
 */
- (void)refreshTrafficStatusesManual __attribute__((deprecated("已废弃，since 5.0.0")));

/**
 * @brief 设置TTS语音播报每播报一个字需要的时间. 已废弃，使用 driveManagerIsNaviSoundPlaying: 替代，since 5.0.0
 * @param time 每个字的播放时间(范围:[250,500]; 单位:毫秒)
 */
- (void)setTimeForOneWord:(int)time __attribute__((deprecated("已废弃，使用 driveManagerIsNaviSoundPlaying: 替代，since 5.0.0")));

#pragma mark - Traffic Status

/**
 * @brief 获取某一范围内的路况光柱信息
 * @param startPosition 光柱范围在路径中的起始位置,取值范围[0, routeLength)
 * @param distance 光柱范围的距离,startPosition + distance 和的取值范围(0, routelength]
 * @return 该范围内路况信息数组,可用于绘制光柱,参考 AMapNaviTrafficStatus 类.
 */
- (nullable NSArray<AMapNaviTrafficStatus *> *)getTrafficStatusesWithStartPosition:(int)startPosition distance:(int)distance;

/**
 *  获取当前道路的路况光柱信息
 *
 *  @return 该范围内路况信息数组,可用于绘制光柱,参考 AMapNaviTrafficStatus 类.
 */
- (nullable NSArray<AMapNaviTrafficStatus *> *)getTrafficStatuses;

#pragma mark - Statistics Information

/**
 * @brief 获取导航统计信息. 已废弃，since 5.0.0
 * @return 导航统计信息,参考 AMapNaviStatisticsInfo 类.
 */
- (nullable AMapNaviStatisticsInfo *)getNaviStatisticsInfo __attribute__((deprecated("已废弃，since 5.0.0")));

@end

#pragma mark - AMapNaviDriveManagerDelegate

@protocol AMapNaviDriveManagerDelegate <NSObject>
@optional

/**
 * @brief 发生错误时,会调用代理的此方法
 * @param driveManager 驾车导航管理类
 * @param error 错误信息
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error;

/**
 * @brief 驾车路径规划成功后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 驾车路径规划失败后的回调函数
 * @param error 错误信息,error.code参照 AMapNaviCalcRouteState .
 * @param driveManager 驾车导航管理类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error;

/**
 * @brief 启动导航后回调函数
 * @param naviMode 导航类型，参考 AMapNaviMode .
 * @param driveManager 驾车导航管理类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode;

/**
 * @brief 出现偏航需要重新计算路径时的回调函数.偏航后将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理.
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 前方遇到拥堵需要重新计算路径时的回调函数.拥堵后将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理.
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航到达某个途经点的回调函数
 * @param driveManager 驾车导航管理类
 * @param wayPointIndex 到达途径点的编号，标号从1开始
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex;

/**
 * @brief SDK需要实时的获取是否正在进行导航信息播报，以便SDK内部控制 "导航播报信息回调函数" 的触发时机，避免出现下一句话打断前一句话的情况
 * @param driveManager 驾车导航管理类
 * @return 返回当前是否正在进行导航信息播报,如一直返回YES，"导航播报信息回调函数"就一直不会触发，如一直返回NO，就会出现语句打断情况，所以请根据实际情况返回。
 */
- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航播报信息回调函数,此回调函数需要和driveManagerIsNaviSoundPlaying:配合使用
 * @param driveManager 驾车导航管理类
 * @param soundString 播报文字
 * @param soundStringType 播报类型,参考 AMapNaviSoundType .
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;

/**
 * @brief 模拟导航到达目的地停止导航后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager;

/**
 * @brief 导航到达目的地后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager;

@end

NS_ASSUME_NONNULL_END
