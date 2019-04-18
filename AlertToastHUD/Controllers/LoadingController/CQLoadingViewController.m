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
    self.dataArray = @[@{@"title" : @"[CQLoading show]; 3秒移除", @"type" : @(0)},
                       @{@"title" : @"默认展示在delegate.window上", @"type" : @(1)},
                       @{@"title" : @"展示在指定的view上", @"type" : @(2)},
                       @{@"title" : @"展示在指定的view上，带文本", @"type" : @(3)}].mutableCopy;
    
    //------- cell点击回调 -------//
    __weak typeof(self) weakSelf = self;
    self.cellSelectedBlock = ^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        switch (index) {
            case 0:
            {
                [CQLoading show];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading remove];
                });
            }
                break;
                
            case 1:
            {
                [CQLoading showWithInfo:@"默认展示在delegate.window上"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading remove];
                });
            }
                break;
                
            case 2:
            {
                [CQLoading showOnView:strongSelf.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading removeFromView:strongSelf.view];
                });
            }
                break;
                
            case 3:
            {
                [CQLoading showOnView:strongSelf.view withInfo:@"loading..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQLoading removeFromView:strongSelf.view];
                });
            }
                break;
        }
    };
}

@end
