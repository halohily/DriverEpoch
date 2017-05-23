//
//  AMapNaviTrafficBarView.h
//  AMapNaviKit
//
//  Created by AutoNavi on 14-7-11.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "AMapNaviCommonObj.h"

NS_ASSUME_NONNULL_BEGIN

///路况光柱View
@interface AMapNaviTrafficBarView : UIView

///是否显示车图标,默认YES
@property (nonatomic, assign) BOOL showCar;

///交通状态的颜色数组 \n 例如:{(AMapNaviRouteStatusSlow): [UIColor yellowColor],(AMapNaviRouteStatusSeriousJam): [UIColor colorWithRed:160/255.0 green:8/255.0 blue:8/255.0 alpha:1.0]}，设置空字典恢复默认颜色,例如:{}
@property (nonatomic, copy) NSDictionary<NSNumber *, UIColor *> *statusColors;

/**
 * @brief 更新路况光柱
 * @param trafficStatuses 路况信息数组,可以通过 AMapNaviDriveManager 的getTrafficStatuses方法获取.
 */
- (void)updateTrafficBarWithTrafficStatuses:(nullable NSArray<AMapNaviTrafficStatus *> *)trafficStatuses;

/**
 * @brief 更新车图标的位置
 *
 * 位置百分比可以计算获得: posPercent = 1.0 - (double)AMapNaviInfo.routeRemainDistance / AMapNaviRoute.routeLength;
 *
 * @param posPercent 位置百分比(范围:[0,1.0])
 */
- (void)updateTrafficBarWithCarPositionPercent:(double)posPercent;

@end

NS_ASSUME_NONNULL_END
