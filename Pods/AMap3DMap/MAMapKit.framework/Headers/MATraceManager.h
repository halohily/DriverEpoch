//
//  MATraceManager.h
//  MAMapKit
//
//  Created by shaobin on 16/9/1.
//  Copyright © 2016年 Amap. All rights reserved.
//



#import "MAConfig.h"

#if MA_INCLUDE_TRACE_CORRECT

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MATraceLocation.h"

///处理中回调， index: 批次编号，0 based
typedef void(^MAProcessingCallback)(int index, NSArray<MATracePoint *> *points);

///成功回调，distance：距离，单位米
typedef void(^MAFinishCallback)(NSArray<MATracePoint *> *points, double distance);

///失败回调
typedef void(^MAFailedCallback)(int errorCode, NSString *errorDesc);

///轨迹纠偏管理类
@interface MATraceManager : NSObject

/**
 * @brief 获取纠偏后的经纬度点集
 * @param locations 待纠偏处理的点集, 顺序即为传入的顺序
 * @param type loctions经纬度坐标的类型, 如果已经是高德坐标系，传 -1
 * @param processingCallback  如果一次传入点过多，内部会分批处理。每处理完一批就调用此回调
 * @param finishCallback 全部处理完毕调用此回调
 * @param failedCallback 失败调用此回调
 * @return 返回一个NSOperation对象，可调用cancel取消
 */
- (NSOperation *)queryProcessedTraceWith:(NSArray<MATraceLocation *>*)locations
                                    type:(AMapCoordinateType)type
                      processingCallback:(MAProcessingCallback)processingCallback
                          finishCallback:(MAFinishCallback)finishCallback
                          failedCallback:(MAFailedCallback)failedCallback;

@end

#endif
