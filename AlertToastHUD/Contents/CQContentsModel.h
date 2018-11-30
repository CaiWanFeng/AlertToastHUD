//
//  CQContentsModel.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "JSONModel.h"

typedef NS_ENUM(NSUInteger, CQItemType) {
    /** 申报异常弹窗 */
    CQItemTypeDeclareAlertView,
    /** 纯文本toast */
    CQItemTypeTextToast,
    /** 图文toast */
    CQItemTypeImageToast,
    /** 带block的弹窗 */
    CQItemTypeBlockAlertView,
    /** 带block和image的弹窗 */
    CQItemTypeImageAlertView,
    /** 炫彩AlertView */
    CQItemTypeColorfulAlertView,
    /** Loading */
    CQItemTypeLoading,
    /** 禁止用户交互的Loading */
    CQItemTypeForbidUserEnableLoading,
};

@interface CQContentsModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CQItemType type;

@end
