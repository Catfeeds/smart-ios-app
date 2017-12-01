//
//  HTIndexSchoolCell.m
//  School
//
//  Created by hublot on 2017/8/8.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexSchoolCell.h"
#import "HTIndexModel.h"

@interface HTIndexSchoolCell ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTIndexSchoolCell

- (void)didMoveToSuperview {
	UIView *selectedBackgroundView = [[UIView alloc] init];
	selectedBackgroundView.backgroundColor = [UIColor clearColor];
	[self.selectedBackgroundView addSubview:selectedBackgroundView];
	[selectedBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.titleNameLabel];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
}

- (void)setModel:(HTIndexSchools *)model row:(NSInteger)row {
	model.image = [NSString stringWithFormat:@"cn_index_school_background_%ld", (row % 10) + 1];
	UIImage *image = [UIImage imageNamed:model.image];
	self.backgroundImageView.image = image;
	
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 10;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
									   NSForegroundColorAttributeName:[UIColor whiteColor],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:0.1],
										 NSForegroundColorAttributeName:[UIColor whiteColor],
										 NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"[ %@ ] \n", model.name] attributes:selectedDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:model.title attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.titleNameLabel.attributedText = attributedString;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
	}
	return _backgroundImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 2;
	}
	return _titleNameLabel;
}

@end
