//
//  CQToastViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQToastViewController.h"
#import "CQToast.h"

typedef NS_ENUM(NSUInteger, CQContentsToastStyle) {
    CQContentsToastStyleText,
    CQContentsToastStyleImageText,
    CQContentsToastStyleZan
};

@interface CQToastViewController ()

@end

@implementation CQToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 数据源
    NSArray *dictArray = @[@{@"title" : @"纯文本toast", @"type" : @(CQContentsToastStyleText)},
                           @{@"title" : @"图文toast", @"type" : @(CQContentsToastStyleImageText)},
                           @{@"title" : @"赞👍", @"type" : @(CQContentsToastStyleZan)}];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        CQContentsModel *model = [[CQContentsModel alloc] initWithDictionary:dict error:nil];
        [modelArray addObject:model];
    }
    self.dataArray = modelArray.copy;
    
    // cell点击时回调
    self.cellSelectedBlock = ^(NSInteger index) {
        switch (index) {
            case CQContentsToastStyleText:
            {
                // 纯文本toast
                [CQToast showWithMessage:@"您还未达到相应积分\n无法兑换商品"];
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
        }
    };
}

@end
