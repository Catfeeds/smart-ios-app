//
//  HTSchoolMajorDetailCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMajorDetailCell.h"

@interface HTSchoolMajorDetailCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTSchoolMajorDetailCell

+ (CGFloat)collectionItemHeight {
	return 30;
}

+ (CGFloat)cellFontPointSize {
	return 13;
}

- (void)didMoveToSuperview {
	self.titleNameButton.layer.cornerRadius = [self.class collectionItemHeight] / 2;
	self.titleNameButton.layer.masksToBounds = true;
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.titleNameButton];
	self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor clearColor]]];
	self.selectedBackgroundView.alpha = 0;
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		//make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
	}];
}

- (void)setModel:(HTSchoolProfessionalSubModel *)model row:(NSInteger)row {
	[self.titleNameButton setTitle:model.name forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
	[self setHighlighted:selected];
	[super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	self.titleNameButton.selected = highlighted;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:[self.class cellFontPointSize]];
		_titleNameButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStyleTintColor].CGColor;
		_titleNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		[_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor whiteColor]] forState:UIControlStateNormal];
		[_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]] forState:UIControlStateSelected];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		_titleNameButton.userInteractionEnabled = false;
        _titleNameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
	}
	return _titleNameButton;
}

@end
