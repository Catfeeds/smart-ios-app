//
//  HTUniversityRankCell.m
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUniversityRankCell.h"

@implementation HTUniversityRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRankModel:(HTSchoolRankModel *)rankModel{
	_rankModel = rankModel;
	[self.universityIconView sd_setImageWithURL:[NSURL URLWithString:rankModel.image] placeholderImage:[UIImage imageNamed:@"cn_placeholder"]];
	self.universityNameLabel.text = rankModel.name;
	self.universityTitleLabel.text = rankModel.title;
}

- (void)setRankNum:(NSInteger)rankNum{
	_rankNum = rankNum;
	self.numberLabel.text = @(rankNum).stringValue;
	if (rankNum < 4) {
		self.numberLabel.backgroundColor = [UIColor ht_colorStyle:HTColorStylePrimaryTheme];
		self.numberLabel.textColor = [UIColor whiteColor];
		self.numberLabel.layer.borderWidth = 0;
		self.numberLabel.highlightedTextColor = [UIColor whiteColor];
	}else{
		UIColor *color = [UIColor ht_colorString:@"666666"];
		self.numberLabel.backgroundColor = [UIColor whiteColor];
		self.numberLabel.textColor = color;
		self.numberLabel.layer.borderWidth = 1;
		self.numberLabel.layer.borderColor = color.CGColor;
		self.numberLabel.highlightedTextColor = color;
	}
}

@end
