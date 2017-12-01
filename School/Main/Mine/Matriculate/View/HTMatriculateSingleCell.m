//
//  HTMatriculateSingleCell.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateSingleCell.h"
#import "HTMatriculateRecordModel.h"
#import <NSString+HTString.h>

@interface HTMatriculateSingleCell ()

@property (nonatomic, strong) UILabel *schoolNameLabel;

@property (nonatomic, strong) UILabel *professionalNameLabel;

@property (nonatomic, strong) UIView *separatorLineView;

@property (nonatomic, strong) UILabel *scoreCountLabel;

@property (nonatomic, strong) UIButton *detailNameButton;

@property (nonatomic, strong) UILabel *matriculateDateLabel;

@end

@implementation HTMatriculateSingleCell

- (void)didMoveToSuperview {
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = true;
	[self addSubview:self.schoolNameLabel];
	[self addSubview:self.professionalNameLabel];
	[self addSubview:self.separatorLineView];
	[self addSubview:self.scoreCountLabel];
	[self addSubview:self.detailNameButton];
	[self addSubview:self.matriculateDateLabel];
	[self.schoolNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(self.mas_centerX);
		make.bottom.mas_equalTo(self.separatorLineView.mas_top).offset(- 23);
	}];
	[self.professionalNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.mas_centerX);
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self.schoolNameLabel);
	}];
	[self.separatorLineView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
		make.left.right.mas_equalTo(self);
		make.height.mas_equalTo( 1 / [UIScreen mainScreen].scale);
	}];
	[self.scoreCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(self.separatorLineView.mas_bottom).offset(20);
	}];
	[self.detailNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.centerY.mas_equalTo(self.scoreCountLabel);
	}];
	[self.matriculateDateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self.scoreCountLabel);
	}];
}

- (void)setModel:(HTMatriculateSingleSchoolModel *)model row:(NSInteger)row {
	self.schoolNameLabel.text = [NSString stringWithFormat:@"大学: %@", [model.school ht_htmlDecodeString]];
	self.professionalNameLabel.text = [NSString stringWithFormat:@"专业: %@", model.major];
	self.scoreCountLabel.text = [NSString stringWithFormat:@"%@%%", model.percent];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createTime.integerValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm";
    NSString *createTimeString = [formatter stringFromDate:date];
	self.matriculateDateLabel.text = createTimeString;
}

- (UILabel *)schoolNameLabel {
	if (!_schoolNameLabel) {
		_schoolNameLabel = [[UILabel alloc] init];
		_schoolNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_schoolNameLabel.font = [UIFont systemFontOfSize:15];
	}
	return _schoolNameLabel;
}

- (UILabel *)professionalNameLabel {
	if (!_professionalNameLabel) {
		_professionalNameLabel = [[UILabel alloc] init];
		_professionalNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_professionalNameLabel.font = [UIFont systemFontOfSize:15];
	}
	return _professionalNameLabel;
}

- (UIView *)separatorLineView {
	if (!_separatorLineView) {
		_separatorLineView = [[UIView alloc] init];
		_separatorLineView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
	}
	return _separatorLineView;
}


- (UILabel *)scoreCountLabel {
	if (!_scoreCountLabel) {
		_scoreCountLabel = [[UILabel alloc] init];
		_scoreCountLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_scoreCountLabel.font = [UIFont systemFontOfSize:19];
	}
	return _scoreCountLabel;
}

- (UIButton *)detailNameButton {
	if (!_detailNameButton) {
		_detailNameButton = [[UIButton alloc] init];
		[_detailNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalBackgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *highlightBackgroundColor = [normalBackgroundColor colorWithAlphaComponent:0.5];
		[_detailNameButton setBackgroundImage:[UIImage ht_pureColor:normalBackgroundColor] forState:UIControlStateNormal];
		[_detailNameButton setBackgroundImage:[UIImage ht_pureColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
		[_detailNameButton setTitle:@"查看详情" forState:UIControlStateNormal];
		_detailNameButton.titleLabel.font = [UIFont systemFontOfSize:13];
		_detailNameButton.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
		_detailNameButton.layer.cornerRadius = 3;
		_detailNameButton.layer.masksToBounds = true;
		_detailNameButton.userInteractionEnabled = false;
	}
	return _detailNameButton;
}


- (UILabel *)matriculateDateLabel {
	if (!_matriculateDateLabel) {
		_matriculateDateLabel = [[UILabel alloc] init];
		_matriculateDateLabel.font = [UIFont systemFontOfSize:14];
		_matriculateDateLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
	}
	return _matriculateDateLabel;
}

- (void)setFrame:(CGRect)frame {
	frame.origin.x += 15;
	frame.size.width -= 30;
	frame.origin.y += 15;
	frame.size.height -= 15;
	[super setFrame:frame];
}

@end
