//
//  UICollectionView+CQPlaceholderView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/4/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "UICollectionView+CQPlaceholderView.h"
#import <objc/runtime.h>

static char *cq_placeholderViewTypeKey = "cq_placeholderViewTypeKey";
static char *cq_isAutoShowPlaceholderViewKey = "cq_isAutoShowPlaceholderViewKey";
static char *cq_viewTapedBlockKey = "cq_viewTapedBlockKey";

@interface UICollectionView ()

/** 占位图类型 */
@property (nonatomic, assign) CQPlaceholderViewType cq_placeholderViewType;
/** 是否自动显示占位图 */
@property (nonatomic, assign) BOOL cq_isAutoShowPlaceholderView;
/** 占位图点击回调 */
@property (nonatomic, copy) dispatch_block_t cq_viewTapedBlock;

@end

@implementation UICollectionView (CQPlaceholderView)

#pragma mark - 关联属性

- (CQPlaceholderViewType)cq_placeholderViewType {
    return [objc_getAssociatedObject(self, cq_placeholderViewTypeKey) integerValue];
}

- (void)setCq_placeholderViewType:(CQPlaceholderViewType)cq_placeholderViewType {
    objc_setAssociatedObject(self, cq_placeholderViewTypeKey, [NSNumber numberWithInteger:cq_placeholderViewType], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)cq_isAutoShowPlaceholderView {
    return [objc_getAssociatedObject(self, cq_isAutoShowPlaceholderViewKey) boolValue];
}

- (void)setCq_isAutoShowPlaceholderView:(BOOL)cq_isAutoShowPlaceholderView {
    objc_setAssociatedObject(self, cq_isAutoShowPlaceholderViewKey, [NSNumber numberWithBool:cq_isAutoShowPlaceholderView], OBJC_ASSOCIATION_ASSIGN);
}

- (dispatch_block_t)cq_viewTapedBlock {
    return objc_getAssociatedObject(self, cq_viewTapedBlockKey);
}

- (void)setCq_viewTapedBlock:(dispatch_block_t)cq_viewTapedBlock {
    objc_setAssociatedObject(self, cq_viewTapedBlockKey, cq_viewTapedBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL APPLE_SEL = @selector(reloadData);
        SEL CQ_SEL = @selector(cq_reloadData);
        
        Method APPLE_METHOD = class_getInstanceMethod(self.class, APPLE_SEL);
        Method CQ_METHOD = class_getInstanceMethod(self.class, CQ_SEL);
        
        BOOL addSuccess = class_addMethod(self.class, APPLE_SEL, method_getImplementation(CQ_METHOD), method_getTypeEncoding(CQ_METHOD));
        if (addSuccess) {
            class_replaceMethod(self.class, APPLE_SEL, method_getImplementation(APPLE_METHOD), method_getTypeEncoding(APPLE_METHOD));
        } else {
            method_exchangeImplementations(APPLE_METHOD, CQ_METHOD);
        }
    });
}

#pragma mark - show
/**
 tableView无数据时自动展示占位图
 
 @param type 占位图类型
 @param viewTapedBlock 点击占位图的回调
 */
- (void)cq_showPlaceholderViewWhenNoDataWithType:(CQPlaceholderViewType)type
                                  viewTapedBlock:(dispatch_block_t)viewTapedBlock {
    self.cq_placeholderViewType = type;
    self.cq_isAutoShowPlaceholderView = YES;
    self.cq_viewTapedBlock = viewTapedBlock;
}

#pragma mark - 重新实现reloadData

- (void)cq_reloadData {
    [self cq_reloadData];
    
    // 不自动展示占位图
    if (!self.cq_isAutoShowPlaceholderView) {
        return;
    }
    
    id dataSource = self.dataSource;
    
    if (!dataSource) {
        return;
    }
    
    // 判断是否是空列表
    BOOL isEmptyList = NO;
    
    // 如果声明了numberOfSectionsInCollectionView，section为0时说明是空列列表
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        NSInteger section = [dataSource numberOfSectionsInCollectionView:self];
        if (section == 0) {
            // 组数为0，一定是空列表
            isEmptyList = YES;
        } else if (section == 1) {
            // 只有一组，看cell数量
            NSInteger cellCount = [dataSource collectionView:self numberOfItemsInSection:1];
            isEmptyList = (cellCount == 0);
        } else {
            // 大于1组，肯定不是空列表
            isEmptyList = NO;
        }
    } else {
        // 没有声明numberOfSectionsInCollectionView
        // 默认section为1
        // 那就看第一个sectoion的cell数量是否为0
        NSInteger cellCount = [dataSource collectionView:self numberOfItemsInSection:1];
        isEmptyList = (cellCount == 0);
    }
    
    if (isEmptyList) {
        // 展示占位图
        [CQPlaceholderView showOnView:self type:self.cq_placeholderViewType viewTapedBlock:^{
            !self.cq_viewTapedBlock ?: self.cq_viewTapedBlock();
        }];
    } else {
        // 移除占位图
        [CQPlaceholderView removeFromView:self];
    }
}

@end
