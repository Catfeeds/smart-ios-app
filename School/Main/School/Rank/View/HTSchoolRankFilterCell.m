//
//  HTSchoolRankFilterCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankFilterCell.h"
#import "HTSchoolRankFilterModel.h"
#import <IQKeyboardManager.h>
#import "HTSchoolRankSelecetdManager.h"
#import <UIButton+HTButtonCategory.h>

@interface HTSchoolRankFilterCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UIButton *detailNameButton;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@end

@implementation HTSchoolRankFilterCell

- (void)didMoveToSuperview {
	
}

- (void)setModel:(HTSchoolRankFilterModel *)model row:(NSInteger)row {
	__weak typeof(self) weakSelf = self;
	switch (model.inputType) {
		case HTSchoolRankInputTypePicker:
		case HTSchoolRankInputTypeSelected: {
			self.titleNameButton.hidden = false;
			self.detailNameButton.hidden = self.accessoryImageView.hidden = false;
			break;
		}
	}
	if (!self.titleNameButton.hidden) {
		UIImage *image = [UIImage imageNamed:model.imageName];
		image = [image ht_resetSizeWithStandard:15 isMinStandard:false];
		image = [image ht_tintColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		[self.titleNameButton setImage:image forState:UIControlStateNormal];
		[self.titleNameButton setTitle:model.titleName forState:UIControlStateNormal];
		[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:10];
	}
	if (!self.detailNameButton.hidden) {
		[self reloadTitleNameButtonWithModel:model];
		[self.detailNameButton ht_whenTap:^(UIView *view) {
			[[IQKeyboardManager sharedManager] resignFirstResponder];
			[HTSchoolRankSelecetdManager pushSelectedManagerFromController:weakSelf.ht_controller filterModel:model completeSelectedBlock:^{
				[weakSelf reloadTitleNameButtonWithModel:model];
			}];
		}];
	}
	[self reloadLayoutHeightWithModel:model];
}

- (void)reloadLayoutHeightWithModel:(HTSchoolRankFilterModel *)model {
	
	[self addSubview:self.titleNameButton];
	[self addSubview:self.detailNameButton];
	[self addSubview:self.accessoryImageView];
	
	switch (model.inputType) {
		case HTSchoolRankInputTypePicker:
		case HTSchoolRankInputTypeSelected: {
			[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.centerY.mas_equalTo(self);
			}];
			[self.detailNameButton mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(- 15);
				make.centerY.mas_equalTo(self);
				make.width.mas_equalTo(250);
				make.height.mas_equalTo(40);
			}];
			[self.accessoryImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(self.detailNameButton).offset(- 10);
				make.centerY.mas_equalTo(self.detailNameButton);
			}];
			break;
		}
	}
}

- (void)reloadTitleNameButtonWithModel:(HTSchoolRankFilterModel *)model {
	NSString *selectedTitleName;
	if (model.selectedIndex >= 0 && model.selectedIndex < model.modelArray.count) {
		HTSchoolRankSelectedModel *selectedModel = model.modelArray[model.selectedIndex];
		selectedTitleName = selectedModel.name;
	}
	selectedTitleName = HTPlaceholderString(selectedTitleName, @"");
	[self.detailNameButton setTitle:selectedTitleName forState:UIControlStateNormal];
	if (self.reloadRankSelected) {
		self.reloadRankSelected();
	}
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
	}
	return _titleNameButton;
}

- (UIButton *)detailNameButton {
	if (!_detailNameButton) {
		_detailNameButton = [[UIButton alloc] init];
		[_detailNameButton setTitleColor:[UIColor ht_colorString:@"666666"] forState:UIControlStateNormal];
		_detailNameButton.titleLabel.font = [UIFont systemFontOfSize:15];
		_detailNameButton.layer.cornerRadius = 2;
		_detailNameButton.layer.masksToBounds = true;
		_detailNameButton.backgroundColor = [UIColor ht_colorString:@"f6f6f6"];
		_detailNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		_detailNameButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate].CGColor;
		_detailNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		_detailNameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
	}
	return _detailNameButton;
}

- (UIImageView *)accessoryImageView {
	if (!_accessoryImageView) {
		_accessoryImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn2_school_professional_section_header_triangle"];
		image = [image ht_resetSizeWithStandard:10 isMinStandard:false];
		_accessoryImageView.image = image;
		_accessoryImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
	}
	return _accessoryImageView;
}

@end
