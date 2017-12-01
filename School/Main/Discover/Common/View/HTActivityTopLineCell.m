//
//  HTActivityTopLineCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTActivityTopLineCell.h"
#import "HTDiscoverActivityModel.h"

@interface HTActivityTopLineCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTActivityTopLineCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
	}];
}

- (void)setModel:(HTDiscoverActivityModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
	}
	return _titleNameLabel;
}

@end
