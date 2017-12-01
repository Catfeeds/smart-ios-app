//
//  HTChatManager.m
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChatManager.h"
#import <JMessage/Jmessage.h>
#import <SDWebImageManager.h>
#import "HTUserManager.h"

@implementation HTChatManager

+ (NSString *)jmessageAppKey {
	return @"26b7c447634297b200bbd120";
}

+ (void)initializeChatManagerWithWillChatUsername:(NSString *)willChatUsername complete:(completeHandler)complete {
	HTUser *user = [HTUserManager currentUser];
	NSString *username = user.userName;
	NSString *password = user.password;
	NSString *image = user.image;
	image = SmartApplyResourse(image);
	[JMSGUser registerWithUsername:username password:password completionHandler:^(id resultObject, NSError *error) {
		if (!error || error.code == kJMSGErrorHttpUserExist) {
			[JMSGUser loginWithUsername:username password:password completionHandler:^(id resultObject, NSError *error) {
				if (!error) {
					[[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:image] options:kNilOptions progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
						JMSGUserInfo *userInfo = [[JMSGUserInfo alloc] init];
						userInfo.nickname = username;
						userInfo.avatarData = UIImageJPEGRepresentation(image, 0);
						[JMSGUser updateMyInfoWithUserInfo:userInfo completionHandler:^(id resultObject, NSError *error) {
							if (!error) {
								if (complete) {
									complete();
								}
							}
						}];
					}];
					
				}
			}];
		}
	}];
}

@end
