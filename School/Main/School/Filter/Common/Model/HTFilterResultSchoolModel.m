//
//  HTFilterResultSchoolModel.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFilterResultSchoolModel.h"

@implementation HTFilterResultSchoolModel


+ (NSDictionary *)objectClassInArray{
    return @{@"major" : [HTFilterResultProfessionalModel class]};
}

@end

@implementation HTFilterResultProfessionalModel

@end


