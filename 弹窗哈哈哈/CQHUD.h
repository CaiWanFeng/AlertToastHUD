//
//  CQPointHUD.h
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/6/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQHUD : UIView

#pragma mark - 纯文本toast提示
/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message;


#pragma mark - 图文toast提示
/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName;


#pragma mark - 带block回调的弹窗
/** 带block回调的弹窗 */
+ (void)showAlertWithButtonClickedBlock:(void(^)())buttonClickedBlock;


#pragma mark - 带网络图片与block回调的弹窗
/** 带网络图片与block回调的弹窗 */
+ (void)showAlertWithImageURL:(NSString *)imageURL ButtonClickedBlock:(void(^)())buttonClickedBlock;


#pragma mark - 炫彩弹窗
/**
 兑换成功后展示的弹窗
 
 @param couponName 优惠券名称
 @param validityTime 有效期
 @param checkButtonClickedBlock “查看优惠券”按钮点击后的回调
 */
+ (void)showConversionSucceedAlertWithCouponName:(NSString *)couponName validityTime:(NSString *)validityTime checkCouponButtonClickedBlock:(void(^)())checkButtonClickedBlock;


#pragma mark - 展示loading图
/** 展示loading图 */
+ (void)showLoading;


#pragma mark - 展示带说明信息的loading图
/**
 带说明信息loading图
 
 @param message 说明信息
 */
+ (void)showLoadingWithMessage:(NSString *)message;


#pragma mark - 移除loading图
/** 移除loading图 */
+ (void)dismiss;


#pragma mark - loading期间，允许或禁止用户交互
/**
 loading期间，允许或禁止用户交互
 
 @param isEnable YES:允许 NO:禁止
 */
+ (void)enableUserInteraction:(BOOL)isEnable;


#pragma mark - 展示可控制用户交互的loading图
/**
 展示可控制用户交互的loading图
 
 @param isEnable 是否允许用户交互
 */
+ (void)showLoadingWithEnableUserInteraction:(BOOL)isEnable;


#pragma mark - 展示可控制用户交互并且带说明信息的loading图
/**
 展示可控制用户交互并且带说明信息的loading图
 
 @param message 说明信息
 @param isEnable 是否允许用户交互
 */
+ (void)showLoadingWithMessage:(NSString *)message enableUserInteraction:(BOOL)isEnable;


@end
