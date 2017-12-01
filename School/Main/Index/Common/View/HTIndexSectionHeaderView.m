//
//  HTIndexSectionHeaderView.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexSectionHeaderView.h"
#import <UIButton+HTButtonCategory.h>

@interface HTIndexSectionHeaderView ()

@property (nonatomic, strong) UIButton *headerLeftButton;

@property (nonatomic, strong) UIButton *headerRightButton;

@property (nonatomic, strong) UIView *separatorLineView;

@end

@implementation HTIndexSectionHeaderView

- (void)setHeaderRightDetailTapedBlock:(void (^)(void))headerRightDetailTapedBlock {
	_headerRightDetailTapedBlock = headerRightDetailTapedBlock;
	if (_headerRightDetailTapedBlock) {
		self.headerRightButton.hidden = false;
		[self.headerRightButton ht_whenTap:^(UIView *view) {
			_headerRightDetailTapedBlock();
		}];
	}
}

- (void)setTitleName:(NSString *)titleName imageName:(NSString *)imageName separatorLineHidden:(BOOL)separatorLineHidden {
	[self.headerLeftButton setTitle:titleName forState:UIControlStateNormal];
	self.separatorLineView.hidden = separatorLineHidden;
	UIImage *image = [UIImage imageNamed:imageName];
	image = [image ht_resetSizeWithStandard:15 isMinStandard:true];
	[self.headerLeftButton setImage:image forState:UIControlStateNormal];
}

- (void)setModelArray:(NSMutableArray *)modelArray section:(NSInteger)section {
	
}

- (void)didMoveToSuperview {
	self.contentView.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.headerLeftButton];
	[self addSubview:self.headerRightButton];
	[self addSubview:self.separatorLineView];
	[self.headerLeftButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
	[self.headerLeftButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).offset(10);
		make.centerY.mas_equalTo(self);
		make.height.mas_equalTo(self);
	}];
	[self.headerRightButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self).offset(- 10);
		make.centerY.mas_equalTo(self);
		make.height.mas_equalTo(self);
	}];
	[self.separatorLineView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self).offset(10);
		make.right.mas_equalTo(self);
		make.bottom.mas_equalTo(self);
		make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
	}];
}

- (UIButton *)headerLeftButton {
	if (!_headerLeftButton) {
		_headerLeftButton = [[UIButton alloc] init];
		[_headerLeftButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		_headerLeftButton.titleLabel.font = [UIFont systemFontOfSize:13];
	}
	return _headerLeftButton;
}

- (UIButton *)headerRightButton {
	if (!_headerRightButton) {
		_headerRightButton = [[UIButton alloc] init];
		[_headerRightButton setTitle:@"more >" forState:UIControlStateNormal];
		[_headerRightButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle] forState:UIControlStateNormal];
		_headerRightButton.titleLabel.font = [UIFont systemFontOfSize:13];
		_headerRightButton.hidden = true;
	}
	return _headerRightButton;
}

- (UIView *)separatorLineView {
	if (!_separatorLineView) {
		_separatorLineView = [[UIView alloc] init];
		_separatorLineView.backgroundColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate];
	}
	return _separatorLineView;
}

@end
