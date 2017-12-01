//
//  HTSchoolCell.m
//  School
//
//  Created by hublot on 2017/7/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolCell.h"
#import "HTSchoolModel.h"

@interface HTSchoolCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation HTSchoolCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(20);
		make.centerY.mas_equalTo(self);
		make.width.height.mas_equalTo(100);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
		make.left.mas_equalTo(self.headImageView.mas_right).offset(20);
		make.right.mas_equalTo(self).offset(- 15);
	}];
}

- (void)setModel:(HTSchoolModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self createTitleAttributedStringWithModel:model];
}

- (void)createTitleAttributedStringWithModel:(HTSchoolModel *)model {
	UIFont *normalFont = [UIFont systemFontOfSize:16];
	
	NSDictionary *normalDictionary = @{NSFontAttributeName:normalFont,
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSpecialTitle]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", model.name] attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", model.title] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	
	UIImage *image = [UIImage imageNamed:@"cn2_school_professional_header_address"];
	image = [image ht_resetSize:CGSizeMake(normalFont.pointSize - 3, normalFont.pointSize - 3)];
	image = [image ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 0, 0, 6)];
	
	NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
	textAttachment.image = image;
	textAttachment.bounds = CGRectMake(0, - 2, image.size.width, image.size.height);
	appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"所在地区: %@", model.answer] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.paragraphSpacing = 20;
	[attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
	
	self.titleNameLabel.attributedText = attributedString;
	
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
		_titleNameLabel.numberOfLines = 0;
	}
	return _titleNameLabel;
}

@end
