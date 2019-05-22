//
//  CQCollectionViewAutoShowController.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/4/30.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQCollectionViewAutoShowController.h"
#import "UICollectionView+CQPlaceholderView.h"

static NSString * const kCellReuseID = @"kCellReuseID";

@interface CQCollectionViewAutoShowController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CQCollectionViewAutoShowController

#pragma mark - Lazy Load

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"自动展示占位图";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReuseID];
    [self.collectionView cq_showPlaceholderViewWhenNoDataWithType:CQPlaceholderViewTypeMessage viewTapedBlock:^{
        NSLog(@"占位图点击");
    }];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonClicked)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteButtonClicked)];
    
    self.navigationItem.rightBarButtonItems = @[addButton, deleteButton];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - 添加/删除

- (void)addButtonClicked {
    [self.dataArray addObject:[NSObject new]];
    [self.collectionView reloadData];
}

- (void)deleteButtonClicked {
    [self.dataArray removeLastObject];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

// 设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

// 设置每个组的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 10, 10, 10); // top, left, bottom, right;
}

// 设置每个item最小水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

// 设置每个item最小垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

@end
