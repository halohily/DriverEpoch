//
//  EditInfoController.h
//  DriverEpoch
//
//  Created by 刘毅 on 2017/5/21.
//  Copyright © 2017年 http://halohily.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserViewDelegate <NSObject>

- (void)reloadTableWithNickName:(NSString *)nickname andCar:(NSString *)car;

@end

@interface EditInfoController : UIViewController
@property (nonatomic, weak) id<UserViewDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *vcData;
@end
