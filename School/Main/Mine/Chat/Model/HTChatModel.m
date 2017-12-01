//
//  HTChatModel.m
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChatModel.h"
#import <SDWebImageManager.h>

@implementation HTChatModel

@synthesize messageModelArray = _messageModelArray;

- (NSMutableArray <HTMessageModel *> *)messageModelArray {
	if (!_messageModelArray) {
		_messageModelArray = [@[] mutableCopy];
	}
	return _messageModelArray;
}

- (NSString *)senderName {
	HTUser *user = [HTUserManager currentUser];
	NSString *displayName = user.userName;
	return displayName;
}

- (NSString *)senderUid {
	HTUser *user = [HTUserManager currentUser];
	NSString *uid = user.uid;
	return uid;
}

- (void)sendText:(NSString *)text complete:(completeHandler)complete {
	NSString *senderName = self.senderName;
	NSString *senderImagePath = [HTUserManager currentUser].image;
	senderImagePath = SmartApplyResourse(senderImagePath);
	[[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:senderImagePath] options:kNilOptions progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
		HTMessageModel *model = [HTMessageModel ht_messageWithSenderId:@"1" senderDisplayName:senderName senderAvatarImage:image date:nil text:text];
		[self.messageModelArray addObject:model];
		if (complete) {
			complete();
		}
	}];
}

- (void)receiveText:(NSString *)text senderUid:(NSString *)senderUid date:(NSDate *)date complete:(completeHandler)complete {
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	[HTRequestManager requestUserInfomationWithNetworkModel:networkModel uidString:senderUid complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
		HTUser *user = [HTUser mj_objectWithKeyValues:response[@"data"]];
		NSString *senderName = user.userName;
		NSString *senderImagePath = user.image;
		senderImagePath = SmartApplyResourse(senderImagePath);
		[[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:senderImagePath] options:kNilOptions progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
			HTMessageModel *model = [HTMessageModel ht_messageWithSenderId:@"2" senderDisplayName:senderName senderAvatarImage:image date:date text:text];
			[self.messageModelArray addObject:model];
			if (complete) {
				complete();
			}
		}];

	}];
}

- (void)receiveMessage:(NSArray <JMSGMessage *> *)messageArray complete:(completeHandler)complete {
	[messageArray enumerateObjectsUsingBlock:^(JMSGMessage *message, NSUInteger index, BOOL * _Nonnull stop) {
		NSNumber *time = message.timestamp;
		NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
		NSString *content = @"";
		if (message.contentType == kJMSGContentTypeText) {
			JMSGTextContent *textContent = (JMSGTextContent *)message.content;
			content = textContent.text;
		}
		JMSGUser *user = message.fromUser;
		[user thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
			UIImage *image = [UIImage imageWithData:data];
			HTMessageModel *model = [HTMessageModel ht_messageWithSenderId:@"2" senderDisplayName:user.username senderAvatarImage:image date:date text:content];
			[self.messageModelArray addObject:model];
			if (complete) {
				complete();
			}
		}];
	}];
}

@end
