//
//  HTLibraryModel.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryModel.h"

@implementation HTLibraryModel


+ (NSDictionary *)objectClassInArray{
    return @{@"apply" : [HTLibraryApplyTypeModel class], @"videoAnalysis" : [HTLibrarySchoolVideoModel class], @"applyVideo" : [HTLibraryProjectVideoHeaderModel class]};
}
@end


@implementation HTLibraryApplyTypeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"child" : [HTLibraryApplyHeaderModel class]};
}

@end


@implementation HTLibraryApplyHeaderModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HTLibraryApplyContentModel class]};
}

@end


@implementation HTLibraryApplyContentModel

@end


@implementation HTLibrarySchoolVideoModel

@end


@implementation HTLibraryProjectVideoHeaderModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HTLibraryProjectVideoContentModel class]};
}

@end


@implementation HTLibraryProjectVideoContentModel

@end


