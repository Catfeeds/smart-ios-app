//
//  HTOrganizationAdvisorCell.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationAdvisorCell.h"
#import <UIButton+HTButtonCategory.h>
#import "HTOrganizationDetialModel.h"
#import "HTWebController.h"
#import <NSString+HTString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>

@interface HTOrganizationAdvisorCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTOrganizationAdvisorCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	CGFloat line = 45;
	self.headImageView.layer.cornerRadius = line / 2;
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.width.height.mas_equalTo(line);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(10);
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.right.mas_equalTo(- 15);
		make.bottom.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTOrganizationDetailAdvisorModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.titleNameLabel.text = model.name;
	
	__weak typeof(self) weakSelf = self;
	if (!model.attributedString) {
		[model.answer ht_attributedStringNeedDispatcher:^(NSAttributedString *attributedString) {
			NSMutableAttributedString *fontAttributedString = [attributedString mutableCopy];
			[fontAttributedString ht_changeFontWithPointSize:13];
			[fontAttributedString ht_changeColorWithColorAlpha:0.5];
			model.attributedString = fontAttributedString;
			weakSelf.detailNameLabel.attributedText = fontAttributedString;
		}];
	} else {
		weakSelf.detailNameLabel.attributedText = model.attributedString;
	}
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.layer.masksToBounds = true;
	}
	return _headImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.numberOfLines = 0;
		[_detailNameLabel setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisVertical];
		[_detailNameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisVertical];
	}
	return _detailNameLabel;
}


@end
