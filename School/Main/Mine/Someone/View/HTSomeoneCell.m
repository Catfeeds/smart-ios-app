//
//  HTSomeoneCell.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSomeoneCell.h"
#import "HTSomeoneModel.h"
#import <UIButton+HTButtonCategory.h>

@interface HTSomeoneCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTSomeoneCell

- (void)didMoveToSuperview {
    [self addSubview:self.titleNameButton];
    [self addSubview:self.detailNameLabel];
    [self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 25);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setModel:(HTSomeoneModel *)model row:(NSInteger)row {
    UIImage *image = [UIImage imageNamed:model.imageName];
    image = [image ht_resetSizeWithStandard:18 isMinStandard:false];
    image = [image ht_tintColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]];
    [self.titleNameButton setImage:image forState:UIControlStateNormal];
    [self.titleNameButton setTitle:model.titleName forState:UIControlStateNormal];
    [self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:20];
    self.detailNameLabel.text = model.detailCount;
}

- (UIButton *)titleNameButton {
    if (!_titleNameButton) {
        _titleNameButton = [[UIButton alloc] init];
        _titleNameButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
    }
    return _titleNameButton;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _detailNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _detailNameLabel;
}

@end
