//
//  HTAnswerTagCell.m
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerTagCell.h"
#import "HTAnswerTagModel.h"

@interface HTAnswerTagCell ()

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UISwitch *rightDetailSwitch;

@property (nonatomic, strong) HTAnswerTagModel *model;

@end

@implementation HTAnswerTagCell

- (void)didMoveToSuperview {
	[self addSubview:self.leftImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.rightDetailSwitch];
	[self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(20);
		make.centerY.mas_equalTo(self);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.leftImageView.mas_right).offset(20);
		make.top.bottom.mas_equalTo(self);
		make.right.mas_equalTo(self.rightDetailSwitch.mas_left);
	}];
	[self.rightDetailSwitch mas_updateConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(- 20);
		make.centerY.mas_equalTo(self);
	}];
}

- (void)setModel:(HTAnswerTagModel *)model row:(NSInteger)row {
	_model = model;
	self.titleNameLabel.text = model.name;
	[self.rightDetailSwitch setOn:model.isEnable animated:false];
}

- (UIImageView *)leftImageView {
	if (!_leftImageView) {
		_leftImageView = [[UIImageView alloc] init];
		UIImage *image = [UIImage imageNamed:@"cn_answer_tag_drag"];
		image = [image ht_resetSize:CGSizeMake(22, 29)];
		_leftImageView.image = image;
	}
	return _leftImageView;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
		[_titleNameLabel setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisHorizontal];
		[_titleNameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
	}
	return _titleNameLabel;
}

- (UISwitch *)rightDetailSwitch {
	if (!_rightDetailSwitch) {
		_rightDetailSwitch = [[UISwitch alloc] init];
		_rightDetailSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
		
		__weak typeof(self) weakSelf = self;
		[_rightDetailSwitch bk_addEventHandler:^(id sender) {
			weakSelf.model.isEnable = weakSelf.rightDetailSwitch.isOn;
		} forControlEvents:UIControlEventValueChanged];
	}
	return _rightDetailSwitch;
}


@end
