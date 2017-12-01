//
//  HTAnswerTagManager.h
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTAnswerTagManager : NSObject

extern NSString *const kHTSelectedTagArrayDidChangeNotifacation;

+ (void)saveSelectedAnswerTagArray:(NSArray *)selectedAnswerTagArray;

+ (void)requestCurrentAnswerTagArrayBlock:(void(^)(NSMutableArray *answerTagArray))answerTagArrayBlock;

@end
