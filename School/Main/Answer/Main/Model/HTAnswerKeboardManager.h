//
//  HTAnswerKeboardManager.h
//  School
//
//  Created by hublot on 2017/8/30.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAnswerModel.h"

typedef void(^HTAnswerKeyboardSuccess)(void);

@interface HTAnswerKeboardManager : NSObject

+ (void)beginKeyboardWithAnswerModel:(HTAnswerModel *)answerModel success:(HTAnswerKeyboardSuccess)success;

+ (void)beginKeyboardWithAnswerSolutionModel:(HTAnswerSolutionModel *)solutionModel answerReplyModel:(HTAnswerReplyModel *)answerReplyModel success:(HTAnswerKeyboardSuccess)success;

+ (void)tryRefreshWithView:(UIView *)view;

@end
