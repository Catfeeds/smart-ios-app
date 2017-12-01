//
//  HTUser.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUser.h"
#import "HTUserStoreManager.h"

@implementation HTUser

- (NSInteger)storeCount {
    return [HTUserStoreManager allStoreCount];
}

@end
