//
//  SecondViewController.m
//  弹窗哈哈哈
//
//  Created by 蔡强 on 2017/8/12.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "SecondViewController.h"
#import "CQHUD.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"第二页";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 展示loading图
    [CQHUD showLoading];
    // 允许用户交互
    [CQHUD enableUserInteraction:YES];
    
    // 或者
    //[CQHUD showLoadingWithEnableUserInteraction:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 移除loading图
    [CQHUD dismiss];
}

@end
