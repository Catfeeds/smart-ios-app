//
//  HTProfessionalRequireCollectionCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalRequireCollectionCell.h"

@interface HTProfessionalRequireCollectionCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTProfessionalRequireCollectionCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.titleNameLabel];
	self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor clearColor]]];
	self.selectedBackgroundView.alpha = 0;
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self);
	}];
}

- (void)setModel:(id)model row:(NSInteger)row {
	UIColor *textColor;
	UIColor *backgroundColor;
	if (row % 2 == 0) {
		textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
	} else {
		textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	}
	if ((row / 2) % 2 == row % 2) {
		backgroundColor = [UIColor ht_colorString:@"f5f5f5"];
	} else {
		backgroundColor = [UIColor whiteColor];
	}
	self.titleNameLabel.textColor = textColor;
	self.titleNameLabel.text = model;
	self.titleNameLabel.backgroundColor = backgroundColor;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameLabel;
}

@end
