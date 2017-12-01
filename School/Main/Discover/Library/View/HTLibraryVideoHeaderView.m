//
//  HTLibraryVideoHeaderView.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryVideoHeaderView.h"
#import <UIButton+HTButtonCategory.h>

@interface HTLibraryVideoHeaderView ()

@end

@implementation HTLibraryVideoHeaderView

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).offset(15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModelArray:(id)modelArray section:(NSInteger)section {
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:6];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		image = [image ht_resetSize:CGSizeMake(2, 15)];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

@end
