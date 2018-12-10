//
//  CQImageBlockAlertView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQImageBlockAlertView : UIView

/**
 带网络图片与block回调的弹窗
 
 @param imageURL 图片URL
 @param buttonClickedBlock 兑换按钮点击时的回调
 */
+ (void)alertWithImageURL:(NSString *)imageURL buttonClickedBlock:(void (^)(void))buttonClickedBlock;

@end
