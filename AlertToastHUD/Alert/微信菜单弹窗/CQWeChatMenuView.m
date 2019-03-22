//
//  CQWeChatMenuView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/7.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQWeChatMenuView.h"

@interface CQWeChatMenuView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) dispatch_block_t b;

@end

@implementation CQWeChatMenuView

+ (void)showWithItems:(NSArray *)items cellClickedBlock:(void (^)(NSInteger index))block {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}



@end
