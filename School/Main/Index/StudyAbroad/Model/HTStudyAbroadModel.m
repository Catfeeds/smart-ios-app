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

- (void)mj_keyValuesDidFinishConvertingToObject{
    HTStudyAbroadSelectorModel *allCountryModel = [HTStudyAbroadSelectorModel new];
    allCountryModel.name = @"所有国家";
    allCountryModel.type = HTSelectorModelCountryType;
    allCountryModel.ID = @"";
    
    NSMutableArray *tempCountryArray = [NSMutableArray arrayWithArray:self.countrys];
    [tempCountryArray insertObject:allCountryModel atIndex:0];
    self.countrys = tempCountryArray;
    
    HTStudyAbroadSelectorModel *allServiceModel = [HTStudyAbroadSelectorModel new];
    allServiceModel.name = @"所有服务";
    allServiceModel.type = HTSelectorModelServiceType;
    allServiceModel.ID = @"";
    
    NSMutableArray *tempServiceArray = [NSMutableArray arrayWithArray:self.serviceTypes];
    [tempServiceArray insertObject:allServiceModel atIndex:0];
    self.serviceTypes = tempServiceArray;
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
