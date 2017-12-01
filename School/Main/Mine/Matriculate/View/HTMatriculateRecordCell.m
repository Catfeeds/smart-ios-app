//
//  HTMatriculateRecordCell.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateRecordCell.h"
#import "HTMatriculateRecordTypeModel.h"
#import <NSObject+HTTableRowHeight.h>

@interface HTMatriculateRecordCell ()

@property (nonatomic, strong) UIImageView *whiteContentView;

@property (nonatomic, strong) UIButton *titleNameButton;

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTMatriculateRecordCell

- (void)didMoveToSuperview {
	UIView *selectedBackgroundView = [[UIView alloc] init];
	selectedBackgroundView.backgroundColor = [UIColor clearColor];
	self.selectedBackgroundView = selectedBackgroundView;
	
	
	self.backgroundColor = [UIColor clearColor];
	[self addSubview:self.whiteContentView];
	[self.whiteContentView addSubview:self.titleNameButton];
	[self.whiteContentView addSubview:self.titleNameLabel];
	[self.whiteContentView addSubview:self.lookDetailButton];
	[self.whiteContentView addSubview:self.matriculateButton];
	[self.whiteContentView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 0, 15));
	}];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(40);
		make.top.mas_equalTo(self.whiteContentView).offset(20);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.titleNameButton);
		make.bottom.mas_equalTo(self.whiteContentView).offset(- 20);
	}];
	[self.lookDetailButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(90);
		make.height.mas_equalTo(28);
		make.right.mas_equalTo(- 30);
	}];
	[self.matriculateButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.height.right.mas_equalTo(self.lookDetailButton);
	}];
}

- (void)setModel:(HTMatriculateRecordTypeModel *)model row:(NSInteger)row {
	[self didMoveToSuperview];
	UIImage *image = [UIImage imageNamed:model.imageName];
	image = [image ht_resetSizeZoomNumber:0.5];
	[self.titleNameButton setImage:image forState:UIControlStateNormal];
	self.titleNameLabel.text = model.titleName;
	
	if (model.showDetail) {
		self.lookDetailButton.hidden = false;
		[self.lookDetailButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(33);
		}];
		[self.matriculateButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(- 33);
		}];
	} else {
		self.lookDetailButton.hidden = true;
		[self.matriculateButton mas_updateConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(self.whiteContentView);
		}];
	}
	
	CGFloat modelHeight = 160;
	[model ht_setRowHeightNumber:@(modelHeight) forCellClass:self.class];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat contentCornerRadius = 5;
	UIImage *whiteContentImage = [UIImage ht_pureColor:[UIColor whiteColor]];
	whiteContentImage = [whiteContentImage ht_resetSize:self.whiteContentView.bounds.size];
	whiteContentImage = [whiteContentImage ht_imageByRoundCornerRadius:contentCornerRadius corners:UIRectCornerAllCorners borderWidth:0 borderColor:nil borderLineJoin:kCGLineJoinRound];
	UIImage *whilteHighlightImage = [whiteContentImage ht_tintColor:[UIColor ht_colorString:@"f0f0f0"]];
	self.whiteContentView.image = whiteContentImage;
	self.whiteContentView.highlightedImage = whilteHighlightImage;
	
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	self.whiteContentView.highlighted = highlighted;
}

- (UIImageView *)whiteContentView {
	if (!_whiteContentView) {
		_whiteContentView = [[UIImageView alloc] init];
		_whiteContentView.userInteractionEnabled = true;
		_whiteContentView.layer.shadowColor = [UIColor blackColor].CGColor;
		_whiteContentView.layer.shadowOpacity = 0.1;
		_whiteContentView.layer.shadowOffset = CGSizeMake(3, 3);
		_whiteContentView.layer.shadowRadius = 3;
	}
	return _whiteContentView;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
	}
	return _titleNameButton;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameLabel;
}


- (UIButton *)lookDetailButton {
	if (!_lookDetailButton) {
		_lookDetailButton = [self.class createCircelButtonNormalBackgroundColor:[UIColor whiteColor] highlightBackgroundColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
		[_lookDetailButton setTitle:@"查看详情" forState:UIControlStateNormal];
	}
	return _lookDetailButton;
}

- (UIButton *)matriculateButton {
	if (!_matriculateButton) {
		_matriculateButton = [self.class createCircelButtonNormalBackgroundColor:[UIColor ht_colorStyle:HTColorStyleTintColor] highlightBackgroundColor:[UIColor whiteColor]];
		[_matriculateButton setTitle:@"参加测评" forState:UIControlStateNormal];
	}
	return _matriculateButton;
}

+ (UIButton *)createCircelButtonNormalBackgroundColor:(UIColor *)normalBackgroundColor highlightBackgroundColor:(UIColor *)highlightBackgroundColor {
	UIButton *button = [[UIButton alloc] init];
	button.titleLabel.font = [UIFont systemFontOfSize:14];
	CGFloat cornerRadius = 3;
	CGFloat borderWidth = 1 / [UIScreen mainScreen].scale;
	CGSize size = CGSizeMake(90, 28);
	UIColor *borderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	
	UIColor *normalForegroundColor = highlightBackgroundColor;
	UIImage *normalBackgroundImage = [UIImage ht_pureColor:normalBackgroundColor];
	normalBackgroundImage = [normalBackgroundImage ht_resetSize:size];
	normalBackgroundImage = [normalBackgroundImage ht_imageByRoundCornerRadius:cornerRadius corners:UIRectCornerAllCorners borderWidth:borderWidth borderColor:borderColor borderLineJoin:kCGLineJoinRound];
	
	UIColor *highlightForegroundColor = normalBackgroundColor;
	UIImage *highlightBackgroundImage = [UIImage ht_pureColor:highlightBackgroundColor];
	highlightBackgroundImage = [highlightBackgroundImage ht_resetSize:size];
	highlightBackgroundImage = [highlightBackgroundImage ht_imageByRoundCornerRadius:cornerRadius corners:UIRectCornerAllCorners borderWidth:borderWidth borderColor:borderColor borderLineJoin:kCGLineJoinRound];
	
	[button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
	[button setTitleColor:normalForegroundColor forState:UIControlStateNormal];
	
	[button setBackgroundImage:highlightBackgroundImage forState:UIControlStateHighlighted];
	[button setTitleColor:highlightForegroundColor forState:UIControlStateHighlighted];
	return button;
}

@end
