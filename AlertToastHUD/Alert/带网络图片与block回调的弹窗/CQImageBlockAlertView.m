//
//  CQImageBlockAlertView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQImageBlockAlertView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "UIColor+Util.h"
#import "UIButton+CQBlockSupport.h"

@implementation CQImageBlockAlertView

/**
 带网络图片与block回调的弹窗
 
 @param imageURL 图片URL
 @param buttonClickedBlock 兑换按钮点击时的回调
 */
+ (void)alertWithImageURL:(NSString *)imageURL buttonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 先获取网络图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 获取图片成功后再搭建UI
        
        // 大背景
        UIView *bgView = [[UIView alloc] init];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        // 网络图片
        [bgView addSubview:goodsImageView];
        [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.centerY.mas_offset(-30);
            make.size.mas_equalTo(CGSizeMake(225, 205));
        }];
        
        // 签到label
        UILabel *signLabel = [[UILabel alloc] init];
        [bgView addSubview:signLabel];
        signLabel.text = @"今日签到获得+10积分";
        signLabel.textAlignment = NSTextAlignmentCenter;
        signLabel.font = [UIFont systemFontOfSize:15];
        signLabel.textColor = [UIColor whiteColor];
        [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(bgView).mas_offset(-9);
            make.top.mas_equalTo(goodsImageView.mas_bottom).mas_offset(8);
        }];
        
        // 签到成功图片
        UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_success"]];
        [bgView addSubview:signImageView];
        [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(signLabel);
            make.left.mas_equalTo(signLabel.mas_right).mas_offset(3);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        // 持有积分
        UILabel *scoreLabel = [[UILabel alloc] init];
        [bgView addSubview:scoreLabel];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.text = @"小主~您的积分已达到500";
        scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
        scoreLabel.font = [UIFont systemFontOfSize:15];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(signLabel.mas_bottom).mas_offset(7);
            make.height.mas_equalTo(16);
            make.left.right.mas_equalTo(goodsImageView);
        }];
        
        // 兑换按钮
        UIButton *conversionButton = [[UIButton alloc] init];
        [bgView addSubview:conversionButton];
        conversionButton.backgroundColor = [UIColor colorWithHexString:@"e83421"];
        [conversionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [conversionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [conversionButton setTitle:@"前去兑换" forState:UIControlStateNormal];
        conversionButton.layer.cornerRadius = 6;
        conversionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 12);
        [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateNormal];
        [conversionButton setImage:[UIImage imageNamed:@"sign_exchange"] forState:UIControlStateHighlighted];
        conversionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 71, 0, 0);
        // 兑换按钮点击
        [conversionButton cq_addAction:^(UIButton *button) {
            buttonClickedBlock(); // 回调block
            [bgView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.top.mas_equalTo(scoreLabel.mas_bottom).mas_offset(9);
            make.size.mas_equalTo(CGSizeMake(84, 29));
        }];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc] init];
        [bgView addSubview:cancelButton];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
        // 取消按钮点击
        [cancelButton cq_addAction:^(UIButton *button) {
            [bgView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(goodsImageView);
            make.bottom.mas_equalTo(goodsImageView.mas_top).mas_offset(-22);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }];
}

@end
