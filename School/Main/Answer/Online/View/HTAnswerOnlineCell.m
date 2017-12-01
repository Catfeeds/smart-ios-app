//
//  HTAnswerOnlineCell.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerOnlineCell.h"
#import <UIView+WebCache.h>

@interface HTAnswerOnlineCell ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UIButton *interRoomButton;

@end

@implementation HTAnswerOnlineCell

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self addSubview:self.interRoomButton];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(30);
		make.centerX.mas_equalTo(self);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom).offset(30);
		make.centerX.mas_equalTo(self);
	}];
	[self.interRoomButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(30);
		make.centerX.mas_equalTo(self);
		make.width.mas_equalTo(130);
		make.height.mas_equalTo(35);
	}];
}

- (void)setModel:(id)model row:(NSInteger)row {
	[self createBackgroundImageWithModel:model];
	self.titleNameLabel.text = @"申请美国研究生是考 GRE 还是 GMAT";
	[self createDetailAttributedStringWithModel:model];
}

- (void)createBackgroundImageWithModel:(id)model {
	__weak typeof(self) weakSelf = self;
	[self.backgroundImageView sd_internalSetImageWithURL:[NSURL URLWithString:SchoolResourse(@"")] placeholderImage:HTPLACEHOLDERIMAGE options:kNilOptions operationKey:nil setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData) {
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			UIImage *scaleImage = [image ht_applyDarkEffect];
			
			UIImage *normalImage = scaleImage;
			UIImage *darkImage = [UIImage ht_pureColor:[UIColor colorWithWhite:0 alpha:0.1]];
			darkImage = [darkImage ht_resetSize:scaleImage.size];
			normalImage = [scaleImage ht_appendImage:darkImage atRect:CGRectMake(0, 0, darkImage.size.width, darkImage.size.height)];
			
			UIImage *hilightImage = scaleImage;
			
			
			dispatch_async(dispatch_get_main_queue(), ^{
				weakSelf.backgroundImageView.image = normalImage;
				weakSelf.backgroundImageView.highlightedImage = hilightImage;
			});
		});
	} progress:nil completed:nil];
}

- (void)createDetailAttributedStringWithModel:(id)model {
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@""] mutableCopy];
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSArray *keyValueArray = @[
							 	@{titleNameKey:@"时间: 2017.6.29", imageNameKey:@"cn_answer_online_clock"},
								@{titleNameKey:@"价格: 100元", imageNameKey:@"cn_answer_online_price"},
								@{titleNameKey:@"限时: 60min", imageNameKey:@"cn_answer_online_duration"},
							 ];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		UIImage *image = [UIImage imageNamed:dictionary[imageNameKey]];
		image = [image ht_resetSizeZoomNumber:0.5];
		image = [image ht_insertColor:[UIColor clearColor] edge:UIEdgeInsetsMake(0, 0, 0, 5)];
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		textAttachment.image = image;
		textAttachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
		NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
		[attributedString appendAttributedString:appendAttributedString];
		appendAttributedString = [[NSAttributedString alloc] initWithString:dictionary[titleNameKey]];
		[attributedString appendAttributedString:appendAttributedString];
	}];
	[attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],
									  NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, attributedString.length)];
	self.detailNameLabel.attributedText = attributedString;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	self.backgroundImageView.highlighted = highlighted;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		_backgroundImageView.layer.masksToBounds = true;
	}
	return _backgroundImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor whiteColor];
		_titleNameLabel.font = [UIFont systemFontOfSize:16];
	}
	return _titleNameLabel;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
	}
	return _detailNameLabel;
}

- (UIButton *)interRoomButton {
	if (!_interRoomButton) {
		_interRoomButton = [[UIButton alloc] init];
		_interRoomButton.titleLabel.font = [UIFont systemFontOfSize:15];
		[_interRoomButton setTitle:@"进入直播间" forState:UIControlStateNormal];
		[_interRoomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		UIColor *normalColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		UIColor *highlightColor = [normalColor colorWithAlphaComponent:0.5];
		[_interRoomButton setBackgroundImage:[UIImage ht_pureColor:normalColor] forState:UIControlStateNormal];
		[_interRoomButton setBackgroundImage:[UIImage ht_pureColor:highlightColor] forState:UIControlStateHighlighted];
		_interRoomButton.layer.cornerRadius = 3;
		_interRoomButton.layer.masksToBounds = true;
	}
	return _interRoomButton;
}

- (void)setFrame:(CGRect)frame {
	frame.origin.y += 10;
	frame.size.height -= 10;
	[super setFrame:frame];
}

@end
