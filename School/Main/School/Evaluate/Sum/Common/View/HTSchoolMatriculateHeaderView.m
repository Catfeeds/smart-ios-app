//
//  HTSchoolMatriculateHeaderView.m
//  School
//
//  Created by hublot on 2017/7/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateHeaderView.h"
#import "HTSchoolMatriculateModel.h"
#import <UIButton+HTButtonCategory.h>

@interface HTSchoolMatriculateHeaderView ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) HTSchoolMatriculateSectionModel *model;

@end

@implementation HTSchoolMatriculateHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self addSubview:self.rightImageView];
	[self addGestureRecognizer:self.tapGesture];
	self.contentView.backgroundColor = [UIColor whiteColor];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
		make.left.mas_equalTo(20);
	}];
	[self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 20);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModelArray:(id)modelArray section:(NSInteger)section {
	if (![modelArray isKindOfClass:[HTSchoolMatriculateSectionModel class]]) {
		return;
	}
	HTSchoolMatriculateSectionModel *model = modelArray;
	_model = model;
	[self.titleNameButton setTitle:model.sectionTitleName forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:model.sectionImageName];
	image = [image ht_resetSizeWithStandard:17 isMinStandard:false];
	[self.titleNameButton setImage:image forState:UIControlStateNormal];
	
	[self.titleNameButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:7];
	[self reloadSectionImageAnimated:false];
}

- (void)reloadSectionImageAnimated:(BOOL)animated {
	CGAffineTransform transform;
	if (self.model.isSelected) {
		transform = CGAffineTransformIdentity;
	} else {
		transform = CGAffineTransformMakeRotation(M_PI_2);
	}
	[UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
		self.rightImageView.transform = transform;
	} completion:^(BOOL finished) {
		
	}];
}

- (void)tapHeaderView {
	if (self.didSelectedBlock) {
		self.didSelectedBlock();
	}
	[self reloadSectionImageAnimated:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.contentView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.contentView.backgroundColor = [UIColor whiteColor];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

- (UIImageView *)rightImageView {
	if (!_rightImageView) {
		_rightImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn2_school_professional_section_header_triangle"];
		image = [image ht_resetSize:CGSizeMake(10, 10)];
		_rightImageView.image = image;
	}
	return _rightImageView;
}


- (UITapGestureRecognizer *)tapGesture {
	if (!_tapGesture) {
		_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView)];
	}
	return _tapGesture;
}

@end
