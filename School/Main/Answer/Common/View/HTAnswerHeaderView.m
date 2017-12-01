//
//  HTAnswerHeaderView.m
//  School
//
//  Created by hublot on 2017/9/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerHeaderView.h"
#import "HTAnswerIssueController.h"
#import "HTSearchController.h"
#import <UIButton+HTButtonCategory.h>

@interface HTAnswerHeaderView ()

@property (nonatomic, strong) UIButton *backgroundButton;

@property (nonatomic, strong) UILabel *searchTitleLabel;

@property (nonatomic, strong) UIButton *rightIssueButton;

@end

@implementation HTAnswerHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundButton];
	[self addSubview:self.searchTitleLabel];
	[self addSubview:self.rightIssueButton];
	[self.backgroundButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.rightIssueButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 10);
		make.top.mas_equalTo(30);
		make.width.mas_equalTo(60);
	}];
	[self.searchTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.rightIssueButton.mas_left).offset(- 15);
		make.left.mas_equalTo(15);
		make.height.mas_equalTo(30);
		make.centerY.mas_equalTo(self.rightIssueButton);
	}];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.searchTitleLabel.layer.cornerRadius = self.searchTitleLabel.bounds.size.height / 2;
	self.searchTitleLabel.layer.masksToBounds = true;
}

- (UIButton *)backgroundButton {
	if (!_backgroundButton) {
		_backgroundButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_answer_background"];
		[_backgroundButton setBackgroundImage:image forState:UIControlStateNormal];
		_backgroundButton.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _backgroundButton;
}

- (UILabel *)searchTitleLabel {
	if (!_searchTitleLabel) {
		_searchTitleLabel = [[UILabel alloc] init];
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] init] mutableCopy];
		NSAttributedString *appendAttributedString;
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		UIImage *searchImage = [UIImage imageNamed:@"cn2_index_search_zoom"];
		searchImage = [searchImage ht_resetSizeZoomNumber:0.5];
		searchImage = [searchImage ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 15, 0, 5)];
		searchImage = [searchImage ht_tintColor:[UIColor whiteColor]];
		textAttachment.image = searchImage;
		textAttachment.bounds = CGRectMake(0, - 1.5, searchImage.size.width, searchImage.size.height);
		
		appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
		[attributedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:@"搜索你关心的问题"
																 attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
																			  NSFontAttributeName:[UIFont systemFontOfSize:15]}];
		[attributedString appendAttributedString:appendAttributedString];
		_searchTitleLabel.attributedText = attributedString;
		_searchTitleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
		[_searchTitleLabel ht_whenTap:^(UIView *view) {
			[HTSearchController presentSearchControllerAnimated:true defaultSelectedType:HTSearchTypeAnswer];
		}];
	}
	return _searchTitleLabel;
}

- (UIButton *)rightIssueButton {
	if (!_rightIssueButton) {
		_rightIssueButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_answer_create_new_answer"];
		image = [image ht_tintColor:[UIColor whiteColor]];
		image = [image ht_resetSizeZoomNumber:0.5];
		image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		[_rightIssueButton setImage:image forState:UIControlStateNormal];
		_rightIssueButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_rightIssueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_rightIssueButton setTitle:@"提问" forState:UIControlStateNormal];
		[_rightIssueButton ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:5];
		
		__weak typeof(self) weakSelf = self;
		[_rightIssueButton ht_whenTap:^(UIView *view) {
			HTAnswerIssueController *issueController = [[HTAnswerIssueController alloc] init];
			[weakSelf.ht_controller.navigationController pushViewController:issueController animated:true];
		}];
	}
	return _rightIssueButton;
}

@end
