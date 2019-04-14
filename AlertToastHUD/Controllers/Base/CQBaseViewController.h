//
//  CQBaseViewController.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQContentsModel.h"

typedef void(^CellSelectedBlock)(NSInteger index);

@interface CQBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray <CQContentsModel *> *dataArray;
/** cell点击时回调 */
@property (nonatomic, copy) CellSelectedBlock cellSelectedBlock;

@end
