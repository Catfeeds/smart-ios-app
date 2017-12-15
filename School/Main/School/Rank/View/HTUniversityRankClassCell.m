//
//  HTUniversityRankCell.m
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUniversityRankClassCell.h"

@implementation HTUniversityRankClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRankClass:(HTUniversityRankClassModel *)rankClass{
	
	_rankClass = rankClass;
	self.rankTitleLabel.text = rankClass.name;
	self.rankBackgroundImageView.image = [UIImage imageNamed:rankClass.backgroundImageName];
}

@end
