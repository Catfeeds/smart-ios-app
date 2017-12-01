//
//  HTSearchTitleView.m
//  School
//
//  Created by hublot on 2017/7/25.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchTitleView.h"

@interface HTSearchTitleView ()

@property (nonatomic, strong) UIButton *logoImageButton;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTSearchTitleView

- (void)didMoveToSuperview {
	[self addSubview:self.logoImageButton];
	[self addSubview:self.titleNameLabel];
	self.titleNameLabel.backgroundColor = [UIColor whiteColor];
	[self.logoImageButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self);
		make.left.mas_equalTo(self).offset(10);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.logoImageButton.mas_right).offset(10 + 7);
		make.right.mas_equalTo( - 5);
		make.top.bottom.mas_equalTo(self);
	}];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.titleNameLabel.layer.cornerRadius = self.titleNameLabel.bounds.size.height / 2;
	self.titleNameLabel.layer.masksToBounds = true;
}

- (UIButton *)logoImageButton {
    if (!_logoImageButton) {
        _logoImageButton = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"cn_index_left_logo"];
        CGFloat scale = 28 / image.size.height;
        image = [image ht_resetSizeZoomNumber:scale];
        UIImage *normalImage = image;
        [_logoImageButton setImage:normalImage forState:UIControlStateNormal];
//        [_logoImageButton setImage:highlightImage forState:UIControlStateHighlighted];
        [_logoImageButton setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        [_logoImageButton setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
        [_logoImageButton ht_whenTap:^(UIView *view) {
            
        }];
    }
    return _logoImageButton;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] init] mutableCopy];
		NSAttributedString *appendAttributedString;
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		UIImage *searchImage = [UIImage imageNamed:@"cn2_index_search_zoom"];
		searchImage = [searchImage ht_resetSizeZoomNumber:0.5];
		searchImage = [searchImage ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 15, 0, 5)];
		searchImage = [searchImage ht_tintColor:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle]];
		textAttachment.image = searchImage;
		textAttachment.bounds = CGRectMake(0, - 1.5, searchImage.size.width, searchImage.size.height);
		
		appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
		[attributedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:@"搜索感兴趣的内容"
																 attributes:@{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle],
																			  NSFontAttributeName:[UIFont systemFontOfSize:15]}];
		[attributedString appendAttributedString:appendAttributedString];
		_titleNameLabel.attributedText = attributedString;
	}
	return _titleNameLabel;
}

@end
