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
+ (void)showOnView:(UIView *)superView;
+ (void)showOnView:(UIView *)superView withInfo:(NSString *)info;

+ (void)remove;
+ (void)removeFromView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
