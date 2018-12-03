//
//  CQToast.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQToast : UIView

#pragma mark - 纯文本toast

/** 纯文本toast */
+ (void)showWithMessage:(NSString *)message;

/**
 纯文本toast

 @param message 提示内容
 @param duration toast展示时间
 */
+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

#pragma mark - 图文toast

/** 图文toast */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName;

/**
 图文toast

 @param message 提示内容
 @param imageName 图片名
 @param duration toast展示时间
 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration;

#pragma mark - 设置默认值

/** 设置toast展示的默认时间，未设置为2秒 */
+ (void)setDefaultDuration:(NSTimeInterval)defaultDuration;
/** 设置toast消失的默认时间，未设置为0.3秒 */
+ (void)setDefaultFadeDuration:(NSTimeInterval)defaultFadeDuration;
/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)color;
/** 设置默认字体颜色，未设置为白色 */
+ (void)setDefaultTextColor:(UIColor *)color;

#pragma mark - 重置默认值

/** 重置默认值（这个方法适用于某次改变默认值后又想改回去的情况） */
+ (void)reset;

@end
