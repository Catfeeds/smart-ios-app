//
//  HTMatriculateRecordModel.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateRecordModel.h"

@implementation HTMatriculateRecordModel

+ (NSDictionary *)objectClassInArray{
    return @{@"schoolTest" : [HTMatriculateRecordAllSchoolModel class], @"probabilityTest" : [HTMatriculateSingleSchoolModel class]};
}
@end
@implementation HTMatriculateRecordAllSchoolModel

@end


@implementation HTMatriculateSingleSchoolModel

@end


