//
//  HTChatController.m
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChatController.h"
#import "HTChatModel.h"
#import "HTChatManager.h"
#import <JMessage/Jmessage.h>

@interface HTChatController () <JMessageDelegate>

@property (nonatomic, strong) HTChatModel *chatModel;

@property (nonatomic, strong) JMSGConversation *conversation;

@end

@implementation HTChatController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.collectionView.collectionViewLayout.springinessEnabled = true;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	__weak typeof(self) weakSelf = self;
	self.view.userInteractionEnabled = false;
	[HTChatManager initializeChatManagerWithWillChatUsername:self.willChatNickname complete:^{
		[JMSGConversation createSingleConversationWithUsername:weakSelf.willChatNickname completionHandler:^(id resultObject, NSError *error) {
			weakSelf.conversation = resultObject;
			[JMessage addDelegate:weakSelf withConversation:weakSelf.conversation];
			[weakSelf.conversation allMessages:^(id resultObject, NSError *error) {
				NSArray *array = (NSArray *)resultObject;
				[weakSelf.chatModel receiveMessage:array complete:^{
					[weakSelf finishReceivingMessageAnimated:true];
				}];
				weakSelf.view.userInteractionEnabled = true;
			}];
		}];
	}];
}

- (void)initializeUserInterface {
	self.navigationItem.title = self.willChatNickname.length ? self.willChatNickname : @"聊天";
}





- (void)onSendMessageResponse:(JMSGMessage *)message
						error:(NSError *)error {
	__weak typeof(self) weakSelf = self;
	if (!error) {
		[self.chatModel receiveMessage:@[message] complete:^{
			[weakSelf finishSendingMessageAnimated:true];
		}];
	}
}

- (void)onReceiveMessage:(JMSGMessage *)message
				   error:(NSError *)error {
	__weak typeof(self) weakSelf = self;
	[self.chatModel receiveMessage:@[message] complete:^{
		[weakSelf finishReceivingMessageAnimated:true];
	}];
}

- (void)didPressSendButton:(UIButton *)button
		   withMessageText:(NSString *)text
				  senderId:(NSString *)senderId
		 senderDisplayName:(NSString *)senderDisplayName
					  date:(NSDate *)date {
	
	__weak typeof(self) weakSelf = self;
	[self.chatModel sendText:text complete:^{
		[weakSelf.conversation sendTextMessage:text];
	}];
}

- (void)didPressAccessoryButton:(UIButton *)sender {
	
}

- (NSString *)senderDisplayName {
	return self.chatModel.senderName;
}

- (NSString *)senderId {
	return self.chatModel.senderUid;
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTMessageModel *model = self.chatModel.messageModelArray[indexPath.row];
	return model;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
	HTMessageModel *model = self.chatModel.messageModelArray[indexPath.row];
	return model;
}

- (HTChatModel *)chatModel {
	if (!_chatModel) {
		_chatModel = [[HTChatModel alloc] init];
	}
	return _chatModel;
}

@end
