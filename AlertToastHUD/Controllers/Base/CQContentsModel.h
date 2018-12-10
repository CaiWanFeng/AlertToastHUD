//
//  CQContentsModel.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "JSONModel.h"

@interface CQContentsModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger type;

@end
