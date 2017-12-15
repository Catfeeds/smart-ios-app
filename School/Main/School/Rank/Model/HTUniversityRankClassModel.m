//
//  HTUniversityRankClassModel.m
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUniversityRankClassModel.h"

@implementation HTUniversityRankClassModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
	switch (self.ID.integerValue) {
		case 296:
			self.backgroundImageName = @"rank_best";
			break;
		case 293:
			self.backgroundImageName = @"rank_qs";
			break;
		case 330:
			self.backgroundImageName = @"rank_arwu";
			break;
		case 295:
		case 297:
			self.backgroundImageName = @"rank_times";
			break;
		case 294:
		case 312:
			self.backgroundImageName = @"rank_macleans";
			break;
		
		default:
			self.backgroundImageName = @"rank_default";
			break;
	}
}

@end
