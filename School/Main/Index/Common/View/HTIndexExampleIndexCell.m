//
//  HTIndexExampleIndexCell.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexExampleIndexCell.h"

@interface HTIndexExampleIndexCell ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTIndexExampleIndexCell

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.titleNameButton];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(0.4);
		make.height.mas_equalTo(self).multipliedBy(0.4);
	}];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	self.backgroundImageView.highlighted = highlighted;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		UIImage *highlightImage = [UIImage imageNamed:@"cn_index_example_background"];
		UIImage *darkImage = [UIImage ht_pureColor:[UIColor colorWithWhite:0 alpha:0.3]];
		darkImage = [darkImage ht_resetSize:highlightImage.size];
		UIImage *normalImage = [highlightImage ht_appendImage:darkImage atRect:CGRectMake(0, 0, darkImage.size.width, darkImage.size.height)];
		_backgroundImageView.image = normalImage;
		_backgroundImageView.highlightedImage = highlightImage;
	}
	return _backgroundImageView;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:16];
		[_titleNameButton setTitle:@"热门案例" forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		_titleNameButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
		_titleNameButton.layer.cornerRadius = 3;
		_titleNameButton.layer.masksToBounds = true;
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}



@end
