//
//  ViewController.m
//  AlertToastHUD
//
//  Created by 蔡强 on 2017/4/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "DeclareAbnormalAlertView.h"
#import "CQHUD.h"
#import <Masonry.h>
#import "UIView+frameAdjust.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DeclareAbnormalAlertViewDelegate>

@end

@implementation ViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Contents";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - 带输入框的弹窗
// 带输入框的弹窗
- (void)showAlert {
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"这是一个标题" message:@"长亭外，古道边，一行白鹭上青天" delegate:self leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
}

#pragma mark - 纯文本toast
// 纯文本toast
- (void)showToast {
    [CQHUD showToastWithMessage:@"您还未达到相应积分\n无法兑换商品"];
}

#pragma mark - 图文toast
// 图文toast
- (void)showImageToast {
    [CQHUD showToastWithMessage:@"兑换成功" image:@"sign"];
}

#pragma mark - 带block回调的弹窗
// 带block回调的弹窗
- (void)showBlockAlert {
    [CQHUD showAlertWithButtonClickedBlock:^{
        [CQHUD showToastWithMessage:@"兑换按钮点击"];
    }];
}

#pragma mark - 带网络图片与block回调的弹窗
/** 带网络图片与block回调的弹窗 */
- (void)showImageAlert {
    [CQHUD showAlertWithImageURL:@"https://avatars0.githubusercontent.com/u/13911054?s=460&v=4" ButtonClickedBlock:^{
        [CQHUD showToastWithMessage:@"前去兑换按钮点击"];
    }];
}

#pragma mark - 炫彩UIAlertView
/** 展示炫彩UIAlertView */
- (void)showColorfulAlertView {
    [CQHUD showConversionSucceedAlertWithCouponName:@"达利园小面包" validityTime:@"2017-09-01" checkCouponButtonClickedBlock:^{
        [CQHUD showToastWithMessage:@"查看优惠券按钮点击"];
    }];
}

#pragma mark - 展示允许用户交互的loading图
/** 展示允许用户交互的loading图 */
- (void)showLoading {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - 展示禁止用户交互的loading
/** 展示禁止用户交互的loading */
- (void)showForbidUserEnableLoading {
    [CQHUD showLoadingWithMessage:@"支付中。。。" enableUserInteraction:NO];
    
    // 3秒后移除loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [CQHUD dismiss];
        [CQHUD showToastWithMessage:@"支付成功！"];
        
    });
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"带输入框的弹窗";
            break;
            
        case 1:
            cell.textLabel.text = @"纯文本toast";
            break;
            
        case 2:
            cell.textLabel.text = @"图文toast";
            break;
            
        case 3:
            cell.textLabel.text = @"带block回调的弹窗";
            break;
            
        case 4:
            cell.textLabel.text = @"带网络图片与block回调的弹窗";
            break;
            
        case 5:
            cell.textLabel.text = @"炫彩AlertView";
            break;
            
        case 6:
            cell.textLabel.text = @"loading图，允许用户交互";
            break;
            
        case 7:
            cell.textLabel.text = @"loading图，禁止用户交互，3秒后自动移除";
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: // 带输入框的弹窗
        {
            [self showAlert];
        }
            break;
            
        case 1: // 纯文本toast
        {
            [self showToast];
        }
            break;
            
        case 2: // 图文toast
        {
            [self showImageToast];
        }
            break;
            
        case 3: // 带block回调的弹窗
        {
            [self showBlockAlert];
        }
            break;
            
        case 4: // 带网络图片与block回调的弹窗
        {
            [self showImageAlert];
        }
            break;
            
        case 5: // 炫彩alertView
        {
            [self showColorfulAlertView];
        }
            break;
            
        case 6: // 展示允许用户交互的loading图
        {
            [self showLoading];
        }
            break;
            
        case 7: // 展示禁止用户交互的loading图
        {
            [self showForbidUserEnableLoading];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Delegate - 带输入框的弹窗
// 输入框弹窗的button点击时回调
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == AlertButtonLeft) {
        [CQHUD showToastWithMessage:@"点击了左边的button"];
    }else{
        [CQHUD showToastWithMessage:@"点击了右边的button"];
    }
}

@end
