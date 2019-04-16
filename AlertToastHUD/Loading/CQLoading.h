//
//  CQLoading.h
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQLoading : UIView

+ (void)show;
+ (void)showWithInfo:(NSString *)info;
+ (void)showOnView:(UIView *)view;
+ (void)showOnView:(UIView *)view info:(NSString *)info;

+ (void)remove;
+ (void)removeFromView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
