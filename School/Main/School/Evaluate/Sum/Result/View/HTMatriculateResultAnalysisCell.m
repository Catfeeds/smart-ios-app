//
//  HTMatriculateResultAnalysisCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateResultAnalysisCell.h"
#import "HTMatriculateResultAnalysisModel.h"
#import <NSAttributedString+HTAttributedString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTMatriculateResultAnalysisCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTMatriculateResultAnalysisCell

+ (CGFloat)titleNameButtonWith {
	return 60;
}

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self addSubview:self.detailNameLabel];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(7.5);
		make.width.mas_equalTo([self.class titleNameButtonWith]);
		make.height.mas_equalTo(23);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleNameButton.mas_right).offset(15);
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModel:(HTMatriculateResultAnalysisModel *)model row:(NSInteger)row {
	self.titleNameButton.selected = (model.type.integerValue == 0);
	if (self.titleNameButton.selected) {
		self.titleNameButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStyleAnswerWrong].CGColor;
	} else {
		self.titleNameButton.layer.borderColor = [UIColor ht_colorStyle:HTColorStyleAnswerRight].CGColor;
	}
	[self createAttributedStringWithModel:model];
}

- (void)createAttributedStringWithModel:(HTMatriculateResultAnalysisModel *)model {
	UIColor *highlightColor = [UIColor colorWithCGColor:self.titleNameButton.layer.borderColor];
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13 weight:0.05],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]};
	NSDictionary *highlightDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
										  NSForegroundColorAttributeName:highlightColor};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ", model.name] attributes:selectedDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:model.score attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@", 打败了" attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:model.num attributes:highlightDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"位测评者" attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.detailNameLabel.attributedText = attributedString;
	
	CGFloat modelHeight = [self.detailNameLabel.attributedText ht_attributedStringHeightWithWidth:HTSCREENWIDTH - [self.class titleNameButtonWith] - 15 - 15- 15 textView:nil];
	modelHeight = MAX(modelHeight, 23);
	modelHeight += 15;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_titleNameButton setTitle:@"优势" forState:UIControlStateNormal];
		[_titleNameButton setTitle:@"优势" forState:UIControlStateNormal | UIControlStateHighlighted];
		[_titleNameButton setTitle:@"劣势" forState:UIControlStateSelected];
		[_titleNameButton setTitle:@"劣势" forState:UIControlStateSelected | UIControlStateHighlighted];
		_titleNameButton.layer.cornerRadius = 3;
		_titleNameButton.layer.masksToBounds = true;
		_titleNameButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
		
		UIImage *normalImage = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleAnswerRight]];
		UIImage *selectedImage = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleAnswerWrong]];
		
		[_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor clearColor]] forState:UIControlStateNormal];
		[_titleNameButton setBackgroundImage:normalImage forState:UIControlStateNormal | UIControlStateHighlighted];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleAnswerRight] forState:UIControlStateNormal];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal | UIControlStateHighlighted];
		
		[_titleNameButton setBackgroundImage:[UIImage ht_pureColor:[UIColor clearColor]] forState:UIControlStateSelected];
		[_titleNameButton setBackgroundImage:selectedImage forState:UIControlStateSelected | UIControlStateHighlighted];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleAnswerWrong] forState:UIControlStateSelected];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected | UIControlStateHighlighted];
	}
	return _titleNameButton;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.numberOfLines = 0;
	}
	return _detailNameLabel;
}

@end
