//
//  HTSearchResultCell.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchResultCell.h"
#import "HTSearchResultModel.h"

@interface HTSearchResultCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTSearchResultCell

- (void)didMoveToSuperview {
	[self.contentView addSubview:self.titleNameLabel];
	[self.contentView addSubview:self.detailNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
		make.right.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTSearchResultModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.titleName;
	self.detailNameLabel.text = model.detailName;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:13];
	}
	return _detailNameLabel;
}

@end
