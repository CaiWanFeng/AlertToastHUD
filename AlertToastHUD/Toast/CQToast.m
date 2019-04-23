//
//  CQToast.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQToast.h"
#import <Masonry.h>

NSNotificationName const CQToastWillShowNotification    = @"CQToastWillShowNotification";
NSNotificationName const CQToastDidShowNotification     = @"CQToastDidShowNotification";
NSNotificationName const CQToastWillDismissNotification = @"CQToastWillDismissNotification";
NSNotificationName const CQToastDidDismissNotification  = @"CQToastDidDismissNotification";

/**
 toast的style
 
 - CQToastStyleText: 纯文本toast
 - CQToastStyleImageText: 图文toast
 - CQToastStyleZan: 赞👍
 */
typedef NS_ENUM(NSUInteger, CQToastStyle) {
    CQToastStyleText,
    CQToastStyleImageText,
    CQToastStyleZan
};

// toast初始背景颜色
static UIColor *CQToastInitialBackgroundColor;
// toast初始文本颜色
static UIColor *CQToastInitialTextColor;
// toast初始展示时间
static NSTimeInterval CQToastInitialDuration;
// toast初始消失时间
static NSTimeInterval CQToastInitialFadeDuration;

// toast默认背景颜色
static UIColor *CQToastDefaultBackgroundColor;
// toast默认文本颜色
static UIColor *CQToastDefaultTextColor;
// toast默认展示时间
static NSTimeInterval CQToastDefaultDuration;
// toast默认消失时间
static NSTimeInterval CQToastDefaultFadeDuration;

@interface CQToast ()

@property (nonatomic, strong) UILabel      *messageLabel;
@property (nonatomic, strong) UIImageView  *imageView;

@end

@implementation CQToast

#pragma mark - Initial

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //========== 设置初始值 ==========//
        CQToastInitialBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        CQToastInitialTextColor       = [UIColor whiteColor];
        CQToastInitialDuration     = 2;
        CQToastInitialFadeDuration = 0.3;
        
        //========== 设置初始默认值 ==========//
        CQToastDefaultBackgroundColor = CQToastInitialBackgroundColor;
        CQToastDefaultTextColor       = CQToastInitialTextColor;
        CQToastDefaultDuration        = CQToastInitialDuration;
        CQToastDefaultFadeDuration    = CQToastInitialFadeDuration;
    });
}

// 初始化方法里可以对各种toast的一致属性进行统一设置
- (instancetype)init {
    if (self = [super init]) {
        // 创建subView
        self.messageLabel = [[UILabel alloc] init];
        self.imageView    = [[UIImageView alloc] init];
        [self addSubview:self.messageLabel];
        [self addSubview:self.imageView];
        
        // toast的一致属性
        self.layer.cornerRadius = 5;
        self.backgroundColor = CQToastDefaultBackgroundColor ?: CQToastInitialBackgroundColor;
        self.messageLabel.textColor = CQToastDefaultTextColor ?: CQToastInitialTextColor;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - UI

/** 纯文本toast */
- (void)p_setupTextToastWithMessage:(NSString *)message {
    self.messageLabel.text = message;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置toast的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.superview);
        make.bottom.mas_offset(-100);
        make.top.left.mas_equalTo(self.messageLabel).mas_offset(-20);
        make.bottom.right.mas_equalTo(self.messageLabel).mas_offset(20);
    }];
    
    // 设置label的约束
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(140);
        make.center.mas_equalTo(self.messageLabel.superview);
    }];
}

/** 图文toast */
- (void)p_setupImageTextToastWithMessage:(NSString *)message image:(NSString *)imageName {
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

/** 赞 */
- (void)p_setupZanToast {
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"zan"];
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2-20, 40, 40);
    self.imageView.frame = self.bounds;
    // 简单动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5, @1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

/** 根据传入的style创建不同的toast */
- (void)p_setupWithMessage:(NSString *)message image:(NSString *)imageName style:(CQToastStyle)style {
    switch (style) {
        case CQToastStyleText:
        {
            // 纯文本toast
            [self p_setupTextToastWithMessage:message];
        }
            break;
            
        case CQToastStyleImageText:
        {
            // 图文toast
            [self p_setupImageTextToastWithMessage:message image:imageName];
        }
            break;
        case CQToastStyleZan:
        {
            // 赞👍
            [self p_setupZanToast];
        }
    }
}

#pragma mark - show toast

/** 纯文本toast */
+ (void)showWithMessage:(NSString *)message {
    [CQToast p_showWithMessage:message image:nil duration:CQToastDefaultDuration style:CQToastStyleText];
}

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [CQToast p_showWithMessage:message image:nil duration:duration style:CQToastStyleText];
}

/** 图文toast */
+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName {
    [CQToast p_showWithMessage:message image:imageName duration:CQToastDefaultDuration style:CQToastStyleImageText];
}

+ (void)showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration {
    [CQToast p_showWithMessage:message image:imageName duration:duration style:CQToastStyleImageText];
}

/** 赞 */
+ (void)showZan {
    [CQToast p_showWithMessage:nil image:nil duration:CQToastDefaultDuration style:CQToastStyleZan];
}

+ (void)showZanWithDuration:(NSTimeInterval)duration {
    [CQToast p_showWithMessage:nil image:nil duration:duration style:CQToastStyleZan];
}

/** 全能show方法 */
+ (void)p_showWithMessage:(NSString *)message image:(NSString *)imageName duration:(NSTimeInterval)duration style:(CQToastStyle)style {
    // 切换到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        // 将要展示
        [[NSNotificationCenter defaultCenter] postNotificationName:CQToastWillShowNotification object:nil];
        CQToast *toast = [[CQToast alloc] init];
        [[UIApplication sharedApplication].windows.lastObject addSubview:toast];
        [toast p_setupWithMessage:message image:imageName style:style];
        // 已经展示
        [[NSNotificationCenter defaultCenter] postNotificationName:CQToastDidShowNotification object:nil];
        // 指定时间移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 将要消失
            [[NSNotificationCenter defaultCenter] postNotificationName:CQToastWillDismissNotification object:nil];
            [UIView animateWithDuration:CQToastDefaultFadeDuration animations:^{
                toast.alpha = 0;
            } completion:^(BOOL finished) {
                [toast removeFromSuperview];
                // 已经消失
                [[NSNotificationCenter defaultCenter] postNotificationName:CQToastDidDismissNotification object:nil];
            }];
        });
    });
}

#pragma mark - 设置默认值

/** 设置toast的默认背景颜色 */
+ (void)setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor {
    CQToastDefaultBackgroundColor = defaultBackgroundColor;
}

/** 设置默认字体颜色 */
+ (void)setDefaultTextColor:(UIColor *)defaultTextColor {
    CQToastDefaultTextColor = defaultTextColor;
}

/** 设置toast展示的默认时间，未设置为2秒 */
+ (void)setDefaultDuration:(NSTimeInterval)defaultDuration {
    CQToastDefaultDuration = defaultDuration;
}

/** 设置toast消失的默认时间，未设置为0.3秒 */
+ (void)setDefaultFadeDuration:(NSTimeInterval)defaultFadeDuration {
    CQToastDefaultFadeDuration = defaultFadeDuration;
}

#pragma mark - 重置为初始状态

/** 重置为初始状态（这个方法适用于某次改变默认值后又想改回去的情况） */
+ (void)reset {
    CQToastDefaultBackgroundColor = CQToastInitialBackgroundColor;
    CQToastDefaultTextColor       = CQToastInitialTextColor;
    CQToastDefaultDuration        = CQToastInitialDuration;
    CQToastDefaultFadeDuration    = CQToastInitialFadeDuration;
}

@end
