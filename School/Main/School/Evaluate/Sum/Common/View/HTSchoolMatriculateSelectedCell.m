//
//  HTSchoolMatriculateSelectedCell.m
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSelectedCell.h"
#import "HTSchoolFilterModel.h"

@interface HTSchoolMatriculateSelectedCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation HTSchoolMatriculateSelectedCell

- (void)didMoveToSuperview {
	[self.contentView addSubview:self.titleNameLabel];
	[self.contentView addSubview:self.rightImageView];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(self.rightImageView.mas_left).offset(- 15);
		make.centerY.mas_equalTo(self);
	}];
	[self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 15);
		make.centerY.mas_equalTo(self);
	}];
	UIView *seletedBackgroundView = [[UIView alloc] init];
	seletedBackgroundView.backgroundColor = [UIColor ht_colorString:@"f0f0f0"];
	[self.selectedBackgroundView addSubview:seletedBackgroundView];
	[seletedBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.selectedBackgroundView);
	}];
}

- (void)setModel:(HTSelectedModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	self.rightImageView.hidden = !selected;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
	}
	return _titleNameLabel;
}

- (UIImageView *)rightImageView {
	if (!_rightImageView) {
		_rightImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_selected_right"];
		image = [image ht_resetSizeZoomNumber:0.4];
		_rightImageView.image = image;
		[_rightImageView setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
		[_rightImageView setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _rightImageView;
}


@end
