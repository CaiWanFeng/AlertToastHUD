//
//  CQBaseViewController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/4.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "CQBaseViewController.h"
#import <Masonry.h>

@interface CQBaseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CQBaseViewController

@synthesize dataArray = _dataArray;

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

#pragma mark - getter & setter

-(NSArray<CQContentsModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)setDataArray:(NSArray<CQContentsModel *> *)dataArray {
    _dataArray = dataArray;
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
    }
    cell.textLabel.text = self.dataArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellSelectedBlock ?: self.cellSelectedBlock(indexPath.row);
}

@end
