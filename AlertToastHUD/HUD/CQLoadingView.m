//
//  CQLoadingView.m
//  AlertToastHUD
//
//  Created by 蔡强 on 2017/8/12.
//  Copyright © 2017年 Caiqiang. All rights reserved.
//

#import "CQLoadingView.h"
#import <Masonry.h>

@implementation CQLoadingView {
    /** loading信息label */
    UILabel *_loadingInfoLabel;
}

#pragma mark - loading图单例
/** loading图单例 */
+ (instancetype)sharedInstance {
    static CQLoadingView *loadingView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingView = [[CQLoadingView alloc] init];
    });
    return loadingView;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        //------- loading imageView -------//
        UIImageView *loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        [self addSubview:loadingImageView];
        loadingImageView.image = [UIImage imageNamed:@"loading_00000"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < 15; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"loading_%05d",i];
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }
        loadingImageView.animationImages = imageArray;
        loadingImageView.animationDuration = 0.5;
        loadingImageView.animationRepeatCount = 0;
        [loadingImageView startAnimating];
        [loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        //------- 说明文本 -------//
        _loadingInfoLabel = [[UILabel alloc] init];
        [self addSubview:_loadingInfoLabel];
        _loadingInfoLabel.textAlignment = NSTextAlignmentCenter;
        _loadingInfoLabel.font = [UIFont systemFontOfSize:14];
        _loadingInfoLabel.textColor = [UIColor redColor];
        [_loadingInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(loadingImageView);
            make.top.mas_equalTo(loadingImageView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(18);
        }];
    }
    return self;
}

#pragma mark - 赋值loading说明信息
/** 赋值loading说明信息 */
- (void)setLoadingInfo:(NSString *)loadingInfo{
    _loadingInfo = loadingInfo;
    _loadingInfoLabel.text = _loadingInfo;
}

@end
