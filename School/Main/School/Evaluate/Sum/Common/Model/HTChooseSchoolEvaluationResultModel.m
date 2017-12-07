//
//  HTChooseSchoolEvaluationResultModel.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolEvaluationResultModel.h"

@implementation HTChooseSchoolEvaluationResultModel

@end

@implementation HTResultSchool

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

@end


@implementation HTData

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"res" : @"HTResultSchool"
			 };
}

@end

@implementation HTCompareResult

@end


@implementation HTScore

@end


@implementation HTResultUser

@end

