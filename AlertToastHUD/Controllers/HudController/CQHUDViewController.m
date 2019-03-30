//
//  CQHUDViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQHUDViewController.h"
#import "CQHUD.h"

typedef NS_ENUM(NSUInteger, CQContentsHudStyle) {
    CQContentsHudStyleLoadingOnly,
    CQContentsHudStyleLoadingWithMessage,
    CQContentsHudStyleLoadingWithUserEnabled,
    CQContentsHudStyleLoadingWithoutUserEnabled
};

@interface CQHUDViewController ()

@end

@implementation CQHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"纯loading，3秒自动移除", @"type" : @(CQContentsHudStyleLoadingOnly)},
                           @{@"title" : @"loading+文字，3秒自动移除", @"type" : @(CQContentsHudStyleLoadingWithMessage)},
                           @{@"title" : @"允许用户交互的loading，3秒自动移除", @"type" : @(CQContentsHudStyleLoadingWithUserEnabled)}].mutableCopy;
    
    //------- cell点击回调 -------//
    self.cellSelectedBlock = ^(NSInteger index) {
        switch (index) {
            case CQContentsHudStyleLoadingOnly:
            {
                [CQHUD showLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQHUD dismiss];
                });
            }
                break;
                
            case CQContentsHudStyleLoadingWithMessage:
            {
                [CQHUD showLoadingWithMessage:@"处理中。。。"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQHUD dismiss];
                });
            }
                break;
                
            case CQContentsHudStyleLoadingWithUserEnabled:
            {
                [CQHUD showLoadingWithMessage:@"允许交互的loading" enableUserInteraction:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQHUD dismiss];
                });
            }
                break;
        }
    };
}

@end
