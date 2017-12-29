//
//  HTSchoolHeaderView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolHeaderView.h"
#import <UIButton+HTButtonCategory.h>
#import "HTSchoolMatriculateSingleController.h"
#import "HTSchoolMatriculateContainerController.h"

@interface HTSchoolHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UIButton *matriculateButton;

@end

@implementation HTSchoolHeaderView

- (void)didMoveToSuperview {
	self.clipsToBounds = true;
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.headImageView];
	[self addSubview:self.matriculateButton];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	CGFloat line = 90;
	self.headImageView.layer.cornerRadius = line / 2;
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(30);
		make.width.height.mas_equalTo(line);
	}];
	[self.matriculateButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.bottom.mas_equalTo(- 20);
		make.width.mas_equalTo(160);
		make.height.mas_equalTo(35);
	}];
}

- (void)setModel:(HTSchoolModel *)model {
	[self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(model.duration)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	
	NSDictionary *dic = [model mj_keyValues];
	
	//********************************临时解决 把HTSchoolProfessionalSubModel 转换成 HTSchoolProfessionalModel 用********************************
	HTSchoolModel *newSchoolModel = [HTSchoolModel mj_objectWithKeyValues:dic];
	NSMutableArray *allMajors = [NSMutableArray array];
	
	NSArray <HTSchoolProfessionalModel *> *tempArray = [HTSchoolProfessionalModel mj_objectArrayWithKeyValuesArray:dic[@"major"]];
	
	[tempArray enumerateObjectsUsingBlock:^(HTSchoolProfessionalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[obj.content enumerateObjectsUsingBlock:^(HTSchoolProfessionalSubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			HTSchoolProfessionalModel *model = [HTSchoolProfessionalModel mj_objectWithKeyValues:[obj mj_keyValues]];
			[allMajors addObject:model];
		}];
	}];
	newSchoolModel.major = allMajors;
	
	//********************************临时解决 把HTSchoolProfessionalSubModel 转换成 HTSchoolProfessionalModel 用********************************
	
	
	__weak typeof(self) weakSelf = self;
	[self.matriculateButton ht_whenTap:^(UIView *view) {
//		HTSchoolMatriculateSingleController *singleController = [[HTSchoolMatriculateSingleController alloc] init];
		HTSchoolMatriculateContainerController *singleController =STORYBOARD_VIEWCONTROLLER(@"Home", @"HTSchoolMatriculateContainerController");
		
		singleController.evaluationSchool = newSchoolModel;
		[weakSelf.ht_controller.navigationController pushViewController:singleController animated:true];
	}];
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _backgroundImageView;
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.contentMode = UIViewContentModeScaleAspectFill;
		_headImageView.layer.masksToBounds = true;
	}
	return _headImageView;
}

- (UIButton *)matriculateButton {
	if (!_matriculateButton) {
		_matriculateButton = [[UIButton alloc] init];
		_matriculateButton.layer.cornerRadius = 3;
		_matriculateButton.layer.masksToBounds = true;
		_matriculateButton.backgroundColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_matriculateButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_matriculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_matriculateButton setTitle:@"学校录取测评" forState:UIControlStateNormal];
		UIImage *image = [UIImage imageNamed:@"cn_school_computer"];
		image = [image ht_resetSizeWithStandard:15 isMinStandard:false];
		[_matriculateButton setImage:image forState:UIControlStateNormal];
		[_matriculateButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:8];
	}
	return _matriculateButton;
}



@end
