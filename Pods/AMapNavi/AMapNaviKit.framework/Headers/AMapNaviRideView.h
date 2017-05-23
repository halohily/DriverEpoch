//
//  AMapNaviRideView.h
//  AMapNaviKit
//
//  Created by AutoNavi on 9/19/16.
//  Copyright © 2016 Amap. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "AMapNaviCommonObj.h"
#import "AMapNaviRideDataRepresentable.h"

NS_ASSUME_NONNULL_BEGIN

///骑行导航界面显示模式
typedef NS_ENUM(NSInteger, AMapNaviRideViewShowMode)
{
    AMapNaviRideViewShowModeCarPositionLocked = 1,  ///< 锁车状态
    AMapNaviRideViewShowModeOverview = 2,           ///< 全览状态
    AMapNaviRideViewShowModeNormal = 3,             ///< 普通状态
};

@protocol AMapNaviRideViewDelegate;

///骑行导航界面.该类实现AMapNaviRideDataRepresentable协议,可通过 AMapNaviRideManager 的addDataRepresentative:方法进行注册展示骑行导航过程.
@interface AMapNaviRideView : UIView<AMapNaviRideDataRepresentable>

#pragma mark - Delegate

///实现了 AMapNaviRideViewDelegate 协议的类指针
@property (nonatomic, weak) id<AMapNaviRideViewDelegate> delegate;

#pragma mark - Options

///是否采用横屏布局,默认NO
@property (nonatomic, assign) BOOL isLandscape;

///导航界面跟随模式,默认AMapNaviViewTrackingModeMapNorth
@property (nonatomic, assign) AMapNaviViewTrackingMode trackingMode;

///导航界面显示模式,默认AMapNaviDriveViewShowModeCarPositionLocked
@property (nonatomic, assign) AMapNaviRideViewShowMode showMode;

///是否显示界面元素,默认YES
@property (nonatomic, assign) BOOL showUIElements;

///是否黑夜模式,默认NO
@property (nonatomic, assign) BOOL showStandardNightType;

///是否显示全览按钮,默认YES
@property (nonatomic, assign) BOOL showBrowseRouteButton;

///是否显示更多按钮,默认YES
@property (nonatomic, assign) BOOL showMoreButton;

///是否显示转向箭头,默认YES
@property (nonatomic, assign) BOOL showTurnArrow;

#pragma mark - MapView

///是否显示指南针,默认NO
@property (nonatomic, assign) BOOL showCompass;

///锁车状态下地图cameraDegree, 默认30.0, 范围[0,60]
@property (nonatomic, assign) CGFloat cameraDegree;

///当前地图是否显示比例尺，默认NO
@property (nonatomic, assign) BOOL showScale;

///当前地图比例尺的原点位置，默认(10,10)
@property (nonatomic, assign) CGPoint scaleOrigin;

#pragma mark - Polyline Texture

///路线polyline的宽度,设置0恢复默认宽度
@property (nonatomic, assign) CGFloat lineWidth;

///标准路线Polyline的纹理图片,设置nil恢复默认纹理.纹理图片需满足：长宽相等，且宽度值为2的次幂
@property (nonatomic, copy, nullable) UIImage *normalTexture;

#pragma mark - Image

/**
 * @brief 设置路径起点图标
 * @param startPointImage 起点图标,设置nil为默认图标
 */
- (void)setStartPointImage:(nullable UIImage *)startPointImage;

/**
 * @brief 设置路径终点图标
 * @param endPointImage 终点图标,设置nil为默认图标
 */
- (void)setEndPointImage:(nullable UIImage *)endPointImage;

/**
 * @brief 设置自车图标
 * @param carImage 自车图标,设置nil为默认图标
 */
- (void)setCarImage:(nullable UIImage *)carImage;

/**
 * @brief 设置自车罗盘图标
 * @param carCompassImage 自车罗盘图标,设置nil为默认图标
 */
- (void)setCarCompassImage:(nullable UIImage *)carCompassImage;

@end

@protocol AMapNaviRideViewDelegate <NSObject>
@optional

/**
 * @brief 导航界面关闭按钮点击时的回调函数
 * @param rideView 骑行导航界面
 */
- (void)rideViewCloseButtonClicked:(AMapNaviRideView *)rideView;

/**
 * @brief 导航界面更多按钮点击时的回调函数
 * @param rideView 骑行导航界面
 */
- (void)rideViewMoreButtonClicked:(AMapNaviRideView *)rideView;

/**
 * @brief 导航界面转向指示View点击时的回调函数
 * @param rideView 骑行导航界面
 */
- (void)rideViewTrunIndicatorViewTapped:(AMapNaviRideView *)rideView;

/**
 * @brief 导航界面显示模式改变后的回调函数
 * @param rideView 骑行导航界面
 * @param showMode 显示模式
 */
- (void)rideView:(AMapNaviRideView *)rideView didChangeShowMode:(AMapNaviRideViewShowMode)showMode;

@end

NS_ASSUME_NONNULL_END
