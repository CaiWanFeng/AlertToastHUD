//
//  CQPointHUD.m
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/6/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "CQPointHUD.h"
#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIColor+Util.h"
#import <UIImageView+WebCache.h>

@implementation CQPointHUD

/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message{
    // 背景view
    UIView *bgView = [[UIView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    bgView.layer.cornerRadius = 5;
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.top.left.mas_equalTo(label).mas_offset(-20);
        make.bottom.right.mas_equalTo(label).mas_offset(20);
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(140);
        make.center.mas_equalTo(label.superview);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName{
    // 背景view
    UIView *bgView = [[UIView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    bgView.layer.cornerRadius = 5;
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:22];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(label.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

+ (void)showAlertWithButtonClickedBlock:(void (^)())buttonClickedBlock{
    // 大背景
    UIView *bgView = [[UIView alloc]init];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_bg"]];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(-60);
        make.size.mas_equalTo(CGSizeMake(285, 185));
    }];
    
    // 签到label
    UILabel *signLabel = [[UILabel alloc]init];
    [bgImageView addSubview:signLabel];
    signLabel.text = @"今日签到获得+10积分";
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UIFont systemFontOfSize:15];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.centerX.mas_equalTo(bgImageView).mas_offset(-9);
        make.top.mas_equalTo(92);
    }];
    
    // 签到成功图片
    UIImageView *signImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_success"]];
    [bgImageView addSubview:signImageView];
    [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(signLabel);
        make.left.mas_equalTo(signLabel.mas_right).mas_offset(3);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    // 持有积分
    UILabel *scoreLabel = [[UILabel alloc]init];
    [bgImageView addSubview:scoreLabel];
    scoreLabel.textColor = [UIColor colorWithHexString:@"e83421"];
    scoreLabel.text = @"小主~您的积分已达到500";
    scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
    scoreLabel.font = [UIFont systemFontOfSize:15];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-35);
        make.height.mas_equalTo(16);
        make.left.right.mas_equalTo(bgImageView);
    }];
    
    // 兑换按钮
    UIButton *conversionButton = [[UIButton alloc]init];
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
    [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        buttonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(bgImageView.mas_bottom).mas_offset(8);
        make.size.mas_equalTo(CGSizeMake(84, 29));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc]init];
    [bgView addSubview:cancelButton];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgImageView);
        make.bottom.mas_equalTo(bgImageView.mas_top).mas_offset(-22);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 添加单击取消手势
    UITapGestureRecognizer *cancelGesture = [[UITapGestureRecognizer alloc] init];
    [[cancelGesture rac_gestureSignal] subscribeNext:^(id x) {
        [bgView removeFromSuperview];
    }];
    [bgView addGestureRecognizer:cancelGesture];
}

/** 带网络图片与block回调的弹窗 */
+ (void)showAlertWithImageURL:(NSString *)imageURL ButtonClickedBlock:(void (^)())buttonClickedBlock{
    // 先获取网络图片
    UIImageView *goodsImageView = [[UIImageView alloc]init];
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 获取图片成功后再搭建UI
        
        // 大背景
        UIView *bgView = [[UIView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:bgView];
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        // 网络图片
        [bgView addSubview:goodsImageView];
        [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.centerY.mas_equalTo(bgView).mas_offset(-60);
            make.size.mas_equalTo(CGSizeMake(225, 205));
        }];
        
        // 签到label
        UILabel *signLabel = [[UILabel alloc]init];
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
        UIImageView *signImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_success"]];
        [bgView addSubview:signImageView];
        [signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(signLabel);
            make.left.mas_equalTo(signLabel.mas_right).mas_offset(3);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        // 持有积分
        UILabel *scoreLabel = [[UILabel alloc]init];
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
        UIButton *conversionButton = [[UIButton alloc]init];
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
        [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            buttonClickedBlock();
            [bgView removeFromSuperview];
        }];
        [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.top.mas_equalTo(scoreLabel.mas_bottom).mas_offset(9);
            make.size.mas_equalTo(CGSizeMake(84, 29));
        }];
        
        // 取消按钮
        UIButton *cancelButton = [[UIButton alloc]init];
        [bgView addSubview:cancelButton];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"sign_out"] forState:UIControlStateNormal];
        [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [bgView removeFromSuperview];
        }];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(goodsImageView);
            make.bottom.mas_equalTo(goodsImageView.mas_top).mas_offset(-22);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        // 添加单击取消手势
        UITapGestureRecognizer *cancelGesture = [[UITapGestureRecognizer alloc] init];
        [[cancelGesture rac_gestureSignal] subscribeNext:^(id x) {
            [bgView removeFromSuperview];
        }];
        [bgView addGestureRecognizer:cancelGesture];
    }];
}

@end
