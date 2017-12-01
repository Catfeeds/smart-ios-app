//
//  HTDiscoverExampleContentCell.m
//  School
//
//  Created by hublot on 2017/8/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverExampleContentCell.h"
#import "HTDiscoverExampleModel.h"

@interface HTDiscoverExampleContentCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailNameLabel;

@end

@implementation HTDiscoverExampleContentCell

- (void)didMoveToSuperview {
	[self addSubview:self.headImageView];
	[self addSubview:self.titleNameLabel];
	[self addSubview:self.detailNameLabel];
	[self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.top.mas_equalTo(15);
		make.bottom.mas_equalTo(- 15);
		make.width.mas_equalTo(self.headImageView.mas_height);
	}];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.headImageView.mas_right).offset(15);
		make.top.mas_equalTo(self.headImageView);
		make.right.mas_equalTo(- 15);
	}];
	[self.detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.titleNameLabel);
		make.top.mas_equalTo(self.titleNameLabel.mas_bottom);
		make.bottom.mas_equalTo(- 15);
	}];
}

- (void)setModel:(HTDiscoverExampleModel *)model row:(NSInteger)row {
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(model.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.titleNameLabel.text = model.cnName;
	self.detailNameLabel.text = [NSString stringWithFormat:@"录取学校: %@\n毕业院校: %@\n硬件条件: %@\n录取专业: %@", model.problemComplement, model.numbering, model.sentenceNumber, model.article];
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
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
		_titleNameLabel.font = [UIFont systemFontOfSize:15];
	}
	return _titleNameLabel;
}


- (UILabel *)detailNameLabel {
	if (!_detailNameLabel) {
		_detailNameLabel = [[UILabel alloc] init];
		_detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_detailNameLabel.font = [UIFont systemFontOfSize:13];
		_detailNameLabel.numberOfLines = 0;
	}
	return _detailNameLabel;
}


@end
