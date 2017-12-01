//
//  HTDiscoverActivityCell.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverActivityCell.h"
#import "HTDiscoverActivityModel.h"
#import <NSObject+HTTableRowHeight.h>
#import <NSString+HTString.h>
#import <NSMutableAttributedString+HTMutableAttributedString.h>

@interface HTDiscoverActivityCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UILabel *sendDateLabel;

@end

@implementation HTDiscoverActivityCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self addSubview:self.sendDateLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
	}];
	[self.sendDateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(15);
		make.right.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTDiscoverActivityModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
    NSMutableAttributedString *detailAttributedString = [[[model.answer ht_htmlDecodeString] ht_attributedStringNeedDispatcher:nil] mutableCopy];
    [detailAttributedString ht_clearBreakLineMaxAllowContinueCount:0];
	self.detailNameLabel.text = detailAttributedString.string;
	self.sendDateLabel.text = model.createTime;
	
	CGFloat modelHeight = 15;
	modelHeight += 15;
	modelHeight += 15;
	CGFloat detailTextHeight = [self.detailNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.detailNameLabel.font textView:nil];
	detailTextHeight = MIN(self.detailNameLabel.numberOfLines * (self.detailNameLabel.font.pointSize + 4), detailTextHeight);
	modelHeight += detailTextHeight;
	modelHeight += 15;
	modelHeight += 13;
	modelHeight += 15;
    [model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:14];
		_detailNameLabel.numberOfLines = 2;
	}
	return _detailNameLabel;
}

- (UILabel *)sendDateLabel {
	if (!_sendDateLabel) {
		_sendDateLabel = [[UILabel alloc] init];
		_sendDateLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSpecialTitle];
		_sendDateLabel.font = [UIFont systemFontOfSize:13];
	}
	return _sendDateLabel;
}


@end
