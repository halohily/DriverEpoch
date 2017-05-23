//
//  AMapNaviWalkManager.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/1/13.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviBaseManager.h"
#import "AMapNaviWalkDataRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AMapNaviWalkManagerDelegate;

#pragma mark - AMapNaviWalkManager

///步行导航管理类
@interface AMapNaviWalkManager : AMapNaviBaseManager

#pragma mark - Delegate

///实现了 AMapNaviWalkManagerDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviWalkManagerDelegate> delegate;

#pragma mark - Data Representative

/**
 * @brief 增加用于展示导航数据的DataRepresentative.注意:该方法不会增加实例对象的引用计数(Weak Reference)
 * @param aRepresentative 实现了 AMapNaviWalkDataRepresentable 协议的实例
 */
- (void)addDataRepresentative:(id<AMapNaviWalkDataRepresentable>)aRepresentative;

/**
 * @brief 移除用于展示导航数据的DataRepresentative
 * @param aRepresentative 实现了 AMapNaviWalkDataRepresentable 协议的实例
 */
- (void)removeDataRepresentative:(id<AMapNaviWalkDataRepresentable>)aRepresentative;

#pragma mark - Navi Route

///当前导航路径的ID
@property (nonatomic, readonly) NSInteger naviRouteID;

///当前导航路径的信息,参考 AMapNaviRoute 类.
@property (nonatomic, readonly, nullable) AMapNaviRoute *naviRoute;

#pragma mark - Options

///偏航时是否重新计算路径,默认YES(需要联网).
@property (nonatomic, assign) BOOL isRecalculateRouteForYaw;

#pragma mark - Calculate Route

// 以下算路方法需要高德坐标(GCJ02)

/**
 * @brief 不带起点的步行路径规划
 * @param endPoints 终点坐标.支持多个终点,终点列表的尾点为实际导航终点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @return 规划路径是否成功
 */
- (BOOL)calculateWalkRouteWithEndPoints:(NSArray<AMapNaviPoint *> *)endPoints;

/**
 * @brief 带起点的步行路径规划
 * @param startPoints  起点坐标.支持多个起点,起点列表的尾点为实际导航起点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @param endPoints    终点坐标.支持多个终点,终点列表的尾点为实际导航终点,其他坐标点为辅助信息,带有方向性,可有效避免算路到马路的另一侧.
 * @return 规划路径是否成功
 */
- (BOOL)calculateWalkRouteWithStartPoints:(NSArray<AMapNaviPoint *> *)startPoints
                                endPoints:(NSArray<AMapNaviPoint *> *)endPoints;

/**
 * @brief 导航过程中重新规划路径(起点为当前位置,终点位置不变)
 * @return 规划路径是否成功
 */
- (BOOL)recalculateWalkRoute;

#pragma mark - Manual

/**
 * @brief 设置TTS语音播报每播报一个字需要的时间.根据播报一个字的时间和运行的速度,可以更改语音播报的触发时机.
 * @param time 每个字的播放时间(范围:[250,500]; 单位:毫秒)
 */
- (void)setTimeForOneWord:(int)time;

#pragma mark - Statistics Information

/**
 * @brief 获取导航统计信息
 * @return 导航统计信息,参考 AMapNaviStatisticsInfo 类.
 */
- (nullable AMapNaviStatisticsInfo *)getNaviStatisticsInfo;

@end

#pragma mark - AMapNaviWalkManagerDelegate

@protocol AMapNaviWalkManagerDelegate <NSObject>
@optional

/**
 * @brief 发生错误时,会调用代理的此方法
 * @param walkManager 步行导航管理类
 * @param error 错误信息
 */
- (void)walkManager:(AMapNaviWalkManager *)walkManager error:(NSError *)error;

/**
 * @brief 步行路径规划成功后的回调函数
 * @param walkManager 步行导航管理类
 */
- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager;

/**
 * @brief 步行路径规划失败后的回调函数
 * @param walkManager 步行导航管理类
 * @param error 错误信息,error.code参照AMapNaviCalcRouteState
 */
- (void)walkManager:(AMapNaviWalkManager *)walkManager onCalculateRouteFailure:(NSError *)error;

/**
 * @brief 启动导航后回调函数
 * @param walkManager 步行导航管理类
 * @param naviMode 导航类型，参考AMapNaviMode
 */
- (void)walkManager:(AMapNaviWalkManager *)walkManager didStartNavi:(AMapNaviMode)naviMode;

/**
 * @brief 出现偏航需要重新计算路径时的回调函数.偏航后将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理.
 * @param walkManager 步行导航管理类
 */
- (void)walkManagerNeedRecalculateRouteForYaw:(AMapNaviWalkManager *)walkManager;

/**
 * @brief 导航播报信息回调函数
 * @param walkManager 步行导航管理类
 * @param soundString 播报文字
 * @param soundStringType 播报类型,参考AMapNaviSoundType
 */
- (void)walkManager:(AMapNaviWalkManager *)walkManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType;

/**
 * @brief 模拟导航到达目的地停止导航后的回调函数
 * @param walkManager 步行导航管理类
 */
- (void)walkManagerDidEndEmulatorNavi:(AMapNaviWalkManager *)walkManager;

/**
 * @brief 导航到达目的地后的回调函数
 * @param walkManager 步行导航管理类
 */
- (void)walkManagerOnArrivedDestination:(AMapNaviWalkManager *)walkManager;

@end

NS_ASSUME_NONNULL_END
