//
//  HTProfessionalHeaderView.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalHeaderView.h"

@interface HTProfessionalHeaderView()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *darkBackgroundView;

@property (nonatomic, retain) UILabel *titleNameLabel;

@end

@implementation HTProfessionalHeaderView

- (void)didMoveToSuperview {
	self.clipsToBounds = true;
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.darkBackgroundView];
	[self addSubview:self.titleNameLabel];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.darkBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.center.mas_equalTo(self);
	}];
}

- (void)setModel:(HTProfessionalModel *)model {
	HTProfessionalSchoolModel *schoolModel = model.school.firstObject;
	HTProfessionalDetailModel *detailModel = model.data.firstObject;
	[self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(schoolModel.duration)] placeholderImage:HTPLACEHOLDERIMAGE];
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 15;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", detailModel.name, detailModel.title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor], NSParagraphStyleAttributeName:paragraphStyle}] mutableCopy];
	self.titleNameLabel.attributedText = attributedString;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _backgroundImageView;
}

- (UIView *)darkBackgroundView {
	if (!_darkBackgroundView) {
		_darkBackgroundView = [[UIView alloc] init];
		_darkBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
	}
	return _darkBackgroundView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}

@end
