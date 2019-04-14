//
//  CQPlaceholderView.h
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQPlaceholderView : UIView


/**
 如果这个view是UITableView或UICollectionView，有数据时自动移除
 可以通过

 @param view 展示在哪个view上
 @param type 占位图类型
 @param buttonClickedBlock 按钮点击回调
 */
+ (void)showOnView:(UIView *)view type:(NSInteger)type buttonClickedBlock:(void (^)(void))buttonClickedBlock;
+ (void)removeFromView:(UIView *)view;

/** 针对UITableView和UICollectionView，设置有数据时是否自动隐藏 */
@property (nonatomic, assign, getter=isAutoRemoveWhenHaveData) BOOL autoRemoveWhenHaveData;

@end

NS_ASSUME_NONNULL_END
