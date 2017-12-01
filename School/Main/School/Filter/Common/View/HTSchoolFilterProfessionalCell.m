//
//  HTSchoolFilterProfessionalCell.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolFilterProfessionalCell.h"
#import "HTFilterResultSchoolModel.h"

@interface HTSchoolFilterProfessionalCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTSchoolFilterProfessionalCell

- (void)didMoveToSuperview {
	[self addSubview:self.titleNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
	}];
	UIView *seletedBackgroundView = [[UIView alloc] init];
	seletedBackgroundView.backgroundColor = [UIColor ht_colorString:@"f3f3f3"];
	[self.selectedBackgroundView addSubview:seletedBackgroundView];
	[seletedBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self.selectedBackgroundView);
	}];
}

- (void)setModel:(HTFilterResultProfessionalModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:14];
	}
	return _titleNameLabel;
}


@end
