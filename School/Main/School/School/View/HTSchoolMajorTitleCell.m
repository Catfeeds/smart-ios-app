//
//  HTSchoolMajorTitleCell.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMajorTitleCell.h"
#import "HTSchoolModel.h"

@interface HTSchoolMajorTitleCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;

@end

@implementation HTSchoolMajorTitleCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSeparatorStyleNone;
	[self addSubview:self.titleNameLabel];
	[self.titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}

- (void)setModel:(HTSchoolProfessionalModel *)model row:(NSInteger)row {
	self.titleNameLabel.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	self.titleNameLabel.backgroundColor = selected ? [UIColor whiteColor] : [UIColor clearColor];
}

- (UILabel *)titleNameLabel {
	if (!_titleNameLabel) {
		_titleNameLabel = [[UILabel alloc] init];
		_titleNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_titleNameLabel.font = [UIFont systemFontOfSize:13];
		_titleNameLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleNameLabel;
}

@end
