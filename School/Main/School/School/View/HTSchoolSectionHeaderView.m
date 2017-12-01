//
//  HTSchoolSectionHeaderView.m
//  School
//
//  Created by hublot on 2017/6/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolSectionHeaderView.h"
#import <UIButton+HTButtonCategory.h>

@interface HTSchoolSectionHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTSchoolSectionHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor whiteColor]]];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setTitleName:(NSString *)titleName {
	[self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:10];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		image = [image ht_resetSize:CGSizeMake(4, _titleNameButton.titleLabel.font.pointSize + 8)];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

@end
