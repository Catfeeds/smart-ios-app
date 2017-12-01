//
//  HTIndexWorkCell.m
//  School
//
//  Created by hublot on 2017/8/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexWorkCell.h"
#import "HTWorkHeaderModel.h"

@interface HTIndexWorkCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UIButton *titleNameButton;

@end

@implementation HTIndexWorkCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameButton];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.top.bottom.mas_equalTo(self);
		make.width.mas_equalTo(self).multipliedBy(0.55);
	}];
	[self.titleNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.top.bottom.mas_equalTo(self);
		make.left.mas_equalTo(self.headImageView.mas_right);
	}];
}

- (void)setModel:(HTWorkModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	[self.titleNameButton setTitle:model.name forState:UIControlStateNormal];
	self.backgroundColor = [UIColor ht_randomColor];
}

- (UIImageView *)headImageView {
	if (!_headImageView) {
		_headImageView = [[UIImageView alloc] init];
		_headImageView.contentMode = UIViewContentModeScaleAspectFill;
		_headImageView.clipsToBounds = true;
	}
	return _headImageView;
}

- (UIButton *)titleNameButton {
	if (!_titleNameButton) {
		_titleNameButton = [[UIButton alloc] init];
		_titleNameButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[_titleNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_titleNameButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
		_titleNameButton.titleLabel.numberOfLines = 0;
		_titleNameButton.userInteractionEnabled = false;
	}
	return _titleNameButton;
}

@end
