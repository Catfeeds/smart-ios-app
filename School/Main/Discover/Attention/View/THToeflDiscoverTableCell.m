//
//  THToeflDiscoverTableCell.m
//  TingApp
//
//  Created by hublot on 16/9/26.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import "THToeflDiscoverTableCell.h"
#import <UIButton+HTButtonCategory.h>
#import "THToeflDiscoverModel.h"

@interface THToeflDiscoverTableCell ()

@property (nonatomic, strong) UIButton *headImageButton;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UIButton *rightLookButton;

@end

@implementation THToeflDiscoverTableCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageButton];
	[self addSubview:self.usernameLabel];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self addSubview:self.rightLookButton];
	[self.headImageButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(23);
		make.centerY.mas_equalTo(self).offset(- 10);
		make.width.height.mas_equalTo(50);
	}];
	[self.usernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.headImageButton);
		make.top.mas_equalTo(self.headImageButton.mas_bottom).offset(7);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.left.mas_equalTo(self.headImageButton.mas_right).offset(30);
		make.top.mas_equalTo(self.headImageButton);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleNameLabel);
		make.centerY.mas_equalTo(self.usernameLabel);
		make.left.mas_greaterThanOrEqualTo(self.usernameLabel.mas_right).offset(10).priority(900);
	}];
	[self.rightLookButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self.detailNameLabel);
		make.left.mas_greaterThanOrEqualTo(self.detailNameLabel.mas_right).offset(15).priority(900);
	}];
}

- (void)setModel:(THToeflDiscoverModel *)model row:(NSInteger)row {
	self.titleNameLabel.font = [UIFont systemFontOfSize:14];
	[self.headImageButton setImage:[HTPLACEHOLDERIMAGE imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
	self.usernameLabel.text = HTPlaceholderString(model.nickname, model.username);
	self.titleNameLabel.text = model.title;
	
	NSString *sentTimeString = model.dateTime;
	self.detailNameLabel.text = [NSString stringWithFormat:@"发布于 %@", sentTimeString];
	[self.rightLookButton setTitle:model.viewCount forState:UIControlStateNormal];
}

- (UIButton *)headImageButton {
	if (!_headImageButton) {
		_headImageButton = [[UIButton alloc] init];
		_headImageButton.imageView.layer.cornerRadius = 25;
		_headImageButton.imageView.layer.masksToBounds = true;
	}
	return _headImageButton;
}

- (UILabel *)usernameLabel {
	if (!_usernameLabel) {
		_usernameLabel = [[UILabel alloc] init];
		_usernameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_usernameLabel.font = [UIFont systemFontOfSize:12];
	}
	return _usernameLabel;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.font = [UIFont systemFontOfSize:13];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		[_detailNameLabel setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisHorizontal];
		[_detailNameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _detailNameLabel;
}

- (UIButton *)rightLookButton {
	if (!_rightLookButton) {
		_rightLookButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_discover_team_visit"];
		image = [image ht_resetSizeZoomNumber:0.8];
		[_rightLookButton setImage:image forState:UIControlStateNormal];
		[_rightLookButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		_rightLookButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[_rightLookButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:3];
	}
	return _rightLookButton;
}

- (void)setFrame:(CGRect)frame {
	frame.origin.y += 10;
	frame.size.height -= 10;
	[super setFrame:frame];
}

@end
