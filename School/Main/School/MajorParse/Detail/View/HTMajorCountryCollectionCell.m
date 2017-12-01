//
//  HTMajorCountryCollectionCell.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorCountryCollectionCell.h"
#import "HTMajorDetailModel.h"

@implementation HTMajorCountryCollectionCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameButton];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(HTMajorSchoolModel *)model row:(NSInteger)row {
	NSDictionary *dictionary = @{NSFontAttributeName:self.titleNameButton.titleLabel.font,
								 NSForegroundColorAttributeName:[self.titleNameButton titleColorForState:UIControlStateNormal]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:model.titleName attributes:dictionary] mutableCopy];
	if (model.isHotSchool) {
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_major_hot"];
		image = [image ht_resetSizeZoomNumber:0.8];
		textAttachment.image = image;
		textAttachment.bounds = CGRectMake(0, - 3, image.size.width, image.size.height);
		NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
		[attributedString appendAttributedString:appendAttributedString];
	}
	[self.titleNameButton setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[_titleNameButton setTitleColor:[UIColor ht_colorStyle:HTColorStylePrimaryTitle] forState:UIControlStateNormal];
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
