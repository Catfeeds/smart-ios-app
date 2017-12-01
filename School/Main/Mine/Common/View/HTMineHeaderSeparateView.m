//
//  HTMineHeaderSeparateView.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMineHeaderSeparateView.h"
#import <UIButton+HTButtonCategory.h>
#import "HTUserManager.h"
#import "HTStoreController.h"
#import "HTAnswerRecordController.h"
#import "HTSolutionRecordController.h"

@interface HTMineHeaderSeparateView ()

@property (nonatomic, strong) UIButton *questionCountButton;

@property (nonatomic, strong) UIView *firstLineView;

@property (nonatomic, strong) UIButton *answerCountButton;

@property (nonatomic, strong) UIView *secondLineView;

@property (nonatomic, strong) UIButton *storyCountButton;

@end

@implementation HTMineHeaderSeparateView

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
	[self addSubview:self.questionCountButton];
	[self addSubview:self.firstLineView];
	[self addSubview:self.answerCountButton];
	[self addSubview:self.secondLineView];
	[self addSubview:self.storyCountButton];
	[self.questionCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(1 / 3.0);
		make.centerY.mas_equalTo(self);
	}];
	[self.firstLineView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(1 / [UIScreen mainScreen].scale);
		make.top.mas_equalTo(10);
		make.bottom.mas_equalTo(- 10);
		make.left.mas_equalTo(self.questionCountButton.mas_right);
	}];
	[self.answerCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.firstLineView.mas_right);
		make.width.mas_equalTo(self).multipliedBy(1 / 3.0);
		make.centerY.mas_equalTo(self);
	}];
	[self.secondLineView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.height.mas_equalTo(self.firstLineView);
		make.left.mas_equalTo(self.answerCountButton.mas_right);
		make.top.mas_equalTo(10);
		make.bottom.mas_equalTo(- 10);
	}];
	[self.storyCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.secondLineView.mas_right);
		make.width.mas_equalTo(self).multipliedBy(1 / 3.0);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)updateModel {
	HTUser *user = [HTUserManager currentUser];
	NSString *titleNameKey = @"titleNameKey";
	NSString *numberNameKey = @"imageNameKey";
	NSString *buttonNameKey = @"buttonNameKey";
	
	NSArray *keyValueArray = @[
                               @{titleNameKey:@"我的提问", numberNameKey:[NSString stringWithFormat:@"%ld", user.questionNum.integerValue], buttonNameKey:self.questionCountButton},
							   @{titleNameKey:@"我的回答", numberNameKey:[NSString stringWithFormat:@"%ld", user.answerNum.integerValue], buttonNameKey:self.answerCountButton},
                               @{titleNameKey:@"我的收藏", numberNameKey:[NSString stringWithFormat:@"%ld", user.storeCount], buttonNameKey:self.storyCountButton},
							   ];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		[self appendButtonTitle:dictionary[titleNameKey] number:dictionary[numberNameKey] onButton:dictionary[buttonNameKey]];
	}];
    __weak typeof(self) weakSelf = self;
    [self.questionCountButton ht_whenTap:^(UIView *view) {
        HTAnswerRecordController *recordController = [[HTAnswerRecordController alloc] init];
        recordController.uidString = [NSString stringWithFormat:@"%ld", user.uid.integerValue];
        [weakSelf.ht_controller.navigationController pushViewController:recordController animated:true];
    }];
    [self.answerCountButton ht_whenTap:^(UIView *view) {
        HTSolutionRecordController *recordController = [[HTSolutionRecordController alloc] init];
        recordController.uidString = [NSString stringWithFormat:@"%ld", user.uid.integerValue];
        [weakSelf.ht_controller.navigationController pushViewController:recordController animated:true];
    }];
    [self.storyCountButton ht_whenTap:^(UIView *view) {
        HTStoreController *storeController = [[HTStoreController alloc] init];
        [weakSelf.ht_controller.navigationController pushViewController:storeController animated:true];
    }];
}

- (void)appendButtonTitle:(NSString *)title number:(NSString *)number onButton:(UIButton *)button {
	UIFont *font = [UIFont systemFontOfSize:14];
	NSDictionary *normalDictionary = @{NSFontAttributeName:font,
									   NSForegroundColorAttributeName:[UIColor whiteColor]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:font,
										 NSForegroundColorAttributeName:[UIColor ht_colorString:@"ebeb30"]};
	
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:title attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:number attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	[button setAttributedTitle:attributedString forState:UIControlStateNormal];
	
	[button ht_makeEdgeWithDirection:HTButtonEdgeDirectionVertical imageViewToTitleLabelSpeceOffset:10];
}

- (UIButton *)questionCountButton {
	if (!_questionCountButton) {
		NSString *imageName = @"cn_mine_header_question";
		_questionCountButton = [self createButtonWithImageName:imageName];
	}
	return _questionCountButton;
}

- (UIView *)firstLineView {
	if (!_firstLineView) {
		_firstLineView = [self createLineView];
	}
	return _firstLineView;
}


- (UIButton *)answerCountButton {
	if (!_answerCountButton) {
		NSString *imageName = @"cn_mine_header_answer";
		_answerCountButton = [self createButtonWithImageName:imageName];
	}
	return _answerCountButton;
}

- (UIView *)secondLineView {
	if (!_secondLineView) {
		_secondLineView = [self createLineView];
	}
	return _secondLineView;
}

- (UIButton *)storyCountButton {
	if (!_storyCountButton) {
		NSString *imageName = @"cn_mine_header_story";
		_storyCountButton = [self createButtonWithImageName:imageName];
	}
	return _storyCountButton;
}

- (UIButton *)createButtonWithImageName:(NSString *)imageName {
	UIButton *button = [[UIButton alloc] init];
	button.titleLabel.font = [UIFont systemFontOfSize:14];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:imageName];
	image = [image ht_resetSizeWithStandard:22 isMinStandard:false];
	[button setImage:image  forState:UIControlStateNormal];
	return button;
}

- (UIView *)createLineView {
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor whiteColor];
	return view;
}

@end
