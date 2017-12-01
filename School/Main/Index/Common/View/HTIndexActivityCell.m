//
//  HTIndexActivityCell.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexActivityCell.h"
#import "HTIndexModel.h"

@interface HTIndexActivityCell ()

@property (nonatomic, strong) UIView *darkSelectedView;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTIndexActivityCell

- (void)didMoveToSuperview {
	self.layer.cornerRadius = 5;
	self.layer.masksToBounds = true;
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.titleNameLabel];
	self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
	self.darkSelectedView.hidden = !self.highlighted;
	[self addSubview:self.darkSelectedView];
	[self.darkSelectedView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self);
	}];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.mas_equalTo(self);
		make.bottom.mas_equalTo(self.titleNameLabel.mas_top).offset(- 10);
	}];
}

- (void)setModel:(HTIndexActivity *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
	[self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.darkSelectedView.hidden = !highlighted;
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
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameLabel setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisVertical];
		[_titleNameLabel setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisVertical];
	}
	return _titleNameLabel;
}

- (UIView *)darkSelectedView {
	if (!_darkSelectedView) {
		_darkSelectedView = [[UIView alloc] init];
		_darkSelectedView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
	}
	return _darkSelectedView;
}

@end
