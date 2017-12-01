//
//  HTMajorSectionHeaderView.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorSectionHeaderView.h"
#import <UIButton+HTButtonCategory.h>

@interface HTMajorSectionHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTMajorSectionHeaderView

+ (CGFloat)timeLineCenterX {
	return 10;
}

- (void)didMoveToSuperview {
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor clearColor]]];
	self.backgroundView.alpha = 0;
	self.clipsToBounds = true;
	self.backgroundView.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.titleNameButton];
	CGFloat timeLineCenterY = 10;
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).offset(timeLineCenterY - 2);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setTitleName:(NSString *)titleName {
	[self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:16];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		CGFloat line = 4;
		image = [image ht_resetSize:CGSizeMake(line, line)];
		image = [image ht_imageByRoundCornerRadius:line / 2 corners:UIRectCornerAllCorners borderWidth:0 borderColor:nil borderLineJoin:kCGLineJoinRound];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
		
	}
	return _titleNameButton;
}

@end
