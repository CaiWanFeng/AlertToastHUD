//
//  CQAlertViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQAlertViewController.h"
#import "CQDeclareAlertView.h"
#import "CQToast.h"
#import "CQBlockAlertView.h"
#import "CQImageBlockAlertView.h"
#import "CQColorfulAlertView.h"
#import "CQPointsRuleView.h"
#import "IChuAlertView.h"

typedef NS_ENUM(NSUInteger, CQContentsAlertType) {
    CQContentsAlertTypeDeclare,
    CQContentsAlertTypeBlock,
    CQContentsAlertTypeImageBlock,
    CQContentsAlertTypeColorfulAlertView,
    CQContentsAlertTypeRuleView,
    CQContentsAlertTypeIChu
};

@interface CQAlertViewController () <CQDeclareAlertViewDelegate>

@end

@implementation CQAlertViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"申报异常弹窗", @"type" : @(CQContentsAlertTypeDeclare)},
                           @{@"title" : @"带block回调的弹窗", @"type" : @(CQContentsAlertTypeBlock)},
                           @{@"title" : @"带网络图片和block回调的弹窗", @"type" : @(CQContentsAlertTypeImageBlock)},
                           @{@"title" : @"炫彩UIAlertView", @"type" : @(CQContentsAlertTypeColorfulAlertView)},
                           @{@"title" : @"积分规则说明弹窗", @"type" : @(CQContentsAlertTypeRuleView)},
                           @{@"title" : @"iChu app 整套弹窗", @"type" : @(CQContentsAlertTypeIChu)}].mutableCopy;
    
    //------- cell点击回调 -------//
    __weak typeof(self) weakSelf = self;
    self.cellSelectedBlock = ^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        switch (index) {
            case CQContentsAlertTypeDeclare:
            {
                // 申报异常弹窗
                [strongSelf showDeclareAlertView];
            }
                break;
                
            case CQContentsAlertTypeBlock:
            {
                // 带block的弹窗
                [strongSelf showBlockAlertView];
            }
                break;
                
            case CQContentsAlertTypeImageBlock:
            {
                // 带网络图片和block的弹窗
                [strongSelf showImageBlockAlertView];
            }
                break;
                
            case CQContentsAlertTypeColorfulAlertView:
            {
                // 炫彩UIAlertView
                [strongSelf showColorfulAlertView];
            }
                break;
                
            case CQContentsAlertTypeRuleView:
            {
                // 积分规则弹窗
                [strongSelf showRuleView];
            }
                break;
                
            case CQContentsAlertTypeIChu:
            {
                // iChu app 整套弹窗
                [strongSelf showIChuAlertView];
            }
                break;
        }
    };
}

#pragma mark - 申报异常弹窗

- (void)showDeclareAlertView {
    CQDeclareAlertView *alertView = [[CQDeclareAlertView alloc]initWithTitle:@"这是一个标题" message:@"长亭外，古道边，一行白鹭上青天" delegate:self leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    alertView.orderID = @"12345";
    [alertView show];
}

// 申报异常弹窗的button点击时回调
- (void)CQDeclareAlertView:(CQDeclareAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [CQToast showWithMessage:[NSString stringWithFormat:@"申报异常成功，订单id：%@", alertView.orderID]];
    } else {
        [CQToast showWithMessage:@"点击了右边的button"];
    }
}

#pragma mark - 带block的弹窗

- (void)showBlockAlertView {
    [CQBlockAlertView alertWithButtonClickedBlock:^{
        [CQToast showWithMessage:@"兑换按钮点击"];
    }];
}

#pragma mark - 带网络图片和block的弹窗

- (void)showImageBlockAlertView {
    [CQImageBlockAlertView alertWithImageURL:@"https://avatars0.githubusercontent.com/u/13911054?s=460&v=4" buttonClickedBlock:^{
        [CQToast showWithMessage:@"去兑换按钮点击"];
    }];
}

#pragma mark - 炫彩UIAlertView

- (void)showColorfulAlertView {
    [CQColorfulAlertView showConversionSucceedAlertWithCouponName:@"兑换成功" validityTime:@"2018-11-11" checkCouponButtonClickedBlock:^{
        [CQToast showWithMessage:@"兑换成功"];
    }];
}

#pragma mark - 积分规则说明弹窗

- (void)showRuleView {
    [CQPointsRuleView showWithImageURL:@"https://upload-images.jianshu.io/upload_images/1692043-fac3309a5bfa76db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/780"];
}

#pragma mark - iChu app 整套弹窗

- (void)showIChuAlertView {
    [IChuAlertView showWithTitle:@"标题" content:@"内容" buttonTitles:@[@"知道了"] buttonClickedBlock:nil];
}

@end
