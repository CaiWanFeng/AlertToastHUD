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

/** 图文toast提示 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName;

@end
