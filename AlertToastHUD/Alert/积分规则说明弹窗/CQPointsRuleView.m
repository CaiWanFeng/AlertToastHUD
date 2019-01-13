//
//  CQPointsRuleView.m
//  PointsRuleViewDemo
//
//  Created by caiqiang on 2019/1/11.
//  Copyright © 2019年 Caiqiang. All rights reserved.
//

#import "CQPointsRuleView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface CQPointsRuleView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CQPointsRuleView

+ (void)showWithImageURL:(NSString *)imageURL {
    [SVProgressHUD show];
    
    __block CQPointsRuleView *pointsRuleView = [[CQPointsRuleView alloc] initWithImageURL:imageURL loadCompletion:^(BOOL hasError) {
        [SVProgressHUD dismiss];
        
        if (hasError) {
            [pointsRuleView removeFromSuperview];
            [SVProgressHUD showErrorWithStatus:@"network error"];
            return;
        }
        
        // do some animation
        [UIView animateWithDuration:0.2 animations:^{
            pointsRuleView.alpha = 1;
            pointsRuleView.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
    
    // before animation
    pointsRuleView.alpha = 0;
    pointsRuleView.imageView.transform = CGAffineTransformScale(pointsRuleView.imageView.transform, 0.2, 0.2);
    
    [[UIApplication sharedApplication].delegate.window addSubview:pointsRuleView];
}

- (instancetype)initWithImageURL:(NSString *)imageURL loadCompletion:(void (^)(BOOL hasError))completion {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // load image
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            // call block
            !completion ?: completion(error != nil);
        }];
        
        // add tap gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews {
    self.frame = self.superview.bounds;
    self.imageView.frame = CGRectMake(30, 90, [UIScreen mainScreen].bounds.size.width-60, [UIScreen mainScreen].bounds.size.height-180);
}

@end
