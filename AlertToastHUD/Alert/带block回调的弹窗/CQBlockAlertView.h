//
//  CQBlockAlertView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQBlockAlertView : UIView

/** 带block回调的弹窗 */
+ (void)alertWithButtonClickedBlock:(void (^)(void))buttonClickedBlock;

@end
