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

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

/** 占位图类型 */
@property (nonatomic, assign) CQPlaceholderViewType type;
/** 占位图点击回调 */
@property (nonatomic, copy) dispatch_block_t viewTapedBlock;

@end

@implementation CQPlaceholderView

#pragma mark - show

+ (instancetype)showOnView:(UIView *)superView
                      type:(CQPlaceholderViewType)type
            viewTapedBlock:(nullable dispatch_block_t)viewTapedBlock {
    // 先移除现有的占位图
    [CQPlaceholderView removeFromView:superView];
    // 再添加
    CQPlaceholderView *placeholderView = [[CQPlaceholderView alloc] initWithViewTapedBlock:viewTapedBlock];
    [superView addSubview:placeholderView];
    placeholderView.type = type;
    [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(superView);
    }];
    return placeholderView;
}

#pragma mark - remove

+ (void)removeFromView:(UIView *)superView {
    for (UIView *subView in superView.subviews) {
        if ([subView isMemberOfClass:[CQPlaceholderView class]]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - other

- (instancetype)initWithViewTapedBlock:(dispatch_block_t)viewTapedBlock {
    if (self = [super init]) {
        self.viewTapedBlock = viewTapedBlock;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.centerY.mas_offset(-50);
        }];

        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textColor = [UIColor lightGrayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 0;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(18);
        }];
        
        // 添加单击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)viewTaped {
    !self.viewTapedBlock ?: self.viewTapedBlock();
}

- (void)setType:(CQPlaceholderViewType)type {
    _type = type;
    
    switch (_type) {
        case CQPlaceholderViewTypeNetwork: // 无网络
        {
            self.imageView.image = [UIImage imageNamed:@"none_network"];
            self.label.text = @"网络开小差了";
        }
            break;
            
        case CQPlaceholderViewTypeGoods:   // 无商品
        {
            self.imageView.image = [UIImage imageNamed:@"none_goods"];
            self.label.text = @"没有商品";
        }
            break;
            
        case CQPlaceholderViewTypeMessage: // 无消息
        {
            self.imageView.image = [UIImage imageNamed:@"none_message"];
            self.label.text = @"没有消息";
        }
            break;
            
        case CQPlaceholderViewTypeOrder:   // 无订单
        {
            self.imageView.image = [UIImage imageNamed:@"none_order"];
            self.label.text = @"没有订单";
        }
            break;
    }
}

@end
