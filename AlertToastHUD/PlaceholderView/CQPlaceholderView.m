//
//  CQPlaceholderView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQPlaceholderView.h"
#import <Masonry.h>

@interface CQPlaceholderView ()

/** 按钮点击回调 */
@property (nonatomic, copy) void (^buttonClickedBlock)(void);

@end

@implementation CQPlaceholderView

+ (void)showOnView:(UIView *)view type:(NSInteger)type buttonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 先移除现有的
    [CQPlaceholderView removeFromView:view];
    // 再添加
    CQPlaceholderView *placeholderView = [[CQPlaceholderView alloc] initWithType:type buttonClickedBlock:buttonClickedBlock];
    [view addSubview:placeholderView];
    [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(placeholderView.superview);
    }];
}

+ (void)removeFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isMemberOfClass:[CQPlaceholderView class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (instancetype)initWithType:(NSInteger)type buttonClickedBlock:(void (^)(void))buttonClickedBlock {
    if (self = [super init]) {
        self.buttonClickedBlock = buttonClickedBlock;
        
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        
    }
    return self;
}

- (void)buttonClicked {
    !self.buttonClickedBlock ?: self.buttonClickedBlock();
}

@end
