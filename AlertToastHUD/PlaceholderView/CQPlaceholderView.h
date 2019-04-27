//
//  CQPlaceholderView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 占位图类型

 - CQPlaceholderViewTypeNetwork: 无网络占位图
 - CQPlaceholderViewTypeGoods:   无商品占位图
 - CQPlaceholderViewTypeMessage: 无消息占位图
 - CQPlaceholderViewTypeOrder:   无订单占位图
 */
typedef NS_ENUM(NSUInteger, CQPlaceholderViewType) {
    CQPlaceholderViewTypeNetwork,
    CQPlaceholderViewTypeGoods,
    CQPlaceholderViewTypeMessage,
    CQPlaceholderViewTypeOrder
};

@interface CQPlaceholderView : UIView

/**
 展示占位图

 @param superView 在哪个view上展示
 @param type 占位图类型
 @param viewTapedBlock 占位图单击回调
 @return 占位图。默认覆盖在整个superView上，可以通过masonry的mas_remakeConstraints方法重新设置约束
 */
+ (instancetype)showOnView:(UIView *)superView
                      type:(CQPlaceholderViewType)type
            viewTapedBlock:(nullable dispatch_block_t)viewTapedBlock;

/** 移除占位图 */
+ (void)removeFromView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
