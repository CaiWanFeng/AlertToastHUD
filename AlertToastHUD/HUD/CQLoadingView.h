//
//  CQLoadingView.h
//  AlertToastHUD
//
//  Created by 蔡强 on 2017/8/12.
//  Copyright © 2017年 Caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQLoadingView : UIView

/** loading信息 */
@property (nonatomic, copy) NSString *loadingInfo;

/** loading图单例 */
+ (instancetype)sharedInstance;

@end
