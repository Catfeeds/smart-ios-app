//
//  HTMineCell.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMineCell.h"
#import "HTMineModel.h"
#import <UIButton+HTButtonCategory.h>

@interface HTMineCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTMineCell

- (void)didMoveToSuperview {
	self.separatorInset = UIEdgeInsetsMake(0, 25, 0, 0);
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	UIView *selectedBackgroundView = [[UIView alloc] init];
	selectedBackgroundView.backgroundColor = [UIColor ht_colorString:@"f2f2f2"];
	self.selectedBackgroundView = [[UIView alloc] init];
	[self.selectedBackgroundView addSubview:selectedBackgroundView];
	[selectedBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(25);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModel:(HTMineModel *)model row:(NSInteger)row {
	[self.titleNameButton setTitle:model.titleName forState:UIControlStateNormal];
	
	UIImage *image = [UIImage imageNamed:model.imageName];
	image = [image ht_resetSizeWithStandard:22 isMinStandard:false];
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	[self.titleNameButton setImage:image forState:UIControlStateNormal];
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:15];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:16];
		[_titleNameButton setTitleColor:[UIColor ht_colorString:@"484848"] forState:UIControlStateNormal];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
