//
//  CQLoadingViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQLoadingViewController.h"
#import "CQLoading.h"

@interface CQLoadingViewController ()

@end

@implementation CQLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"展示在tableView上的loading,3s移除", @"type" : @(0)},
                           @{@"title" : @"展示在window上的loading,3s移除", @"type" : @(1)},
                           @{@"title" : @"展示在self.view上带文本的loading,3s移除", @"type" : @(2)}].mutableCopy;
    
    //------- cell点击回调 -------//
    __weak typeof(self) weakSelf = self;
    self.cellSelectedBlock = ^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        switch (index) {
            case 0:
            {
                // 展示在tableView上的loading
                [CQLoading showOnView:strongSelf.tableView];
                // 3秒移除
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading removeFromView:strongSelf.tableView];
                });
            }
                break;
                
            case 1:
            {
                // 展示在window上的loading
                [CQLoading showOnView:[UIApplication sharedApplication].delegate.window];
                // 3秒移除
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading removeFromView:[UIApplication sharedApplication].delegate.window];
                });
            }
                break;
                
            case 2:
            {
                // 展示在self.view上带文本的loading
                [CQLoading showOnView:strongSelf.view info:@"加载中。。。"];
                // 3秒移除
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading removeFromView:strongSelf.view];
                });
            }
                break;
        }
    };
}

@end
