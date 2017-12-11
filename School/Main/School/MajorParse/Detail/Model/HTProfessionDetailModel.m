//
//  HTProfessionDetailModel.m
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionDetailModel.h"

@implementation HTProfessionDetailModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"school" : @"school[0]",
             @"profession" : @"data[0]"
             };
}

@end

@implementation HTProfessionSchoolModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
                 @"ID":@"id"
             };
}

@end

@implementation HTProfessionModel

@end
