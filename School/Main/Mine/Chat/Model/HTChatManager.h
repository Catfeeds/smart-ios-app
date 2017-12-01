//
//  HTChatManager.h
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTChatModel.h"

@interface HTChatManager : NSObject

+ (NSString *)jmessageAppKey;

+ (void)initializeChatManagerWithWillChatUsername:(NSString *)willChatUsername complete:(completeHandler)complete;

@end
