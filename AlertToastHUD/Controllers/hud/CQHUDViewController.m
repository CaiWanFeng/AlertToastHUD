//
//  CQHUDViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQHUDViewController.h"
#import "CQHUD.h"

typedef NS_ENUM(NSUInteger, CQContentsHudStyle) {
    CQContentsHudStyleLoadingOnly,
    CQContentsHudStyleLoadingWithMessage,
    CQContentsHudStyleLoadingUserEnabled,
};

@interface CQHUDViewController ()

@end

@implementation CQHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 数据源
    NSArray *dictArray = @[@{@"title" : @"纯loading", @"type" : @(CQContentsHudStyleLoadingOnly)},
                           @{@"title" : @"loading+文字", @"type" : @(CQContentsHudStyleLoadingWithMessage)},
                           @{@"title" : @"允许用户交互", @"type" : @(CQContentsHudStyleLoadingUserEnabled)}];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        CQContentsModel *model = [[CQContentsModel alloc] initWithDictionary:dict error:nil];
        [modelArray addObject:model];
    }
    self.dataArray = modelArray.copy;
    
    // cell点击时回调
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
                
            case CQContentsHudStyleLoadingUserEnabled:
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
