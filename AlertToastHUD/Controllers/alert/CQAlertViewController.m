//
//  CQAlertViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQAlertViewController.h"
#import "CQDeclareAlertView.h"
#import "CQToast.h"

typedef NS_ENUM(NSUInteger, CQContentsAlertType) {
    CQContentsAlertTypeDeclare
};

@interface CQAlertViewController () <CQDeclareAlertViewDelegate>

@end

@implementation CQAlertViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 数据源
    NSArray *dictArray = @[@{@"title" : @"申报异常弹窗", @"type" : @(CQContentsAlertTypeDeclare)}];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        CQContentsModel *model = [[CQContentsModel alloc] initWithDictionary:dict error:nil];
        [modelArray addObject:model];
    }
    self.dataArray = modelArray.copy;
    
    // cell点击时回调
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

@end
