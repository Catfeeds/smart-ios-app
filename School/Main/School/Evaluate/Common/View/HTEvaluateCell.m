//
//  HTEvaluateCell.m
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTEvaluateCell.h"
#import "HTEvaluateModel.h"

@interface HTEvaluateCell ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTEvaluateCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = true;
	[self addSubview:self.backgroundImageView];
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.centerY.mas_equalTo(self);
		make.width.height.mas_equalTo(85);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.right.mas_equalTo(- 15);
		make.top.mas_equalTo(self.headImageView);
	}];
}

- (void)setModel:(HTEvaluateModel *)model row:(NSInteger)row {
	UIImage *backgroundImage = [UIImage imageNamed:model.backgroundImageName];
	self.backgroundImageView.image = backgroundImage;
	UIImage *headImage = [UIImage imageNamed:model.imageName];
	self.headImageView.image = headImage;
	
	NSDictionary *normalDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
										 NSForegroundColorAttributeName:[UIColor whiteColor]};
	NSDictionary *selectedDictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:20 weight:0.3],
										 NSForegroundColorAttributeName:[UIColor whiteColor]};
	NSMutableAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", model.titleName] attributes:selectedDictionary] mutableCopy];
	NSAttributedString *appendAttributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", model.detailName] attributes:normalDictionary];
	[attributedString appendAttributedString:appendAttributedString];
	self.titleNameLabel.attributedText = attributedString;
}

- (UIImageView *)backgroundImageView {
	if (!_backgroundImageView) {
		_backgroundImageView = [[UIImageView alloc] init];
		_backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _backgroundImageView;
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
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

- (void)setFrame:(CGRect)frame {
	frame.origin.y += 15;
	frame.origin.x += 15;
	frame.size.width -= 30;
	frame.size.height -= 15;
	[super setFrame:frame];
}

@end
