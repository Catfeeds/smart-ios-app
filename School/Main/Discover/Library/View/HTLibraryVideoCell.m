//
//  HTLibraryVideoCell.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryVideoCell.h"
#import "HTLibraryModel.h"
#import <UIButton+HTButtonCategory.h>

@interface HTLibraryVideoCell ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIButton *leftTimeButton;

@property (nonatomic, strong) UIButton *rightLookButton;

@end

@implementation HTLibraryVideoCell

- (void)didMoveToSuperview {
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = true;
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.leftTimeButton];
	[self addSubview:self.rightLookButton];
	
	CGFloat bottomHeight = 30;
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(self);
		make.bottom.mas_equalTo(self.titleNameLabel.mas_top).offset(- 10);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(10);
		make.right.mas_equalTo(- 10);
		make.bottom.mas_equalTo(- bottomHeight);
	}];
	[self.leftTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(10);
		make.bottom.mas_equalTo(self);
		make.height.mas_equalTo(bottomHeight);
	}];
	[self.rightLookButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 10);
		make.bottom.mas_equalTo(self);
		make.height.mas_equalTo(bottomHeight);
	}];
}

- (void)setModel:(HTLibraryProjectVideoContentModel *)model row:(NSInteger)row {
	[self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.titleNameLabel.text = model.title;
	[self.leftTimeButton setTitle:model.duration forState:UIControlStateNormal];
	[self.rightLookButton setTitle:model.viewCount forState:UIControlStateNormal];
	[self.leftTimeButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
	[self.rightLookButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		_backgroundImageView.clipsToBounds = true;
	}
	return _backgroundImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameLabel setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisVertical];
		[_titleNameLabel setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisVertical];
	}
	return _titleNameLabel;
}


- (UIButton *)leftTimeButton {
	if (!_leftTimeButton) {
		_leftTimeButton = [[UIButton alloc] init];
		UIColor *tintColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		UIImage *image = [UIImage imageNamed:@"cn_answer_online_clock"];
		image = [image ht_resetSizeWithStandard:15 isMinStandard:false];
		image = [image ht_tintColor:tintColor];
		[_leftTimeButton setImage:image forState:UIControlStateNormal];
		_leftTimeButton.titleLabel.font = [UIFont systemFontOfSize:13];
		[_leftTimeButton setTitleColor:tintColor forState:UIControlStateNormal];
	}
	return _leftTimeButton;
}

- (UIButton *)rightLookButton {
	if (!_rightLookButton) {
		_rightLookButton = [[UIButton alloc] init];
		UIColor *tintColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		UIImage *image = [UIImage imageNamed:@"cn_discover_team_visit"];
		image = [image ht_resetSizeWithStandard:15 isMinStandard:false];
		image = [image ht_tintColor:tintColor];
		[_rightLookButton setImage:image forState:UIControlStateNormal];
		_rightLookButton.titleLabel.font = [UIFont systemFontOfSize:13];
		[_rightLookButton setTitleColor:tintColor forState:UIControlStateNormal];
	}
	return _rightLookButton;
}


@end
