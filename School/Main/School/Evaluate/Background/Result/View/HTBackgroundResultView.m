//
//  HTBackgroundResultView.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBackgroundResultView.h"
#import <UIButton+HTButtonCategory.h>

@interface HTBackgroundResultView ()

@property (nonatomic, strong) UIButton *keySuccessButon;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTBackgroundResultView

- (void)didMoveToSuperview {
	[self addSubview:self.keySuccessButon];
	[self addSubview:self.titleNameLabel];
	[self.keySuccessButon mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(50);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.keySuccessButon.mas_bottom).offset(50);
	}];
}

- (UIButton *)keySuccessButon {
	if (!_keySuccessButon) {
		_keySuccessButon = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_school_background_result_key"];
		image = [image ht_resetSizeZoomNumber:0.35];
		[_keySuccessButon setImage:image forState:UIControlStateNormal];
		UIFont *font = [UIFont systemFontOfSize:30 weight:1.4];
		_keySuccessButon.titleLabel.font = font;
		[_keySuccessButon setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		[_keySuccessButon setTitle:@"问卷提交成功" forState:UIControlStateNormal];
		[_keySuccessButon ht_makeEdgeWithDirection:HTButtonEdgeDirectionHorizontal imageViewToTitleLabelSpeceOffset:10];
	}
	return _keySuccessButon;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		NSMutableParagraphStyle *aligmnParagrphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		aligmnParagrphStyle.alignment = NSTextAlignmentCenter;
		NSMutableParagraphStyle *topParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		topParagraphStyle.paragraphSpacingBefore = 50;
		topParagraphStyle.alignment = NSTextAlignmentCenter;
		NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:25 weight:0.4],
										   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
										   NSParagraphStyleAttributeName:aligmnParagrphStyle};
		NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:27 weight:0.4],
											 NSForegroundColorAttributeName:[UIColor ht_colorString:@"2ef36b"],
											 NSParagraphStyleAttributeName:aligmnParagrphStyle};
		NSDictionary *detailDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:16 weight:0.05],
										   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
										   NSParagraphStyleAttributeName:topParagraphStyle};
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"已有" attributes:normalDictionary] mutableCopy];
		NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:@"1000+" attributes:selectedDictionary];
		[attributedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:@"位同学得到了帮助\n" attributes:normalDictionary];
		[attributedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:@"亲爱的同学, 雷哥网已为你安排了资深顾问. 1 个工作日内与你取得联系, 解决你申请问题 !" attributes:detailDictionary];
		[attributedString appendAttributedString:appendAttributedString];
		_titleNameLabel.attributedText = attributedString;
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}

- (CGSize)intrinsicContentSize {
	CGSize intrinsicContentSize = CGSizeZero;
	intrinsicContentSize.width = HTSCREENWIDTH;
	intrinsicContentSize.height = self.keySuccessButon.intrinsicContentSize.height + self.titleNameLabel.intrinsicContentSize.height + 200;
	return intrinsicContentSize;
}

@end
