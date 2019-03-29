//
//  CQLoading.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQLoading.h"
#import <Masonry.h>

@interface CQLoading ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation CQLoading

+ (void)showOnView:(UIView *)view {
    [CQLoading showOnView:view info:@""];
}

+ (void)showOnView:(UIView *)view info:(NSString *)info {
    // 先将view上的loading移除
    [CQLoading removeFromView:view];
    
    // 后台返回null，不展示文本（后台不返回null到底有多难？）
    if ([info isKindOfClass:[NSNull class]]) {
        [CQLoading showOnView:view];
        return;
    }
    
    // 正常流程
    CQLoading *loading = [[CQLoading alloc] initWithInfo:info];
    [view addSubview:loading];
    [loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
}

+ (void)removeFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isMemberOfClass:[CQLoading class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (instancetype)initWithInfo:(NSString *)info {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];;
        
        //------- 旋转菊花 -------//
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [self addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        self.activityIndicator.color = [UIColor grayColor];
        self.activityIndicator.hidesWhenStopped = NO;
        [self.activityIndicator startAnimating];
        
        
        //------- info label -------//
        self.infoLabel = [[UILabel alloc] init];
        [self addSubview:self.infoLabel];
        self.infoLabel.text = info;
        self.infoLabel.font = [UIFont systemFontOfSize:14];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(120);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(20);
            make.centerX.mas_equalTo(self);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
    }
    return self;
}

@end
