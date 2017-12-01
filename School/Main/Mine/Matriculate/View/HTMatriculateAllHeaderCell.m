//
//  HTMatriculateAllHeaderCell.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateAllHeaderCell.h"

@interface HTMatriculateAllHeaderCell ()

@end

@implementation HTMatriculateAllHeaderCell

- (void)didMoveToSuperview {
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.backgroundColor = [UIColor ht_colorString:@"eeeeeee"];
	[self addSubview:self.scoreCountLabel];
	[self addSubview:self.detailNameButton];
	[self addSubview:self.matriculateDateLabel];
	[self.scoreCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.mas_left).offset(70);
		make.centerY.mas_equalTo(self);
	}];
	[self.detailNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(self);
	}];
	[self.matriculateDateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.mas_right).offset(- 70);
		make.centerY.mas_equalTo(self);
	}];
}

- (UILabel *)scoreCountLabel {
	if (!_scoreCountLabel) {
		_scoreCountLabel = [[UILabel alloc] init];
		_scoreCountLabel.font = [UIFont systemFontOfSize:14];
		_scoreCountLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_scoreCountLabel.text = @"得分";
	}
	return _scoreCountLabel;
}

- (UIButton *)detailNameButton {
	if (!_detailNameButton) {
		_detailNameButton = [[UIButton alloc] init];
		_detailNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_detailNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		[_detailNameButton setTitle:@"详细" forState:UIControlStateNormal];
	}
	return _detailNameButton;
}


- (UILabel *)matriculateDateLabel {
	if (!_matriculateDateLabel) {
		_matriculateDateLabel = [[UILabel alloc] init];
		_matriculateDateLabel.font = [UIFont systemFontOfSize:14];
		_matriculateDateLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_matriculateDateLabel.text = @"时间";
	}
	return _matriculateDateLabel;
}


@end
