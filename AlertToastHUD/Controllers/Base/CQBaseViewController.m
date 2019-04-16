//
//  CQBaseViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQBaseViewController.h"
#import <Masonry.h>

@interface CQBaseViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CQBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - setter

- (void)setDataArray:(NSMutableArray<CQContentsModel *> *)dataArray {
    _dataArray = [NSMutableArray array];
    
    for (NSDictionary *dict in dataArray) {
        CQContentsModel *model = [[CQContentsModel alloc] initWithDictionary:dict error:nil];
        [_dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    cell.textLabel.text = self.dataArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellSelectedBlock ?: self.cellSelectedBlock(indexPath.row);
}

@end
