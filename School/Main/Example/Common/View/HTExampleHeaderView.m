//
//  HTExampleHeaderView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleHeaderView.h"

@interface HTExampleHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTExampleHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_example_header"];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

@end
