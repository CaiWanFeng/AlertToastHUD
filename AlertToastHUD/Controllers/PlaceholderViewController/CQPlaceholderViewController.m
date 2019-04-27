//
//  CQPlaceholderViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/3/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQPlaceholderViewController.h"
#import "CQPlaceholderView.h"
#import "CQToast.h"
#import <Masonry.h>

@interface CQPlaceholderViewController ()

@end

@implementation CQPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"展示在self.view上", @"type" : @(0)},
                       @{@"title" : @"展示在self.tableView上", @"type" : @(1)},
                       @{@"title" : @"重新设置占位图约束", @"type" : @(2)}].mutableCopy;
    
    //------- cell点击回调 -------//
    __weak typeof(self) weakSelf = self;
    self.cellSelectedBlock = ^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        switch (index) {
            case 0:
            {
                [CQPlaceholderView showOnView:strongSelf.view type:CQPlaceholderViewTypeNetwork viewTapedBlock:^{
                    [CQToast showWithMessage:@"单击移除"];
                    [CQPlaceholderView removeFromView:strongSelf.view];
                }];
            }
                break;
                
            case 1:
            {
                [CQPlaceholderView showOnView:strongSelf.tableView type:CQPlaceholderViewTypeGoods viewTapedBlock:^{
                    [CQToast showWithMessage:@"单击移除"];
                    [CQPlaceholderView removeFromView:strongSelf.tableView];
                }];
            }
                break;
                
            case 2:
            {
                CQPlaceholderView *placeholderView = [CQPlaceholderView showOnView:[UIApplication sharedApplication].delegate.window type:CQPlaceholderViewTypeMessage viewTapedBlock:^{
                    [CQPlaceholderView removeFromView:[UIApplication sharedApplication].delegate.window];
                }];
                
                placeholderView.backgroundColor = [UIColor orangeColor];
                // 重新设置约束
                [placeholderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(placeholderView.superview);
                    make.size.mas_equalTo(CGSizeMake(200, 200));
                }];
            }
                break;
                
            case 3:
            {
                
            }
                break;
        }
    };
}

@end
