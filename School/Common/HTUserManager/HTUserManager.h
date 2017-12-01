//
//  HTUserManager.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUser.h"

@interface HTUserManager : NSObject

+ (void)saveToUserTableWithUser:(HTUser *)user;

+ (HTUser *)currentUser;

+ (void)updateUserDetailComplete:(void(^)(BOOL success))complete;

+ (void)surePermissionHighOrEqual:(HTUserPermission)permission passCompareBlock:(void(^)(HTUser *user))passCompareBlock;


+ (void)updateUserDetailComplete:(void(^)(BOOL success))complete userLoginDictionary:(NSDictionary *)userLoginDictionary;

@end
