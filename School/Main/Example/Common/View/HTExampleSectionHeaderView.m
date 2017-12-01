//
//  HTExampleSectionHeaderView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleSectionHeaderView.h"

@interface HTExampleSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *moreDetailLabel;

@end

@implementation HTExampleSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
		[self setSectionMoreBlock:nil titleName:@""];
	}
	return self;
}

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.moreDetailLabel];
	UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor whiteColor]]];
	self.backgroundView = selectedImageView;
	self.backgroundView.alpha = 0;
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(self);
	}];
	[self.moreDetailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setSectionMoreBlock:(void (^)(void))sectionMoreBlock titleName:(NSString *)titleName {
	self.titleNameLabel.text = titleName;
	if (sectionMoreBlock) {
		self.moreDetailLabel.hidden = false;
		[self.moreDetailLabel ht_whenTap:^(UIView *view) {
			if (sectionMoreBlock) {
				sectionMoreBlock();
			}
		}];
	} else {
		self.moreDetailLabel.hidden = true;
	}
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.font = [UIFont systemFontOfSize:18 weight:0.2];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	}
	return _titleNameLabel;
}

- (UILabel *)moreDetailLabel {
	if (!_moreDetailLabel) {
		_moreDetailLabel = [[UILabel alloc] init];
		_moreDetailLabel.font = [UIFont systemFontOfSize:15];
		_moreDetailLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_moreDetailLabel.text = @"MORE";
	}
	return _moreDetailLabel;
}

@end
