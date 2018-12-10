//
//  CQColorfulAlertView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQColorfulAlertView.h"
#import <Masonry.h>
#import "UIButton+CQBlockSupport.h"

@implementation CQColorfulAlertView

/**
 兑换成功后展示的弹窗
 
 @param couponName 优惠券名称
 @param validityTime 有效期
 @param checkButtonClickedBlock “查看优惠券”按钮点击后的回调
 */
+ (void)showConversionSucceedAlertWithCouponName:(NSString *)couponName validityTime:(NSString *)validityTime checkCouponButtonClickedBlock:(void (^)(void))checkButtonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 白色view
    UIView *whiteView = [[UIView alloc] init];
    [bgView addSubview:whiteView];
    whiteView.clipsToBounds = YES;
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(255);
        make.center.mas_equalTo(bgView);
    }];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [whiteView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"兑换成功";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(17);
    }];
    
    // 优惠券label
    UILabel *couponLabel = [[UILabel alloc] init];
    [whiteView addSubview:couponLabel];
    couponLabel.text = couponName;
    couponLabel.textAlignment = NSTextAlignmentCenter;
    couponLabel.font = [UIFont systemFontOfSize:14];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(whiteView);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(13);
        make.height.mas_equalTo(14);
    }];
    
    // 有效期label
    UILabel *timeLabel = [[UILabel alloc] init];
    [whiteView addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor colorWithRed:0.84 green:0.33 blue:0.44 alpha:1.00];
    timeLabel.text = validityTime;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(couponLabel);
        make.top.mas_equalTo(couponLabel.mas_bottom).mas_offset(10);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [whiteView addSubview:cancelButton];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    // 取消按钮点击
    [cancelButton cq_addAction:^(UIButton *button) {
        // 点击取消按钮移除弹窗
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(whiteView);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(whiteView.mas_centerX);
        make.height.mas_equalTo(43);
    }];
    
    // 查看优惠券按钮
    UIButton *checkButton = [[UIButton alloc] init];
    [whiteView addSubview:checkButton];
    [checkButton setTitle:@"查看优惠券" forState:UIControlStateNormal];
    [checkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [checkButton setTitleColor:[UIColor colorWithRed:0.42 green:0.74 blue:0.67 alpha:1.00] forState:UIControlStateNormal];
    [checkButton cq_addAction:^(UIButton *button) {
        [bgView removeFromSuperview];
        checkButtonClickedBlock();
    } forControlEvents:UIControlEventTouchUpInside];
    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.mas_equalTo(cancelButton);
        make.left.mas_equalTo(cancelButton.mas_right);
        make.bottom.mas_equalTo(whiteView);
    }];
    
    // 横线灰色线
    UIView *grayLineView1 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView1];
    grayLineView1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [grayLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
    }];
    
    // 竖向灰色线
    UIView *grayLineView2 = [[UIView alloc] init];
    [whiteView addSubview:grayLineView2];
    grayLineView2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [grayLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayLineView1.mas_bottom);
        make.bottom.mas_equalTo(whiteView);
        make.centerX.mas_equalTo(whiteView);
        make.width.mas_equalTo(1);
    }];
    
    // 出场动画
    bgView.alpha = 0;
    whiteView.alpha = 0;
    whiteView.transform = CGAffineTransformScale(whiteView.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.2 animations:^{
        whiteView.transform = CGAffineTransformIdentity;
        bgView.alpha = 1;
        whiteView.alpha = 1;
    }];
}

@end
