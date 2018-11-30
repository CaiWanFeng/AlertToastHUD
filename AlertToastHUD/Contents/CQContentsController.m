//
//  CQContentsController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQContentsController.h"
#import "CQDeclareAlertView.h"
#import "CQHUD.h"
#import <Masonry.h>
#import "UIView+frameAdjust.h"
#import <JSONModel.h>
#import "CQContentsModel.h"
#import "CQToast.h"

@interface CQContentsController () <UITableViewDelegate, UITableViewDataSource, CQDeclareAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray<CQContentsModel *> *dataArray;

@end

@implementation CQContentsController

#pragma mark - Lazy Load

- (NSMutableArray<CQContentsModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *dictArray = @[@{@"title" : @"申报异常弹窗", @"type" : @(CQContentsTypeDeclareAlertView)},
                               @{@"title" : @"纯文本toast", @"type" : @(CQContentsTypeTextToast)},
                               @{@"title" : @"图文toast", @"type" : @(CQContentsTypeImageToast)},
                               @{@"title" : @"带block回调的弹窗", @"type" : @(CQContentsTypeBlockAlertView)},
                               @{@"title" : @"带网络图片与block回调的弹窗", @"type" : @(CQContentsTypeImageAlertView)},
                               @{@"title" : @"炫彩AlertView", @"type" : @(CQContentsTypeColorfulAlertView)},
                               @{@"title" : @"允许用户交互的loading，3秒后移除", @"type" : @(CQContentsTypeLoading)},
                               @{@"title" : @"禁止用户交互的loading，3秒后移除", @"type" : @(CQContentsTypeForbidUserEnableLoading)}];
        for (NSDictionary *dict in dictArray) {
            CQContentsModel *model = [[CQContentsModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Contents";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - UITableView DataSource & Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row].title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.dataArray[indexPath.row].type) {
        case CQContentsTypeDeclareAlertView:
        {
            // 申报异常弹窗
            [self showAlert];
        }
            break;
            
        case CQContentsTypeTextToast:
        {
            // 纯文本toast
            [self showToast];
        }
            break;
            
        case CQContentsTypeImageToast:
        {
            // 图文toast
            [self showImageToast];
        }
            break;
            
        case CQContentsTypeBlockAlertView:
        {
            // 带block回调的弹窗
            [self showBlockAlert];
        }
            break;
            
        case CQContentsTypeImageAlertView:
        {
            // 带网络图片与block回调的弹窗
            [self showImageAlert];
        }
            break;
            
        case CQContentsTypeColorfulAlertView:
        {
            // 炫彩alertView
            [self showColorfulAlertView];
        }
            break;
            
        case CQContentsTypeLoading:
        {
            // 展示允许用户交互的loading图
            [self showLoading];
        }
            break;
            
        case CQContentsTypeForbidUserEnableLoading:
        {
            // 展示禁止用户交互的loading图
            [self showForbidUserEnableLoading];
        }
            break;
    }
}

#pragma mark - 申报异常弹窗

// 申报异常弹窗
- (void)showAlert {
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

#pragma mark - 纯文本toast

// 纯文本toast
- (void)showToast {
    [CQToast showWithMessage:@"您还未达到相应积分\n无法兑换商品"];
}

#pragma mark - 图文toast

// 图文toast
- (void)showImageToast {
    [CQToast showWithMessage:@"兑换成功" image:@"sign"];
}

#pragma mark - 带block回调的弹窗

// 带block回调的弹窗
- (void)showBlockAlert {
    [CQHUD showAlertWithButtonClickedBlock:^{
        [CQToast showWithMessage:@"兑换按钮点击"];
    }];
}

#pragma mark - 带网络图片与block回调的弹窗

/** 带网络图片与block回调的弹窗 */
- (void)showImageAlert {
    [CQHUD showAlertWithImageURL:@"https://avatars0.githubusercontent.com/u/13911054?s=460&v=4" ButtonClickedBlock:^{
        [CQToast showWithMessage:@"前去兑换按钮点击"];
    }];
}

#pragma mark - 炫彩UIAlertView

/** 展示炫彩UIAlertView */
- (void)showColorfulAlertView {
    [CQHUD showConversionSucceedAlertWithCouponName:@"达利园小面包" validityTime:@"2017-09-01" checkCouponButtonClickedBlock:^{
        [CQToast showWithMessage:@"查看优惠券按钮点击"];
    }];
}

#pragma mark - 展示允许用户交互的loading图

/** 展示允许用户交互的loading图 */
- (void)showLoading {
    [CQHUD showLoadingWithEnableUserInteraction:YES];
    // 3秒后移除loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CQHUD dismiss];
        [CQToast showWithMessage:@"支付成功！"];
    });
}

#pragma mark - 展示禁止用户交互的loading

/** 展示禁止用户交互的loading */
- (void)showForbidUserEnableLoading {
    [CQHUD showLoadingWithMessage:@"支付中。。。" enableUserInteraction:NO];
    // 3秒后移除loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CQHUD dismiss];
        [CQToast showWithMessage:@"支付成功！"];
    });
}

@end
