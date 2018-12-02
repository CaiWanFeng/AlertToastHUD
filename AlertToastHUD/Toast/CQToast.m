//
//  CQToast.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQToast.h"
#import <Masonry.h>

// toast默认展示时间
NSTimeInterval CQToastDefaultDuration = 2;
// toast默认背景颜色
UIColor *CQToastDefaultBackgroundColor;

@interface CQToast ()

@property (nonatomic, strong) UILabel     *messageLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CQToast

#pragma mark - 构造方法

- (instancetype)init {
    if (self = [super init]) {
        // 创建subView
        self.messageLabel = [[UILabel alloc] init];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.messageLabel];
        [self addSubview:self.imageView];
        
        // 两种toast的一致属性
        self.backgroundColor = CQToastDefaultBackgroundColor ?: [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 5;
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - UI

/** 纯文本toast */
- (void)setupWithMessage:(NSString *)message {
    self.messageLabel.text = message;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置label的约束
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(140);
        make.center.mas_equalTo(self.messageLabel.superview);
    }];
    
    // 设置toast的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.superview);
        make.bottom.mas_offset(-100);
        make.top.left.mas_equalTo(self.messageLabel).mas_offset(-20);
        make.bottom.right.mas_equalTo(self.messageLabel).mas_offset(20);
    }];
}

/** 图文toast */
- (void)setupWithMessage:(NSString *)message image:(NSString *)imageName {
    // label
    self.messageLabel.text = message;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // imageView
    self.imageView.image = [UIImage imageNamed:imageName];
    
    // 设置toast的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    // 设置label的约束
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(self.messageLabel.superview);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
}

#pragma mark - toast提示

/** 纯文本toast提示 */
+ (void)showWithMessage:(NSString *)message {
    [CQToast showWithMessage:message image:nil duration:CQToastDefaultDuration];
}

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [CQToast showWithMessage:message image:nil duration:duration];
}

/** 图文toast提示 */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName {
    [CQToast showWithMessage:message image:imageName duration:CQToastDefaultDuration];
}

+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration {
    CQToast *toast = [[CQToast alloc] init];
    [[UIApplication sharedApplication].delegate.window addSubview:toast];
    if (imageName && ![imageName isEqualToString:@""]) {
        // 图文toast
        [toast setupWithMessage:message image:imageName];
    } else {
        // 纯文本toast
        [toast setupWithMessage:message];
    }
    // 指定时间移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast removeFromSuperview];
    });
}

#pragma mark - 设置默认属性

/** 设置默认展示时间 */
+ (void)setDefaultDuration:(NSTimeInterval)defaultDuration {
    CQToastDefaultDuration = defaultDuration;
}

/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)color {
    CQToastDefaultBackgroundColor = color;
}

@end
