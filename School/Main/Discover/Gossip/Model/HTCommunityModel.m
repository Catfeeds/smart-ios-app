//
//  HTCommunityModel.m
//  GMat
//
//  Created by hublot on 2016/11/22.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import "HTCommunityModel.h"

@implementation HTCommunityModel

+ (NSDictionary *)objectClassInArray{
    return @{@"reply" : [CommunityReply class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
}

@end

@implementation CommunityReply

@end


