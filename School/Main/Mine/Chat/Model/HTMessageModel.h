//
//  HTMessageModel.h
//  School
//
//  Created by hublot on 2017/9/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "JSQMessage.h"
#import "JSQMessageAvatarImageDataSource.h"

@interface HTMessageModel : JSQMessage <JSQMessageAvatarImageDataSource>

@property (nonatomic, strong) UIImage *senderAvatarImage;

// date 为空会取当前时间
// senderAvatarImage 为空会取默认占位图
+ (instancetype)ht_messageWithSenderId:(NSString *)senderId
					 senderDisplayName:(NSString *)senderDisplayName
					 senderAvatarImage:(UIImage *)senderAvatarImage
								  date:(NSDate *)date
								  text:(NSString *)text;

@end
