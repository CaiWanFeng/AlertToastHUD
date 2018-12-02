//
//  CQToast.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQToast : UIView

/** 纯文本toast提示 */
+ (void)showWithMessage:(NSString *)message;
+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

/** 图文toast提示 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName;
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration;

/** 设置toast展示的默认时间 */
+ (void)setDefaultDuration:(NSTimeInterval)defaultDuration;
/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)color;

@end
