//
//  CQWeChatItemCell.m
//  AlertToastHUD
//
//  Created by caiqiang on 2019/2/10.
//  Copyright © 2019年 kuaijiankang. All rights reserved.
//

#import "CQWeChatItemCell.h"

@interface CQWeChatItemCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CQWeChatItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setModel:(CQWeChatItemModel *)model {
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:_model.imageName];
    self.titleLabel.text = _model.title;
}

@end
