//
//  CQToast.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQToast.h"
#import <Masonry.h>

/**
 toast类型
 
 - CQToastTypeText: 纯文本toast
 - CQToastTypeImageText: 图文toast
 */
typedef NS_ENUM(NSUInteger, CQToastType) {
    CQToastTypeText,
    CQToastTypeImageText
};

// toast默认展示时间
NSTimeInterval CQToastDefaultDuration = 2;
// toast默认消失时间
NSTimeInterval CQToastDefaultFadeDuration = 0.3;
// toast默认背景颜色
UIColor *CQToastDefaultBackgroundColor;
// toast默认文本颜色
UIColor *CQToastDefaultTextColor;

@interface CQToast ()

@property (nonatomic, assign) CQToastType type;
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
        self.layer.cornerRadius = 5;
        self.backgroundColor = CQToastDefaultBackgroundColor ?: [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.messageLabel.textColor = CQToastDefaultTextColor ?: [UIColor whiteColor];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - UI

- (void)setupWithToastType:(CQToastType)type message:(NSString *)message image:(NSString *)imageName {
    switch (type) {
        case CQToastTypeText:
        {
            // 纯文本toast
            [self setupWithMessage:message];
        }
            break;
            
        case CQToastTypeImageText:
        {
            // 图文toast
            [self setupWithMessage:message image:imageName];
        }
            break;
    }
}

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
        [toast setupWithToastType:CQToastTypeImageText message:message image:imageName];
    } else {
        // 纯文本toast
        [toast setupWithToastType:CQToastTypeText message:message image:nil];
    }
    // 指定时间移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:CQToastDefaultFadeDuration animations:^{
            toast.alpha = 0;
        } completion:^(BOOL finished) {
            [toast removeFromSuperview];
        }];
    });
}

#pragma mark - 设置默认值

/** 设置toast展示的默认时间，未设置为2秒 */
+ (void)setDefaultDuration:(NSTimeInterval)defaultDuration {
    CQToastDefaultDuration = defaultDuration;
}

/** 设置toast消失的默认时间，未设置为0.3秒 */
+ (void)setDefaultFadeDuration:(NSTimeInterval)defaultFadeDuration {
    CQToastDefaultFadeDuration = defaultFadeDuration;
}

/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)color {
    CQToastDefaultBackgroundColor = color;
}

/** 设置默认字体颜色 */
+ (void)setDefaultTextColor:(UIColor *)color {
    CQToastDefaultTextColor = color;
}

#pragma mark - 重置默认值

/** 重置默认值（这个方法适用于某次改变默认值后又想改回去的情况） */
+ (void)reset {
    CQToastDefaultDuration = 2;
    CQToastDefaultFadeDuration = 0.3;
    CQToastDefaultBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    CQToastDefaultTextColor = [UIColor whiteColor];
}

@end
