//
//  HTSchoolBaseDataCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolBaseDataCell.h"
#import "HTSchoolModel.h"

@interface HTSchoolBaseDataCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTSchoolBaseDataCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.bottom.mas_equalTo(- 15);
		make.width.mas_equalTo(100);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.top.bottom.mas_equalTo(self.titleNameLabel);
		make.left.mas_equalTo(self.titleNameLabel.mas_right);
	}];
}

- (void)setModel:(HTSchoolBaseDataModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.titleName;
	self.detailNameLabel.text = model.detailName;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor whiteColor];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		_titleNameLabel.backgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:15];
		_detailNameLabel.textAlignment = NSTextAlignmentCenter;
		_detailNameLabel.layer.borderColor = [UIColor ht_colorStyle:HTColorStyleTintColor].CGColor;
		_detailNameLabel.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
	}
	return _detailNameLabel;
}

@end
