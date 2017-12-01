//
//  HTMatriculateDynamicModel.m
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateDynamicModel.h"

@implementation HTMatriculateDynamicModel


+ (NSDictionary *)objectClassInArray{
    return @{@"major" : [HTMatriculateMajorModel class], @"country" : [HTMatriculateCountryModel class]};
}
@end
@implementation HTMatriculateMajorModel

+ (NSDictionary *)objectClassInArray{
    return @{@"child" : [HTMatriculateProfessionalModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	self.pickerModelArray = self.child;
}

@end


@implementation HTMatriculateProfessionalModel

@end


@implementation HTMatriculateCountryModel

@end


