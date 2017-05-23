//
//  AMapNaviBaseManager.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/1/12.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import "AMapNaviCommonObj.h"

NS_ASSUME_NONNULL_BEGIN

@class CLLocation;
@class AMapNaviInfo;
@class AMapNaviRoute;
@class AMapNaviLocation;
@class AMapNaviStatisticsInfo;

///注意:该类为导航控制器基类,请不要直接使用
@interface AMapNaviBaseManager : NSObject

#pragma mark - Navi Mode

///当前导航模式,参考AMapNaviMode
@property (nonatomic, readonly) AMapNaviMode naviMode;

#pragma mark - Options

///是否在导航过程中让屏幕常亮,默认YES.
@property (nonatomic, assign) BOOL screenAlwaysBright;

///指定定位是否会被系统自动暂停。默认为YES。
@property(nonatomic, assign) BOOL pausesLocationUpdatesAutomatically;

///是否允许后台定位.默认为NO(只在iOS 9.0及以后版本起作用).注意:设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态,否则会抛出异常.
@property (nonatomic, assign) BOOL allowsBackgroundLocationUpdates;

#pragma mark - External Location

///是否采用外部传入定位信息.注意:默认NO.注意:设置为YES时,将会停止SDK内部的定位,对应的后台定位支持将会失效.
@property (nonatomic, assign) BOOL enableExternalLocation;

///外部传入定位信息(enableExternalLocation为YES时有效).该方法坐标需使用WGS84坐标系.
@property (nonatomic, copy) CLLocation *externalLocation;

/**
 * @brief 设置外部传入定位的信息
 * @param externalLocation 外部传入的定位信息
 * @param isAMapCoordinate 外部传入的坐标是否采用高德坐标,YES表示采用高德坐标(GCJ02),NO表示使用WGS84坐标.
 */
- (void)setExternalLocation:(CLLocation *)externalLocation isAMapCoordinate:(BOOL)isAMapCoordinate;

#pragma mark - Navi Guide

/**
 * @brief 获取导航路线的路线详情列表
 * @return 导航路线的路线详情列表,参考 AMapNaviGuide 类.
 */
- (nullable NSArray<AMapNaviGuide *> *)getNaviGuideList;

#pragma mark - GPS & Emulator Navi

/**
 * @brief 设置模拟导航的速度,默认60
 * @param speed 模拟导航的速度(范围:[10,120]; 单位:km/h)
 */
- (void)setEmulatorNaviSpeed:(int)speed;

/**
 * @brief 开始模拟导航
 * @return 是否成功
 */
- (BOOL)startEmulatorNavi;

/**
 * @brief 开始实时导航
 * @return 是否成功
 */
- (BOOL)startGPSNavi;

/**
 * @brief 停止导航,包含实时导航和模拟导航
 */
- (void)stopNavi;

/**
 * @brief 暂停导航,包含实时导航和模拟导航
 */
- (void)pauseNavi;

/**
 * @brief 继续导航,包含实时导航和模拟导航
 */
- (void)resumeNavi;

#pragma mark - Manual

/**
 * @brief 触发一次导航播报信息
 * @return 是否成功
 */
- (BOOL)readNaviInfoManual;

@end

NS_ASSUME_NONNULL_END
