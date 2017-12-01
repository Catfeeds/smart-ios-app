//
//  HTBookCell.m
//  School
//
//  Created by hublot on 17/8/13.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBookCell.h"
#import "HTBookModel.h"

@interface HTBookCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTBookCell

- (void)didMoveToSuperview {
    [self addSubview:self.headImageView];
    [self addSubview:self.titleNameLabel];
    [self addSubview:self.detailNameLabel];
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(15);
        make.bottom.mas_equalTo(- 15);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    [self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(- 15);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleNameLabel);
        make.bottom.mas_equalTo(self.headImageView);
    }];
}

- (void)setModel:(HTBookModel *)model row:(NSInteger)row {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.titleNameLabel.text = model.name;
    self.detailNameLabel.text = model.answer;
}

- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
        _detailNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailNameLabel;
}


- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = true;
    }
    return _headImageView;
}


@end
