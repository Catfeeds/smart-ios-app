//
//  HTChatModel.h
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JMessage/JMessage.h>
#import "HTMessageModel.h"
#import "HTUserManager.h"

typedef void(^completeHandler)(void);

@interface HTChatModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray <HTMessageModel *> *messageModelArray;


@property (nonatomic, strong, readonly) NSString *senderName;

@property (nonatomic, strong, readonly) NSString *senderUid;

- (void)sendText:(NSString *)text complete:(completeHandler)complete;

- (void)receiveText:(NSString *)text senderUid:(NSString *)senderUid date:(NSDate *)date complete:(completeHandler)complete;

- (void)receiveMessage:(NSArray <JMSGMessage *> *)messageArray complete:(completeHandler)complete;

@end
