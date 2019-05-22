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
#import "CQTableViewAutoShowController.h"
#import "CQCollectionViewAutoShowController.h"
#import "CQTestController.h"

@interface CQPlaceholderViewController ()

@end

@implementation CQPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"展示在self.view上", @"type" : @(0)},
                       @{@"title" : @"展示在self.tableView上", @"type" : @(1)},
                       @{@"title" : @"重新设置占位图约束", @"type" : @(2)},
                       @{@"title" : @"tableView自动展示占位图", @"type" : @(3)},
                       @{@"title" : @"collectionView自动展示占位图", @"type" : @(4)},
                       @{@"title" : @"test", @"type" : @(5)}].mutableCopy;
    
    //------- cell点击回调 -------//
    __weak typeof(self) weakSelf = self;
    self.cellSelectedBlock = ^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        switch (index) {
            case 0: // 展示在self.view上
            {
                [CQPlaceholderView showOnView:strongSelf.view type:CQPlaceholderViewTypeNetwork viewTapedBlock:^{
                    [CQToast showWithMessage:@"单击移除"];
                    [CQPlaceholderView removeFromView:strongSelf.view];
                }];
            }
                break;
                
            case 1: // 展示在self.tableView上
            {
                [CQPlaceholderView showOnView:strongSelf.tableView type:CQPlaceholderViewTypeGoods viewTapedBlock:^{
                    [CQToast showWithMessage:@"单击移除"];
                    [CQPlaceholderView removeFromView:strongSelf.tableView];
                }];
            }
                break;
                
            case 2: // 重新设置占位图约束
            {
                CQPlaceholderView *placeholderView = [CQPlaceholderView showOnView:strongSelf.view type:CQPlaceholderViewTypeMessage viewTapedBlock:^{
                    [CQPlaceholderView removeFromView:strongSelf.view];
                }];
                
                placeholderView.backgroundColor = [UIColor orangeColor];
                // 重新设置约束
                [placeholderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.mas_offset(0);
                    make.bottom.mas_offset(-100);
                }];
            }
                break;
                
            case 3: // tableView自动展示占位图
            {
                CQTableViewAutoShowController *vc = [[CQTableViewAutoShowController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 4: // collectionView自动展示占位图
            {
                CQCollectionViewAutoShowController *vc = [[CQCollectionViewAutoShowController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [strongSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 5: // collectionView自动展示占位图
            {
                CQTestController *testVC = [[CQTestController alloc] init];
                testVC.hidesBottomBarWhenPushed = YES;
                [strongSelf.navigationController pushViewController:testVC animated:YES];
            }
                break;
        }
    };
}

@end
