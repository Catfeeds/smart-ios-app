//
//  HTOrganizationDetailCell.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationDetailCell.h"
#import "HTOrganizationModel.h"
#import <NSString+HTString.h>
#import "HTWebController.h"

@interface HTOrganizationDetailCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UILabel *visitCountLabel;

@end

@implementation HTOrganizationDetailCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self addSubview:self.visitCountLabel];
	
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.mas_equalTo(15);
		make.bottom.mas_equalTo(- 15);
		make.height.mas_equalTo(self.headImageView.mas_width).multipliedBy(3.0 / 3.0);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(- 15);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.centerY.mas_equalTo(self.headImageView);
	}];
	[self.visitCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.titleNameLabel);
		make.bottom.mas_equalTo(self.headImageView);
	}];
}

- (void)setModel:(HTOrganizationModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self createTitleAttributedStringWithModel:model];
	NSString *detailString = [model.Description ht_attributedStringNeedDispatcher:nil].string;
	self.detailNameLabel.text = detailString;
	[self createVisitCountAttributedStringWithModel:model];
}

- (void)createTitleAttributedStringWithModel:(HTOrganizationModel *)model {
	NSString *titleName = model.name;
	CGFloat star = 4.5;
	NSInteger fullStarCount = (NSInteger)star;
	NSInteger halfStarCount = star > fullStarCount ? 1 : 0;
	
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:titleName attributes:normalDictionary] mutableCopy];
	UIImage *lineImage = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStylePrimarySeparate]];
	lineImage = [lineImage ht_resetSize:CGSizeMake(1 / [UIScreen mainScreen].scale, 15)];
	lineImage = [lineImage ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 10, 0, 10)];
	NSAttributedString *appendAttributedString;
	
	void(^appendImageBlock)(UIImage *image, CGPoint origin) = ^(UIImage *image, CGPoint origin) {
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		textAttachment.image = image;
		textAttachment.bounds = CGRectMake(origin.x, origin.y, image.size.width, image.size.height);
		NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
		[attributedString appendAttributedString:appendAttributedString];
	};
	
	appendImageBlock(lineImage, CGPointMake(0, - 3));
	
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"好评度" attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	
	CGFloat scale = 0.5;
	UIEdgeInsets edge = UIEdgeInsetsMake(0, 3, 0, 0);
	CGPoint point = CGPointMake(0, 0);
	UIImage *fullStarImage = [UIImage imageNamed:@"cn_organization_star_full"];
	fullStarImage = [fullStarImage ht_resetSizeZoomNumber:scale];
	fullStarImage = [fullStarImage ht_insertColor:[UIColor clearColor] edge:edge];
	UIImage *halfStarImage = [UIImage imageNamed:@"cn_organization_star_half"];
	halfStarImage = [halfStarImage ht_resetSizeZoomNumber:scale];
	halfStarImage = [halfStarImage ht_insertColor:[UIColor clearColor] edge:edge];
	
	
	for (NSInteger index = 0; index < fullStarCount; index ++) {
		appendImageBlock(fullStarImage, point);
	}
	if (halfStarCount > 0) {
		appendImageBlock(halfStarImage, point);
	}
	self.titleNameLabel.attributedText = attributedString;
	
}

- (void)createVisitCountAttributedStringWithModel:(HTOrganizationModel *)model {
	NSInteger count = model.cnName.integerValue;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@"已有" attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", count] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:@"人咨询" attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.visitCountLabel.attributedText = attributedString;
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.contentMode = UIViewContentModeScaleAspectFill;
		_headImageView.clipsToBounds = true;
	}
	return _headImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:14];
		_detailNameLabel.numberOfLines = 2;
	}
	return _detailNameLabel;
}

- (UILabel *)visitCountLabel {
	if (!_visitCountLabel) {
		_visitCountLabel = [[UILabel alloc] init];
	}
	return _visitCountLabel;
}


@end
