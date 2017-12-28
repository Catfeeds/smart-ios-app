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

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"data" : @"HTUniversityRankModel",
			 @"years":@"HTYearModel"
			 };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"data" : @"data.data"
             };
}

@end

@implementation HTYearModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

@end

@implementation HTUniversityRankModel

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSString *viewCountIdentifier = [NSString stringWithFormat:@"HTRankViewCount%@", self.ID];
	NSInteger viewCount = [HTRandomNumberManager ht_randomIntegerWithIdentifier:viewCountIdentifier minBeginCount:3695 maxBeginCount:4095 minAppendCount:10 maxAppendCount:20 spendHour:24];
	self.viewCount = [NSString stringWithFormat:@"%ld", viewCount];
	
	NSString *replyCountIdentifier = [NSString stringWithFormat:@"HTRankReply%@", self.ID];
	NSInteger replyCount = [HTRandomNumberManager ht_randomIntegerWithIdentifier:replyCountIdentifier minBeginCount:1672 maxBeginCount:2072 minAppendCount:3 maxAppendCount:10 spendHour:24];
	self.answer = [NSString stringWithFormat:@"%ld", replyCount];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}


@end
