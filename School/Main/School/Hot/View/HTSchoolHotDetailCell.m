//
//  HTSchoolHotDetailCell.m
//  School
//
//  Created by hublot on 2017/6/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolHotDetailCell.h"
#import "HTSchoolHotModel.h"

@interface HTSchoolHotDetailCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTSchoolHotDetailCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
		make.left.mas_equalTo(15);
		make.width.height.mas_equalTo(80);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModel:(HTSchoolHotModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SchoolResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self createTitleAttributedStringWithModel:model];
}

- (void)createTitleAttributedStringWithModel:(HTSchoolHotModel *)model {
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = 10;
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
									   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
									   NSParagraphStyleAttributeName:paragraphStyle};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
										 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
										 NSParagraphStyleAttributeName:paragraphStyle};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.name attributes:normalDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", model.title] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n所在地区: %@", model.alternatives] attributes:selectedDictionary];
	[attributedString appendAttributedString:appendAttributedString];
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
