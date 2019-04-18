//
//  CQLoading.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQLoading.h"
#import <Masonry.h>

#define CQLoadingDefaultView [UIApplication sharedApplication].delegate.window

@interface CQLoading ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation CQLoading

#pragma mark - show

+ (void)show {
    [CQLoading showOnView:CQLoadingDefaultView withInfo:@""];
}

+ (void)showWithInfo:(NSString *)info {
    [CQLoading showOnView:CQLoadingDefaultView withInfo:info];
}

+ (void)showOnView:(UIView *)superView {
    [CQLoading showOnView:superView withInfo:@""];
}

+ (void)showOnView:(UIView *)superView withInfo:(NSString *)info {
    // 先将view上的loading移除
    [CQLoading removeFromView:superView];
    
    CQLoading *loading = [[CQLoading alloc] initWithInfo:info];
    [superView addSubview:loading];
    [loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(superView);
    }];
}

#pragma mark - remove

+ (void)remove {
    [CQLoading removeFromView:CQLoadingDefaultView];
}

+ (void)removeFromView:(UIView *)superView {
    for (UIView *subView in superView.subviews) {
        if ([subView isMemberOfClass:[CQLoading class]]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - init

- (instancetype)initWithInfo:(NSString *)info {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];;
        
        //------- image view -------//
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            if ([info isEqualToString:@""]) {
                // 纯loading，放view正中
                make.centerY.mas_equalTo(self);
            } else {
                // 有文本的loading，将imageView调高点
                make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-20);
            }
        }];
        
        //------- info label -------//
        self.infoLabel = [[UILabel alloc] init];
        [self addSubview:self.infoLabel];
        self.infoLabel.text = info;
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(220);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
            make.centerX.mas_equalTo(self);
        }];
        
        //------- 旋转动画 -------//
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 1;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        [self.imageView.layer addAnimation:animation forKey:nil];
    }
    return self;
}

@end
