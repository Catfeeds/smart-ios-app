//
//  HTStudyAbroadModel.m
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyAbroadModel.h"

@implementation HTStudyAbroadModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
	return @{
			 @"data" : @"data.data"
			 };
}

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"data" : @"HTStudyAbroadData",
			 @"serviceTypes" : @"HTStudyAbroadServiceType",
			 @"countrys" : @"HTStudyAbroadCountry"
			 };
}

@end



@implementation HTStudyAbroadSelectorModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
	return @{
			 @"ID" : @"id"
			 };
}

@end

@implementation HTStudyAbroadData

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
	return @{
			 @"ID" : @"id"
			 };
}

@end


@implementation HTStudyAbroadServiceType

- (void)mj_keyValuesDidFinishConvertingToObject{
	self.type = HTSelectorModelServiceType;
}

@end


@implementation HTStudyAbroadCountry

- (void)mj_keyValuesDidFinishConvertingToObject{
	self.type = HTSelectorModelCountryType;
}

@end
