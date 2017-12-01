//
//  HTMajorDetailCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorDetailCell.h"
#import "HTMajorDetailModel.h"
#import <NSString+HTString.h>
#import <UIButton+HTButtonCategory.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTMajorDetailCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTMajorDetailCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.titleNameButton];
	[self addSubview:self.detailNameLabel];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(7.5);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.titleNameButton.mas_bottom).offset(15);
	}];
}

- (void)setModel:(HTMajorDetailFormModel *)model row:(NSInteger)row {
	[self.titleNameButton setTitle:model.titleName forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
	
	self.detailNameLabel.text = [model.detailName ht_htmlDecodeString];
	CGFloat detailHeight = [self.detailNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:self.detailNameLabel.font textView:nil];
	
	CGFloat modelHeight = 7.5;
	modelHeight += 20;
	modelHeight += 15;
	modelHeight += detailHeight;
	modelHeight += 7.5;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:16];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		
		UIImage *image = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]];
		image = [image ht_resetSize:CGSizeMake(2, 16)];
		[_titleNameButton setImage:image forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:14];
		_detailNameLabel.numberOfLines = 0;
	}
	return _detailNameLabel;
}



@end
