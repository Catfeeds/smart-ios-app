//
//  HTMajorCourseCollectionCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorCourseCollectionCell.h"

@implementation HTMajorCourseCollectionCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(NSString *)model row:(NSInteger)row {
	NSDictionary *dictionary = @{NSFontAttributeName:self.titleNameButton.titleLabel.font,
								 NSForegroundColorAttributeName:[self.titleNameButton titleColorForState:UIControlStateNormal]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model attributes:dictionary] mutableCopy];
	[self.titleNameButton setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
