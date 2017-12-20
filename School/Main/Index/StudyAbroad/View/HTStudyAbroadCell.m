//
//  HTStudyAbroadCell.m
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyAbroadCell.h"

@implementation HTStudyAbroadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStudyAbroadData:(HTStudyAbroadData *)studyAbroadData{
	_studyAbroadData = studyAbroadData;
	[self.serviceImageView sd_setImageWithURL:[NSURL URLWithString:SmartApplyResourse(studyAbroadData.image)] placeholderImage:HTPLACEHOLDERIMAGE];
	self.serviceTitleLabel.text = HTPlaceholderString(studyAbroadData.title,studyAbroadData.name);
	self.priceLabel.text = [NSString stringWithFormat:@"¥%@",studyAbroadData.price];
	NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:%@",studyAbroadData.originalPrice] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
	self.originalPriceLabel.attributedText = attributeStr;
}

@end
