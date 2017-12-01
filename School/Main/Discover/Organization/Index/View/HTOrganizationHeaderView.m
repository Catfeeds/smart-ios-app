//
//  HTOrganizationHeaderView.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationHeaderView.h"

@interface HTOrganizationHeaderView ()

@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation HTOrganizationHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundButton];
	[self.backgroundButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UIButton *)backgroundButton {
	if (!_backgroundButton) {
		_backgroundButton = [[UIButton alloc] init];
		_backgroundButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
		_backgroundButton.clipsToBounds = true;
		UIImage *normalImage = [UIImage imageNamed:@"cn_organization_header_background"];
		UIImage *darkImage = [UIImage ht_pureColor:[UIColor colorWithWhite:0 alpha:0.5]];
		darkImage = [darkImage ht_resetSize:normalImage.size];
		UIImage *highlightImage = [normalImage ht_appendImage:darkImage atRect:CGRectMake(0, 0, darkImage.size.width, darkImage.size.height)];
		[_backgroundButton setImage:normalImage forState:UIControlStateNormal];
		[_backgroundButton setImage:highlightImage forState:UIControlStateHighlighted];
	}
	return _backgroundButton;
}

@end
