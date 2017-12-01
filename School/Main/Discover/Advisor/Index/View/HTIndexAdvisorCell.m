//
//  HTIndexAdvisorCell.m
//  School
//
//  Created by hublot on 17/8/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAdvisorCell.h"
#import "HTIndexAdvisorModel.h"
#import <NSString+HTString.h>

@interface HTIndexAdvisorCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation HTIndexAdvisorCell

- (void)didMoveToSuperview {
    [self addSubview:self.headImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.detailNameLabel];
	[self addSubview:self.introductionLabel];
    
    CGFloat line = 50;
    self.headImageView.layer.cornerRadius = line / 2;
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(line);
		make.top.mas_equalTo(15);
    }];
    [self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(- 15);
    }];
    [self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nicknameLabel);
		make.top.mas_equalTo(self.nicknameLabel.mas_bottom).offset(10);
    }];
	[self.introductionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.nicknameLabel);
		make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(10);
		make.bottom.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTIndexAdvisorModel *)model row:(NSInteger)row {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
    self.nicknameLabel.text = model.name;
    self.detailNameLabel.text = model.source;
	self.introductionLabel.text = [[model.answer ht_htmlDecodeString] ht_attributedStringNeedDispatcher:nil].string;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = true;
    }
    return _headImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _nicknameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nicknameLabel;
}

- (UILabel *)detailNameLabel {
    if (!_detailNameLabel) {
        _detailNameLabel = [[UILabel alloc] init];
        _detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
        _detailNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailNameLabel;
}

- (UILabel *)introductionLabel {
	if (!_introductionLabel) {
		_introductionLabel = [[UILabel alloc] init];
		_introductionLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSpecialTitle];
		_introductionLabel.font = [UIFont systemFontOfSize:13];
		_introductionLabel.numberOfLines = 0;
	}
	return _introductionLabel;
}


@end
