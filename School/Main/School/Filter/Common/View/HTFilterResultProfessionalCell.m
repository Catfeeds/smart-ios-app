//
//  HTFilterResultProfessionalCell.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFilterResultProfessionalCell.h"
#import "HTFilterResultSchoolModel.h"

@interface HTFilterResultProfessionalCell ()

@end

@implementation HTFilterResultProfessionalCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(HTFilterResultProfessionalModel *)model row:(NSInteger)row {
	NSString *titleName = model.title;
	[self.titleNameButton setTitle:titleName forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.titleNameButton.highlighted = highlighted;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:13];
		_titleNameButton.layer.cornerRadius = 3;
		_titleNameButton.layer.masksToBounds = true;
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		UIColor *normalColor = [UIColor ht_colorString:@"f3f4ec"];
		UIColor *highlightColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIImage *normalImage = [UIImage ht_pureColor:normalColor];
		UIImage *highlightImage = [UIImage ht_pureColor:highlightColor];
		[_titleNameButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[_titleNameButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
