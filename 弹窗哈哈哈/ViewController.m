//
//  ViewController.m
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/4/7.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "DeclareAbnormalAlertView.h"
#import "CQPointHUD.h"
#import <Masonry.h>
#import "UIView+frameAdjust.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DeclareAbnormalAlertViewDelegate>

@end

@implementation ViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
}

#pragma mark - 带输入框的弹窗
// 带输入框的弹窗
- (void)showAlert{
    DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]initWithTitle:@"这是一个标题" message:@"长亭外，古道边，一行白鹭上青天" delegate:self leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    [alertView show];
}

#pragma mark - 纯文本toast
// 纯文本toast
- (void)showToast{
    [CQPointHUD showToastWithMessage:@"您还未达到相应积分\n无法兑换商品"];
}

#pragma mark - 图文toast
// 图文toast
- (void)showImageToast{
    [CQPointHUD showToastWithMessage:@"兑换成功" image:@"sign"];
}

#pragma mark - 带block回调的弹窗
// 带block回调的弹窗
- (void)showBlockAlert{
    [CQPointHUD showAlertWithButtonClickedBlock:^{
        [CQPointHUD showToastWithMessage:@"兑换按钮点击"];
    }];
}

#pragma mark - 带网络图片与block回调的弹窗
/** 带网络图片与block回调的弹窗 */
- (void)showImageAlert{
    [CQPointHUD showAlertWithImageURL:@"http://ohbxuuf5q.bkt.clouddn.com/%E6%B3%B0%E5%A6%8D.png" ButtonClickedBlock:^{
        [CQPointHUD showToastWithMessage:@"前去兑换按钮点击"];
    }];
}

#pragma mark - 炫彩UIAlertView
/** 展示炫彩UIAlertView */
- (void)showColorfulAlertView{
    [CQPointHUD showConversionSucceedAlertWithCouponName:@"达利园小面包" validityTime:@"2017-09-01" checkCouponButtonClickedBlock:^{
        [CQPointHUD showToastWithMessage:@"查看优惠券按钮点击"];
    }];
}

#pragma mark - Delegate - 带输入框的弹窗
// 输入框弹窗的button点击时回调
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == AlertButtonLeft) {
        [CQPointHUD showToastWithMessage:@"点击了左边的button"];
    }else{
        [CQPointHUD showToastWithMessage:@"点击了右边的button"];
    }
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
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
            cell.textLabel.text = @"炫彩UIAlertView";
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
            
        default:
            break;
    }
}

@end
