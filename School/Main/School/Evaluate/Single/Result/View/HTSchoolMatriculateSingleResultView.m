//
//  HTSchoolMatriculateSingleResultView.m
//  School
//
//  Created by hublot on 2017/6/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSingleResultView.h"
#import "HTMatriculateRecordModel.h"

@interface HTSchoolMatriculateSingleResultView ()

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIImageView *whiteContentView;

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *scoreSchoolLabel;

@property (nonatomic, strong) UILabel *scoreNumberLabel;

@property (nonatomic, strong) UILabel *comparePercentLabel;

@property (nonatomic, strong) UILabel *resultDescriptionLabel;

@property (nonatomic, strong) UIButton *dismissResultButton;

@end

@implementation HTSchoolMatriculateSingleResultView

+ (void)showResultViewWithResultModel:(HTMatriculateSingleSchoolModel *)model {
	NSString *scoreNumber = model.score;
	NSString *comparePercent = model.percent;
	HTSchoolMatriculateSingleResultView *resultView = [[HTSchoolMatriculateSingleResultView alloc] init];
	[resultView fillScoreSchoolName:model.school majorName:model.major];
	[resultView fillScoreNumberText:scoreNumber];
	[resultView createComparePercentNumber:comparePercent];
	
	__weak typeof(resultView) weakResultView = resultView;
	[[UIApplication sharedApplication].keyWindow addSubview:weakResultView.backgroundView];
	[resultView.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[resultView.backgroundView addSubview:resultView];
	[resultView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(resultView.backgroundView);
		make.width.mas_equalTo(300);
		make.height.mas_equalTo(410);
	}];
	[resultView.dismissResultButton ht_whenTap:^(UIView *view) {
		[weakResultView dismissWithAnimated:true];
	}];
	[resultView startAnimation:true show:true];
}

- (void)dealloc {
	
}

- (void)didMoveToSuperview {
	[self addSubview:self.whiteContentView];
	[self addSubview:self.headerImageView];
	[self addSubview:self.scoreSchoolLabel];
	[self addSubview:self.scoreNumberLabel];
	[self addSubview:self.comparePercentLabel];
	[self addSubview:self.resultDescriptionLabel];
	[self addSubview:self.dismissResultButton];
	[self.whiteContentView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(self).offset(20);
	}];
	[self.scoreSchoolLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(30);
		make.right.mas_equalTo(- 30);
		make.top.mas_equalTo(self).offset(100);
	}];
	[self.scoreNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(self.scoreSchoolLabel.mas_bottom).offset(15);
	}];
	[self.comparePercentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(self.scoreNumberLabel.mas_bottom).offset(15);
	}];
	[self.resultDescriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.comparePercentLabel.mas_bottom).offset(15);
		make.left.mas_equalTo(self).offset(30);
		make.right.mas_equalTo(self).offset(- 30);
	}];
	[self.dismissResultButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.resultDescriptionLabel.mas_bottom).offset(15);
		make.centerX.mas_equalTo(self);
		make.width.mas_equalTo(150);
		make.height.mas_equalTo(35);
	}];
}

- (void)startAnimation:(BOOL)animated show:(BOOL)show {
	void(^willShowStateBlock)(void) = ^() {
		self.backgroundView.alpha = 0;
		self.transform = CGAffineTransformMakeScale(0.6, 0.6);
	};
	void(^willHiddenStateBlock)(void) = ^() {
		self.backgroundView.alpha = 1;
		self.transform = CGAffineTransformIdentity;
	};
	if (show) {
		willShowStateBlock();
	} else {
		willHiddenStateBlock();
	}
	[UIView animateWithDuration:animated ? 0.4 : 0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		if (show) {
			willHiddenStateBlock();
		} else {
			willShowStateBlock();
		}
	} completion:^(BOOL finished) {
		if (!show) {
			[self.backgroundView removeFromSuperview];
			[self removeFromSuperview];
		}
	}];
}

- (void)dismissWithAnimated:(BOOL)animated {
	[self startAnimation:animated show:false];
}

- (void)fillScoreSchoolName:(NSString *)schoolName majorName:(NSString *)majorName {
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"申请到" attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@-%@", schoolName, majorName] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"专业的分数为: " attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.scoreSchoolLabel.attributedText = attributedString;
}

- (void)fillScoreNumberText:(NSString *)score {
	self.scoreNumberLabel.text = [NSString stringWithFormat:@"%@分", score];
}

- (void)createComparePercentNumber:(NSString *)percent {
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
										 NSForegroundColorAttributeName:[UIColor orangeColor]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"已超过" attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", percent] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"的测试者" attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.comparePercentLabel.attributedText = attributedString;
}

- (UIView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [[UIView alloc] init];
		_backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	}
	return _backgroundView;
}

- (UIImageView *)whiteContentView {
	if (!_whiteContentView) {
		_whiteContentView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn2_school_matriculate_single_result_content"];
//		image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 100, 0) resizingMode:UIImageResizingModeTile];
		_whiteContentView.image = image;
	}
	return _whiteContentView;
}

- (UIImageView *)headerImageView {
	if (!_headerImageView) {
		_headerImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn2_school_matriculate_single_result_header"];
		image = [image ht_resetSizeWithStandard:250 isMinStandard:false];
		_headerImageView.image = image;
	}
	return _headerImageView;
}

- (UILabel *)scoreSchoolLabel {
	if (!_scoreSchoolLabel) {
		_scoreSchoolLabel = [[UILabel alloc] init];
		_scoreSchoolLabel.numberOfLines = 0;
	}
	return _scoreSchoolLabel;
}

- (UILabel *)scoreNumberLabel {
	if (!_scoreNumberLabel) {
		_scoreNumberLabel = [[UILabel alloc] init];
		_scoreNumberLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_scoreNumberLabel.font = [UIFont boldSystemFontOfSize:60];
	}
	return _scoreNumberLabel;
}

- (UILabel *)comparePercentLabel {
	if (!_comparePercentLabel) {
		_comparePercentLabel = [[UILabel alloc] init];
	}
	return _comparePercentLabel;
}

- (UILabel *)resultDescriptionLabel {
	if (!_resultDescriptionLabel) {
		_resultDescriptionLabel = [[UILabel alloc] init];
		_resultDescriptionLabel.numberOfLines = 0;
		NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
										   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSpecialTitle]};
		NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
											 NSForegroundColorAttributeName:[UIColor redColor]};
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"*" attributes:selectedDictionary] mutableCopy];
		NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:@"此报告匹配标准以近5年留学录取成功大数据作为技术 支撑并不能百分之百代表实际录取结果，仅供参考。" attributes:normalDictionary];
		[attributedString appendAttributedString:appendAttributedString];
		_resultDescriptionLabel.attributedText = attributedString;
	}
	return _resultDescriptionLabel;
}

- (UIButton *)dismissResultButton {
	if (!_dismissResultButton) {
		_dismissResultButton = [[UIButton alloc] init];
		_dismissResultButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_dismissResultButton setTitle:@"确认" forState:UIControlStateNormal];
		[_dismissResultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *higlightColor = [normalColor colorWithAlphaComponent:0.5];
		[_dismissResultButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_dismissResultButton setBackgroundImage:[UIImage ht_pureColor:higlightColor] forState:UIControlStateHighlighted];
		_dismissResultButton.layer.cornerRadius = 3;
		_dismissResultButton.layer.masksToBounds = true;
	}
	return _dismissResultButton;
}


@end
