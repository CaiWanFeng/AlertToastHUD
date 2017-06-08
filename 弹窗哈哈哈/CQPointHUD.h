//
//  CQPointHUD.h
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/6/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQPointHUD : UIView

/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message;

/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName;

/** 带block回调的弹窗 */
+ (void)showAlertWithButtonClickBlock:(void(^)())buttonClickedBlock;

@end
