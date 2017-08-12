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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(0, 20, 80, 44);
    [backButton setTitle:@"返 回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/** 返回上一页按钮点击 */
- (void)backButtonClicked:(UIButton *)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
