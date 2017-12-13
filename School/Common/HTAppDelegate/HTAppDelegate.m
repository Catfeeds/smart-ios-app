//
//  HTAppDelegate.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAppDelegate.h"
#import <Bugly/Bugly.h>
#import <BmobSDK/Bmob.h>
#import <JMessage/JMessage.h>
#import "HTChatManager.h"
#import <HTCacheManager.h>
#import "HTManagerController.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>


@interface HTAppDelegate () <JMessageDelegate>

@end

@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	
	//-----------------------------------------/ 分享 /-----------------------------------------//
	
	[ShareSDK registerApp:@"2305bbd30d4ac" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
		switch (platformType) {
			case SSDKPlatformTypeWechat:
				[ShareSDKConnector connectWeChat:[WXApi class]];
				break;
			case SSDKPlatformTypeQQ:
				[ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
				break;
			case SSDKPlatformTypeSinaWeibo:
				[ShareSDKConnector connectWeibo:[WeiboSDK class]];
				break;
			default:
				break;
		}
	} onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
		switch (platformType) {
			case SSDKPlatformTypeSinaWeibo:
				[appInfo SSDKSetupSinaWeiboByAppKey:@"870601458"
										  appSecret:@"b7006e1cd051475faa47dcc7b4797c45"
										redirectUri:@"http://sns.whalecloud.com/sina2/callback"
										   authType:SSDKAuthTypeBoth];
				break;
			case SSDKPlatformTypeWechat:
				[appInfo SSDKSetupWeChatByAppId:@"wxf128dd6bedb8cf36"
									  appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
				break;
			case SSDKPlatformTypeQQ:
				[appInfo SSDKSetupQQByAppId:@"101228026"
									 appKey:@"31b2c819816b03598809bf9ef2f2172d"
								   authType:SSDKAuthTypeBoth];
				break;
			default:
				break;
		}
	}];
	
	
    //-----------------------------------------/ 崩溃捕获 /-----------------------------------------//
    
    #ifndef DEBUG
        [Bugly startWithAppId:@"55e39d1655"];
    #endif
		
	//-----------------------------------------/ Bmob 三方数据存取 /-----------------------------------------//
	
	[Bmob registerWithAppKey:@"2bdfbdbf2d1ddd24dce4d40d2faccbff"];
    
    //-----------------------------------------/ 极光 /-----------------------------------------//
    
    [JMessage addDelegate:self withConversation:nil];
    [JMessage setupJMessage:launchOptions
                     appKey:[HTChatManager jmessageAppKey]
                    channel:@""
           apsForProduction:true
                   category:nil
             messageRoaming:YES];
    
    #ifdef __IPHONE_8_0
        [JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    #else
        [JMessage registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                      UIRemoteNotificationTypeSound |
                                                      UIRemoteNotificationTypeAlert)
                                          categories:nil];
    #endif
    
    //-----------------------------------------/ 缓存 /-----------------------------------------//
    
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024 diskCapacity:100 * 1024 * 1024 diskPath:[HTCacheManager rootCacheFloderPath]];
    [NSURLCache setSharedURLCache:cache];
    
    //-----------------------------------------/ 主控制器 /-----------------------------------------//
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [HTManagerController defaultManagerController];
	
	return true;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [JMessage resetBadge];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JMessage registerDeviceToken:deviceToken];
}

@end
