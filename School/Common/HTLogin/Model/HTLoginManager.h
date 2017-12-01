//
//  HTLoginManager.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

extern NSString *const kHTLoginNotification;

@interface HTLoginManager : NSObject

+ (void)autoLoginWithComplete:(void(^)(BOOL success))complete;

+ (void)exitLoginWithComplete:(void(^)(void))complete;


+ (void)loginUsername:(NSString *)username password:(NSString *)password alert:(BOOL)alert complete:(void(^)(BOOL success, NSString *alertString))complete;

//+ (void)loginWithThreeLoginStyle:(SSDKPlatformType)threeLoginStyle complete:(void(^)(BOOL success, NSString *alertString))complete;

//+ (void)loginWithThreeLoginOpenId:(NSString *)openId name:(NSString *)name iconurl:(NSString *)iconurl alert:(BOOL)alert complete:(void(^)(BOOL success, NSString *alertString))complete;

+ (void)presentAndLoginSuccess:(void(^)(void))success;




+ (void)saveUserDefaultsUserName:(NSString *)username;

+ (void)saveUserDefaultsPassword:(NSString *)password;

+ (NSString *)userDefaultsUserName;

+ (NSString *)userDefaultsPassword;

@end
