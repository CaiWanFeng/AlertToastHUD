//
//  CQPointHUD.h
//  AlertToastHUD
//
//  Created by 蔡强 on 2017/6/7.
//  Copyright © 2017年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQHUD : UIView

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
