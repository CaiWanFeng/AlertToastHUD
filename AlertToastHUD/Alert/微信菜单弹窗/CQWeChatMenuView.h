//
//  CQWeChatMenuView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/7.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQWeChatMenuView : UIView

+ (void)showWithItems:(NSArray *)items cellClickedBlock:(void (^)(NSInteger index))block;

@end
