//
//  CQContentsModel.h
//  AlertToastHUD
//
//  Created by caiqiang on 2018/11/30.
//  Copyright © 2018年 kuaijiankang. All rights reserved.
//

#import "JSONModel.h"

typedef NS_ENUM(NSUInteger, CQContentsType) {
    /** 申报异常弹窗 */
    CQContentsTypeDeclareAlertView,
    /** 纯文本toast */
    CQContentsTypeTextToast,
    /** 图文toast */
    CQContentsTypeImageToast,
    /** 带block的弹窗 */
    CQContentsTypeBlockAlertView,
    /** 带block和image的弹窗 */
    CQContentsTypeImageAlertView,
    /** 炫彩AlertView */
    CQContentsTypeColorfulAlertView,
    /** Loading */
    CQContentsTypeLoading,
    /** 禁止用户交互的Loading */
    CQContentsTypeForbidUserEnableLoading,
};

@interface CQContentsModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CQContentsType type;

@end
