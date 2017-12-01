//
//  HTMessageModel.m
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMessageModel.h"

@implementation HTMessageModel

- (nullable UIImage *)avatarImage {
	return self.senderAvatarImage;
}

- (nullable UIImage *)avatarHighlightedImage {
	return self.senderAvatarImage;
}

- (UIImage *)avatarPlaceholderImage {
	return self.senderAvatarImage;
}

+ (instancetype)ht_messageWithSenderId:(NSString *)senderId
					 senderDisplayName:(NSString *)senderDisplayName
					 senderAvatarImage:(UIImage *)senderAvatarImage
								  date:(NSDate *)date
								  text:(NSString *)text {
	
	NSDate *createDate = date;
	if (!createDate) {
		createDate = [NSDate date];
	}
	
	UIImage *createAvatarImage = senderAvatarImage;
	if (!createAvatarImage) {
		createAvatarImage = HTPLACEHOLDERIMAGE;
	}
	HTMessageModel *messageModel = [[HTMessageModel alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:createDate text:text];
	messageModel.senderAvatarImage = createAvatarImage;
	return messageModel;
}

@end
