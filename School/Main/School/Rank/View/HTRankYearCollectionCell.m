//
//  HTRankYearCollectionCell.m
//  School
//
//  Created by Charles Cao on 2017/12/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTRankYearCollectionCell.h"

@implementation HTRankYearCollectionCell

- (void)setSelected:(BOOL)selected{
	[super setSelected:selected];
	self.yearLabel.textColor = selected ? [UIColor whiteColor] : [UIColor ht_colorString:@"666666"];
	self.yearLabel.backgroundColor = selected ? [UIColor ht_colorStyle:HTColorStylePrimaryTheme] : [UIColor ht_colorString:@"F5F3E8"];
}

- (void)setYear:(HTYearModel *)year{
    _year = year;
    self.yearLabel.text = year.name;
}

@end
