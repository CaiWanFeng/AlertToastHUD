//
//  IChuAlertView.m
//  iChu
//
//  Created by caiqiang on 2019/3/29.
//  Copyright © 2019 Caiqiang. All rights reserved.
//

#import "IChuAlertView.h"
#import <Masonry.h>

// 主按钮字体颜色
#define MAIN_BUTTON_COLOR [UIColor orangeColor]
// 主按钮font
#define MAIN_BUTTON_FONT [UIFont boldSystemFontOfSize:18]
// 普通按钮字体颜色
#define NORMAL_BUTTON_COLOR [UIColor blackColor]
// 普通按钮font
#define NORMAL_BUTTON_FONT [UIFont systemFontOfSize:18]

// 灰色线的颜色
#define LINE_COLOR [UIColor lightGrayColor]

static NSInteger const kButtonBeginTag = 1000;

@interface IChuAlertView ()

/** 按钮数量 */
@property (nonatomic, assign) NSInteger buttonCount;
/** 内容view */
@property (nonatomic, strong) UIView *contentView;
/** 按钮点击回调 */
@property (nonatomic, copy) void (^buttonClickedBlock)(NSInteger index);

@end

@implementation IChuAlertView

#pragma mark - show

/**
 弹窗快捷调用方法
 
 @param title 标题
 @param content 内容
 @param buttonTitles 按钮title数组
 @param buttonClickedBlock 按钮点击回调
 @return 自定义弹窗实例
 */
+ (instancetype)showWithTitle:(nullable NSString *)title content:(NSString *)content buttonTitles:(NSArray *)buttonTitles buttonClickedBlock:(nullable void (^)(NSInteger index))buttonClickedBlock {
    IChuAlertView *alertView = [[IChuAlertView alloc] initWithTitle:title content:content buttonTitles:buttonTitles buttonClickedBlock:buttonClickedBlock];
    [[UIApplication sharedApplication].delegate.window addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(alertView.superview);
    }];
    
    // 入场动画
    alertView.alpha = 0;
    alertView.contentView.transform = CGAffineTransformScale(alertView.contentView.transform, 1.2, 1.2);
    [UIView animateWithDuration:0.2 animations:^{
        alertView.alpha = 1;
        alertView.contentView.transform = CGAffineTransformIdentity;
    }];
    
    return alertView;
}

#pragma mark - 设置主按钮

/** 设置第几个按钮是主按钮（主按钮为主题色粗体），默认最右边那个是主按钮 */
- (void)setMainButtonIndex:(NSInteger)mainButtonIndex {
    if (mainButtonIndex >= self.buttonCount) {
        return;
    }
    for (int i = 0; i < self.buttonCount; i++) {
        UIButton *button = [self viewWithTag:(i + kButtonBeginTag)];
        if (mainButtonIndex == i) {
            [button setTitleColor:MAIN_BUTTON_COLOR forState:UIControlStateNormal];
            [button.titleLabel setFont:MAIN_BUTTON_FONT];
        } else {
            [button setTitleColor:NORMAL_BUTTON_COLOR forState:UIControlStateNormal];
            [button.titleLabel setFont:NORMAL_BUTTON_FONT];
        }
    }
}

#pragma mark - other

/**
 自定义构造方法

 @param title 标题
 @param content 内容
 @param buttonTitles 按钮title数组
 @param buttonClickedBlock 按钮点击回调
 @return 自定义弹窗实例
 */
- (instancetype)initWithTitle:(nullable NSString *)title content:(NSString *)content buttonTitles:(NSArray *)buttonTitles buttonClickedBlock:(void (^)(NSInteger))buttonClickedBlock {
    if (self = [super init]) {
        self.buttonCount = buttonTitles.count;
        self.buttonClickedBlock = buttonClickedBlock;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        
        //========== 布局 ==========//
        
        //------- 内容view，使用自动布局，子view将内容view撑开 -------//
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 8;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.mas_equalTo(60);
            make.right.mas_offset(-60);
        }];
        
        //------- title -------//
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 0;
        titleLabel.text = title;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
        }];
        
        //------- content -------//
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:contentLabel];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.numberOfLines = 0;
        contentLabel.text = content;
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleLabel);
        }];
        if (!title || [title isEqualToString:@""]) {
            // 没有标题时
            contentLabel.font = [UIFont boldSystemFontOfSize:16];
            contentLabel.textColor = [UIColor blackColor];
            [contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(20);
            }];
        } else {
            contentLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.textColor = [UIColor grayColor];
            [contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
            }];
        }
        
        //------- 灰色横线 -------//
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = LINE_COLOR;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(20);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        //------- 循环创建按钮 -------//
        if (buttonTitles.count == 0) {
            NSAssert(nil, @"弹窗按钮数量不能为0");
        } else if (buttonTitles.count == 1) {
            UIButton *button = [[UIButton alloc] init];
            [self.contentView addSubview:button];
            button.tag = kButtonBeginTag;
            [button setTitle:buttonTitles.firstObject forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button.titleLabel setFont:MAIN_BUTTON_FONT];
            [button setTitleColor:MAIN_BUTTON_COLOR forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.height.mas_equalTo(50);
                make.bottom.mas_offset(0);
                make.left.right.mas_offset(0);
            }];
        } else {
            NSMutableArray *buttonArray = [NSMutableArray array];
            for (int i = 0; i < buttonTitles.count; i++) {
                UIButton *button = [[UIButton alloc] init];
                [self.contentView addSubview:button];
                button.tag = kButtonBeginTag + i;
                [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [buttonArray addObject:button];
                if (i == (buttonTitles.count - 1)) {
                    // 最右边的按钮
                    [button.titleLabel setFont:MAIN_BUTTON_FONT];
                    [button setTitleColor:MAIN_BUTTON_COLOR forState:UIControlStateNormal];
                } else {
                    [button.titleLabel setFont:NORMAL_BUTTON_FONT];
                    [button setTitleColor:NORMAL_BUTTON_COLOR forState:UIControlStateNormal];
                    // 添加灰色竖线
                    UIView *lineView = [[UIView alloc] init];
                    [button addSubview:lineView];
                    lineView.backgroundColor = LINE_COLOR;
                    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.mas_equalTo(button);
                        make.width.mas_equalTo(1);
                        make.right.mas_offset(-0.5);
                    }];
                }
            }
            [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
            [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lineView.mas_bottom);
                make.height.mas_equalTo(50);
                make.bottom.mas_offset(0);
            }];
        }
    }
    return self;
}

- (void)dealloc {
    NSLog(@"弹窗已释放");
}

- (void)buttonClicked:(UIButton *)sender {
    !self.buttonClickedBlock ?: self.buttonClickedBlock(sender.tag - kButtonBeginTag);
    [self removeFromSuperview];
}

@end
