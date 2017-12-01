//
//  HTMatriculateResultSectionHeaderView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateResultSectionHeaderView.h"

@interface HTMatriculateResultSectionHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTMatriculateResultSectionHeaderView

- (void)didMoveToSuperview {
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor clearColor]]];
	self.backgroundView.alpha = 0;
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setTitleName:(NSString *)titleName {
	[self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:0.1];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIImage *image = [UIImage imageNamed:@"cn_matriculate_result_section_header"];
		image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20) resizingMode:UIImageResizingModeStretch];
		[_titleNameButton setBackgroundImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

@end
