//
//  HTSchoolMatriculateResultHeaderView.m
//  School
//
//  Created by hublot on 2017/6/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateResultHeaderView.h"
#import "HTUserManager.h"

@interface HTSchoolMatriculateResultHeaderView ()

@property (nonatomic, strong) UIButton *backgroundContentButton;

@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UIButton *scoreNumberButton;

@property (nonatomic, strong) UILabel *detailNameLabel;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTSchoolMatriculateResultHeaderView

- (void)didMoveToSuperview {
	[self addSubview:self.backgroundContentButton];
	[self.backgroundContentButton addSubview:self.nicknameLabel];
	[self.backgroundContentButton addSubview:self.scoreNumberButton];
	[self.backgroundContentButton addSubview:self.detailNameLabel];
	[self.backgroundContentButton addSubview:self.leftImageView];
	[self.backgroundContentButton addSubview:self.titleNameLabel];
	[self.backgroundContentButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
	}];
	[self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(55);
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
	}];
	[self.scoreNumberButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.nicknameLabel.mas_bottom).offset(15);
		make.centerX.mas_equalTo(self.backgroundContentButton);
		make.width.height.mas_equalTo(70);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.scoreNumberButton.mas_bottom).offset(15);
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(- 15);
	}];
	[self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.detailNameLabel.mas_bottom).offset(15);
		make.left.mas_equalTo(15);
		make.width.height.mas_equalTo(50);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(self.leftImageView);
		make.left.mas_equalTo(self.leftImageView.mas_right).offset(15);
		make.right.mas_equalTo(- 15);
	}];
}

- (void)setModel:(NSString *)model {
	[self.scoreNumberButton setTitle:model forState:UIControlStateNormal];
}

- (UIButton *)backgroundContentButton {
	if (!_backgroundContentButton) {
		_backgroundContentButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_matriculate_result_board"];
		[_backgroundContentButton setBackgroundImage:image forState:UIControlStateNormal];
	}
	return _backgroundContentButton;
}

- (UILabel *)nicknameLabel {
	if (!_nicknameLabel) {
		_nicknameLabel = [[UILabel alloc] init];
		HTUser *user = [HTUserManager currentUser];
		NSString *nickname = HTPlaceholderString(user.nickname, user.userName);
		NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.alignment = NSTextAlignmentCenter;
		NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
										   NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
										   NSParagraphStyleAttributeName:paragraphStyle};
		NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
											 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleTintColor],
											 NSParagraphStyleAttributeName:paragraphStyle};
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:nickname attributes:selectedDictionary] mutableCopy];
		NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:@", 你的得分" attributes:normalDictionary];
		[attributedString appendAttributedString:appendAttributedString];
		_nicknameLabel.attributedText = attributedString;
	}
	return _nicknameLabel;
}

- (UIButton *)scoreNumberButton {
	if (!_scoreNumberButton) {
		_scoreNumberButton = [[UIButton alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_matriculate_result_score_circel"];
		[_scoreNumberButton setBackgroundImage:image forState:UIControlStateNormal];
		_scoreNumberButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.1];
		[_scoreNumberButton setTitleColor:[UIColor ht_colorStyle:HTColorStyleTintColor] forState:UIControlStateNormal];
	}
	return _scoreNumberButton;
}

- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:15];
		_detailNameLabel.textAlignment = NSTextAlignmentCenter;
		_detailNameLabel.text = @"以下是你的智能选校报告";
	}
	return _detailNameLabel;
}

- (UIImageView *)leftImageView {
	if (!_leftImageView) {
		_leftImageView = [[UIImageView alloc] init];
		_leftImageView.contentMode = UIViewContentModeScaleAspectFill;
		_leftImageView.clipsToBounds = true;
		UIImage *leftImage = [UIImage imageNamed:@"cn_school_result_ speaker"];
		_leftImageView.image = leftImage;
	}
	return _leftImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.numberOfLines = 0;
		UIImage *pointImage = [UIImage ht_pureColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		CGFloat pointWidth = 6;
		pointImage = [pointImage ht_resetSize:CGSizeMake(pointWidth, pointWidth)];
		pointImage = [pointImage ht_imageByRoundCornerRadius:pointWidth / 2 corners:UIRectCornerAllCorners borderWidth:0 borderColor:nil borderLineJoin:kCGLineJoinRound];
		
		UIImage *backgroundImage = [UIImage ht_pureColor:[UIColor clearColor]];
		CGFloat appendBackgroundWidth = 10;
		backgroundImage = [backgroundImage ht_resetSize:CGSizeMake(pointImage.size.width + appendBackgroundWidth, pointImage.size.height)];
		backgroundImage = [backgroundImage ht_appendImage:pointImage atRect:CGRectMake(0, 0, pointImage.size.width, pointImage.size.height)];
		
		NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
		textAttachment.image = backgroundImage;
		textAttachment.bounds = CGRectMake(0, 2, backgroundImage.size.width, backgroundImage.size.height);
		
		NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:@""] mutableCopy];
		NSArray *titleNameArray = @[@"此报告未考虑文书质量与面试质量\n", @"用户需填写实际情况, 保证结果的准确性\n", @"此报告匹配标准以近 5 年留学录取成果大数据作为技术支撑, 并不能百分百代表实际录取结果, 仅供参考"];
		[titleNameArray enumerateObjectsUsingBlock:^(NSString *titleName, NSUInteger index, BOOL * _Nonnull stop) {
			NSAttributedString *appendAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
			[attributedString appendAttributedString:appendAttributedString];
			appendAttributedString = [[NSAttributedString alloc] initWithString:titleName];
			[attributedString appendAttributedString:appendAttributedString];
		}];
		NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
		paragraphStyle.lineSpacing = 10;
		[attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
										  NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSpecialTitle],
										  NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
		_titleNameLabel.attributedText = attributedString;
	}
	return _titleNameLabel;
}

@end
