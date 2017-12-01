//
//  HTSchoolRankCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankCell.h"
#import "HTSchoolRankModel.h"

@interface HTSchoolRankCell ()

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTSchoolRankCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.mas_left).offset(40);
		make.centerY.mas_equalTo(self);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleNameButton.mas_right).offset(15);
		make.centerY.mas_equalTo(self);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self);
		make.left.mas_greaterThanOrEqualTo(self.titleNameLabel.mas_right).offset(15);
	}];
}

- (void)setModel:(HTSchoolRankModel *)model row:(NSInteger)row {
	[self didMoveToSuperview];
	[self createTitleButtonImageWithModel:model];
	[self createTitlteNameLabelAttributedStringWithModel:model];
	[self createDetailNameLabelAttributedStringWithModel:model];
}

- (void)createTitleButtonImageWithModel:(HTSchoolRankModel *)model {
	[self.titleNameButton setTitleColor:model.titleColor forState:UIControlStateNormal];
	[self.titleNameButton setTitle:model.article forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:model.imageName];
	[self.titleNameButton setBackgroundImage:image forState:UIControlStateNormal];
	self.titleNameButton.titleEdgeInsets = model.titleEdgeInsets;
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(model.imageSize);
	}];
}

- (void)createTitlteNameLabelAttributedStringWithModel:(HTSchoolRankModel *)model {
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 10;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.name attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", model.title] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.titleNameLabel.attributedText = attributedString;
}

- (void)createDetailNameLabelAttributedStringWithModel:(HTSchoolRankModel *)model {
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 10;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor],
										 NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"查看人数: " attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:model.viewCount attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"\n评论: " attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:model.answer attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.detailNameLabel.attributedText = attributedString;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:0.3];
	}
	return _titleNameButton;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 2;
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.numberOfLines = 2;
		[_detailNameLabel setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
		[_detailNameLabel setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _detailNameLabel;
}


@end
