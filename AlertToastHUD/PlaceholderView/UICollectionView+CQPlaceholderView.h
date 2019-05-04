//
//  UICollectionView+CQPlaceholderView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2019/4/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (CQPlaceholderView)

/**
 collectionView无数据时自动展示占位图
 
 @param type 占位图类型
 @param viewTapedBlock 点击占位图的回调
 */
- (void)cq_showPlaceholderViewWhenNoDataWithType:(CQPlaceholderViewType)type
                                  viewTapedBlock:(nullable dispatch_block_t)viewTapedBlock;

@end

NS_ASSUME_NONNULL_END
