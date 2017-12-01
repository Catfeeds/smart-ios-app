//
//  HTMajorTextCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorTextCell.h"
#import <NSString+HTString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTMajorTextCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTMajorTextCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.titleNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

- (void)setModel:(NSString *)model row:(NSInteger)row {
	self.titleNameLabel.text = [model ht_htmlDecodeString];
	CGFloat modelHeight = 15;
	CGFloat textHeight = [model ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.titleNameLabel.font textView:nil];
	modelHeight += textHeight;
	modelHeight += 15;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}


@end
