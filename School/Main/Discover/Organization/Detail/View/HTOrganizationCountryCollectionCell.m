//
//  HTOrganizationCountryCollectionCell.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationCountryCollectionCell.h"

@interface HTOrganizationCountryCollectionCell ()

@end

@implementation HTOrganizationCountryCollectionCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(NSString *)model row:(NSInteger)row {
	self.titleNameLabel.text = model;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameLabel;
}


@end
