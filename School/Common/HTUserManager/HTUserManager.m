//
//  HTUserManager.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserManager.h"
#import "HTLoginManager.h"

static NSString *kHTUserManagerKey = @"kHTUserManagerKey";

@interface HTUserManager ()

@end

@implementation HTUserManager

static HTUserManager *userManager;

+ (void)saveToUserTableWithUser:(HTUser *)user {
	user.permission = HTUserPermissionExerciseAbleUser;
	NSDictionary *userKeyvalues = user.mj_keyValues;
	[[NSUserDefaults standardUserDefaults] setValue:userKeyvalues forKey:kHTUserManagerKey];
}

+ (HTUser *)currentUser {
	NSDictionary *userKeyvalues = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kHTUserManagerKey];
	HTUser *user = [HTUser mj_objectWithKeyValues:userKeyvalues];
    if (!user) {
        user = [[HTUser alloc] init];
    }
	return user;
}

+ (void)surePermissionHighOrEqual:(HTUserPermission)permission passCompareBlock:(void(^)(HTUser *user))passCompareBlock {
	if ([HTUserManager currentUser].permission >= permission) {
		passCompareBlock([HTUserManager currentUser]);
	} else {
		[HTAlert title:@"需要登录才能继续哦😲" sureAction:^{
			[HTLoginManager presentAndLoginSuccess:nil];
		}];
	}
}

//------------------------------------/ 更新用户信息 /------------------------------------//

+ (void)updateUserDetailComplete:(void(^)(BOOL success))complete {
	[self updateUserDetailComplete:complete userLoginDictionary:nil];
}

+ (void)updateUserDetailComplete:(void(^)(BOOL success))complete userLoginDictionary:(NSDictionary *)userLoginDictionary {
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoAlertString = nil;
	networkModel.offlineCacheStyle = HTCacheStyleNone;
	networkModel.autoShowError = false;
	networkModel.maxRepeatCountString = @"0";
	[HTRequestManager requestUserModelWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[[NSNotificationCenter defaultCenter] postNotificationName:kHTLoginNotification object:nil];
			complete(true);
			return;
		}
		__block NSMutableDictionary *userData = [@{} mutableCopy];
		NSDictionary *dataDictionary = response[@"data"];
		[dataDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
			if (!obj || [obj isKindOfClass:[NSNull class]] || ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""])) {
				obj = @"";
			}
			[userData setObject:obj forKey:key];
		}];
		HTUser *user = [[HTUser alloc] init];
		NSString *originUidString;
		NSString *receiveUidString = [NSString stringWithFormat:@"%@", [userData valueForKey:@"uid"]];
		NSDictionary *originUserKeyValues;
		if (userLoginDictionary.count) {
			originUidString = [userLoginDictionary valueForKey:@"uid"];
			originUserKeyValues = userLoginDictionary;
		} else {
			HTUser *currentUser = [HTUserManager currentUser];
			originUidString = currentUser.uid;
			originUserKeyValues = currentUser.mj_keyValues;
		}
		if ([originUidString isEqualToString:receiveUidString]) {
			[user mj_setKeyValues:originUserKeyValues];
		}
		[user mj_setKeyValues:userData];
		[HTUserManager saveToUserTableWithUser:user];
		[[NSNotificationCenter defaultCenter] postNotificationName:kHTLoginNotification object:nil];
		complete(true);
	}];
}

@end
