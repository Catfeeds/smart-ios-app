//
//  HTMatriculateResultAnalysisFooterView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateResultAnalysisFooterView.h"
#import "HTRootNavigationController.h"
#import "HTSchoolMatriculateDetailController.h"
#import "HTChooseSchoolEvaluationController.h"

@interface HTMatriculateResultAnalysisFooterView ()

@property (nonatomic, strong) UIButton *rectImageButton;

@property (nonatomic, strong) UIView *rectContentView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIButton *repeatMatriculateButton;

@end

@implementation HTMatriculateResultAnalysisFooterView

- (void)didMoveToSuperview {
	self.clipsToBounds = true;
	[self addSubview:self.rectImageButton];
	[self.rectImageButton addSubview:self.rectContentView];
	[self.rectContentView addSubview:self.titleNameLabel];
	[self.rectContentView addSubview:self.repeatMatriculateButton];
	[self.rectImageButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
	[self.rectContentView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(1, 1, 1, 1));
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(15);
		make.left.right.mas_equalTo(self.rectContentView);
	}];
	[self.repeatMatriculateButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.rectContentView);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(15);
		make.width.mas_equalTo(self.rectContentView).offset(- 50);
		make.height.mas_equalTo(35);
	}];
}

- (void)setSchoolCount:(NSInteger)schoolCount {
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 15;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor],
										 NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *highlightDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:21 weight:0.2],
										  NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
										  NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"你的背景条件符合\n" attributes:selectedDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld+\n", schoolCount] attributes:highlightDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"所院校的申请水平" attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.titleNameLabel.attributedText = attributedString;
}

- (UIButton *)rectImageButton {
	if (!_rectImageButton) {
		_rectImageButton = [[UIButton alloc] init];
		UIImage *backgroundImage = [UIImage imageNamed:@"cn_matriculate_result_rect"];
		backgroundImage = [backgroundImage ht_tintColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
		[_rectImageButton setImage:backgroundImage forState:UIControlStateNormal];
	}
	return _rectImageButton;
}

- (UIView *)rectContentView {
	if (!_rectContentView) {
		_rectContentView = [[UIView alloc] init];
		_rectContentView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
	}
	return _rectContentView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}

- (UIButton *)repeatMatriculateButton {
	if (!_repeatMatriculateButton) {
		_repeatMatriculateButton = [[UIButton alloc] init];
		_repeatMatriculateButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_repeatMatriculateButton setTitle:@"重新评估" forState:UIControlStateNormal];
		_repeatMatriculateButton.layer.cornerRadius = 3;
		_repeatMatriculateButton.layer.masksToBounds = true;
		_repeatMatriculateButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStyleTintColor].CGColor;
		_repeatMatriculateButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		
		UIImage *normalImage = [UIImage ht_pureColor:[UIColor clearColor]];
		[_repeatMatriculateButton setBackgroundImage:normalImage forState:UIControlStateNormal];
		[_repeatMatriculateButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
		
		UIImage *highlightImage = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		[_repeatMatriculateButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
		[_repeatMatriculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		
		__weak typeof(self) weakSelf = self;
		[_repeatMatriculateButton ht_whenTap:^(UIView *view) {
			HTRootNavigationController *navigationController = (HTRootNavigationController *)weakSelf.ht_controller.rt_navigationController;
//			HTSchoolMatriculateDetailController *matriculateController = [[HTSchoolMatriculateDetailController alloc] init];
			
			HTChooseSchoolEvaluationController *matriculateController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseSchoolEvaluationController");
			
			UIViewController *willPopViewController = weakSelf.ht_controller;
			__weak typeof(navigationController) weakNavigationController = navigationController;
			[navigationController pushViewController:matriculateController animated:true complete:^(BOOL finished) {
				[weakNavigationController removeViewController:willPopViewController animated:false];
			}];
		}];
	}
	return _repeatMatriculateButton;
}

@end
