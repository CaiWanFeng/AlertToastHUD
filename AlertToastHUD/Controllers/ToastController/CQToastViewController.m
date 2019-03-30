//
//  CQToastViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQToastViewController.h"
#import "CQToast.h"

typedef NS_ENUM(NSUInteger, CQContentsToastStyle) {
    CQContentsToastStyleText,
    CQContentsToastStyleImageText,
    CQContentsToastStyleZan,
    CQContentsToastStyleChildThread,
    CQContentsToastStyleSpecifyDuration,
    CQContentsToastStyleChangeBackgroundColor,
    CQContentsToastStyleChangeTextColor,
    CQContentsToastStyleChangeDuration,
    CQContentsToastStyleChangeFadeDuration,
    CQContentsToastStyleReset
};

@interface CQToastViewController ()

@end

@implementation CQToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //------- 数据源 -------//
    self.dataArray = @[@{@"title" : @"纯文本toast", @"type" : @(CQContentsToastStyleText)},
                           @{@"title" : @"图文toast", @"type" : @(CQContentsToastStyleImageText)},
                           @{@"title" : @"赞👍", @"type" : @(CQContentsToastStyleZan)},
                           @{@"title" : @"子线程调用", @"type" : @(CQContentsToastStyleChildThread)},
                           @{@"title" : @"指定此toast展示时间为3秒", @"type" : @(CQContentsToastStyleSpecifyDuration)},
                           @{@"title" : @"修改toast默认背景颜色", @"type" : @(CQContentsToastStyleChangeBackgroundColor)},
                           @{@"title" : @"修改toast默认字体颜色", @"type" : @(CQContentsToastStyleChangeTextColor)},
                           @{@"title" : @"修改toast默认展示时间", @"type" : @(CQContentsToastStyleChangeDuration)},
                           @{@"title" : @"修改toast默认消失时间", @"type" : @(CQContentsToastStyleChangeFadeDuration)},
                           @{@"title" : @"重置为初始状态", @"type" : @(CQContentsToastStyleReset)}].mutableCopy;
    
    //------- cell点击回调 -------//
    self.cellSelectedBlock = ^(NSInteger index) {
        switch (index) {
            case CQContentsToastStyleText:
            {
                // 纯文本toast
                [CQToast showWithMessage:@"这是纯文本toast\n没有图片"];
            }
                break;
                
            case CQContentsToastStyleImageText:
            {
                // 图文toast
                [CQToast showWithMessage:@"兑换成功" image:@"sign"];
            }
                break;
                
            case CQContentsToastStyleZan:
            {
                // 赞
                [CQToast showZan];
            }
                break;
                
            case CQContentsToastStyleChildThread:
            {
                // 子线程调用
                [CQToast showWithMessage:@"这个toast是子线程调用的"];
            }
                break;
                
            case CQContentsToastStyleSpecifyDuration:
            {
                // 指定toast展示的时间
                [CQToast showWithMessage:@"这个toast会展示3秒" duration:3];
            }
                break;
                
            case CQContentsToastStyleChangeBackgroundColor:
            {
                // 修改toast默认背景颜色，改为灰色
                [CQToast setDefaultBackgroundColor:[UIColor grayColor]];
                [CQToast showWithMessage:@"默认背景颜色已修改为灰色"];
            }
                break;
                
            case CQContentsToastStyleChangeTextColor:
            {
                // 修改toast默认字体颜色，改为蓝色
                [CQToast setDefaultTextColor:[UIColor blueColor]];
                [CQToast showWithMessage:@"默认字体颜色已修改为蓝色"];
            }
                break;
                
            case CQContentsToastStyleChangeDuration:
            {
                // 改变toast展示的默认时间，改为1秒
                [CQToast setDefaultDuration:1];
                [CQToast showWithMessage:@"默认展示时间已修改为1秒"];
            }
                break;
                
            case CQContentsToastStyleChangeFadeDuration:
            {
                // 改变toast消失的默认时间，改为1.5秒
                [CQToast setDefaultFadeDuration:1.5];
                [CQToast showWithMessage:@"默认消失时间已修改为1.5秒"];
            }
                break;
                
            case CQContentsToastStyleReset:
            {
                // 重置为初始状态
                [CQToast reset];
                [CQToast showWithMessage:@"已重置"];
            }
                break;
        }
    };
}

@end
