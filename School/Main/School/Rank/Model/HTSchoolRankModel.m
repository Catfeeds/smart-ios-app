//
//  HTSchoolRankModel.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankModel.h"
#import <HTRandomNumberManager.h>

@implementation HTSchoolRankModel

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSString *viewCountIdentifier = [NSString stringWithFormat:@"HTRankViewCount%@", self.ID];
	NSInteger viewCount = [HTRandomNumberManager ht_randomIntegerWithIdentifier:viewCountIdentifier minBeginCount:3695 maxBeginCount:4095 minAppendCount:10 maxAppendCount:20 spendHour:24];
	self.viewCount = [NSString stringWithFormat:@"%ld", viewCount];
	
	NSString *replyCountIdentifier = [NSString stringWithFormat:@"HTRankReply%@", self.ID];
	NSInteger replyCount = [HTRandomNumberManager ht_randomIntegerWithIdentifier:replyCountIdentifier minBeginCount:1672 maxBeginCount:2072 minAppendCount:3 maxAppendCount:10 spendHour:24];
	self.answer = [NSString stringWithFormat:@"%ld", replyCount];
}

- (void)reloadModelImageWithIndex:(NSInteger)index {
	UIEdgeInsets titleEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
	switch (index) {
		case 0: {
			self.imageName = @"cn_school_rank_first";
			self.titleEdgeInsets = titleEdgeInsets;
			self.imageSize = CGSizeMake(55, 63);
			self.titleColor = [UIColor whiteColor];
			break;
		}
		case 1: {
			self.imageName = @"cn_school_rank_second";
			self.titleEdgeInsets = titleEdgeInsets;
			self.imageSize = CGSizeMake(57, 65);
			self.titleColor = [UIColor whiteColor];
			break;
		}
		case 2: {
			self.imageName = @"cn_school_rank_third";
			self.titleEdgeInsets = titleEdgeInsets;
			self.imageSize = CGSizeMake(58, 67);
			self.titleColor = [UIColor whiteColor];
			break;
		}
		default: {
			self.imageName = @"cn_school_rank_normal";
			self.titleEdgeInsets = UIEdgeInsetsZero;
			self.imageSize = CGSizeMake(49, 55);
			self.titleColor = [UIColor ht_colorStyle:HTColorStyleSecondaryTitle];
			break;
		}
	}
}

@end
