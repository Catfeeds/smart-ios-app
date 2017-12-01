//
//  HTOrganizationSectionHeader.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationSectionHeader.h"
#import <UIButton+HTButtonCategory.h>
#import "HTOrganizationDetialModel.h"

@interface HTOrganizationSectionHeader ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTOrganizationSectionHeader

- (void)didMoveToSuperview {
	self.clipsToBounds = true;
	self.backgroundView.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).offset(15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setTitleName:(NSString *)titleName {
	[self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:8];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:16];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		image = [image ht_resetSize:CGSizeMake(2, 16)];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
		
	}
	return _titleNameButton;
}

@end
