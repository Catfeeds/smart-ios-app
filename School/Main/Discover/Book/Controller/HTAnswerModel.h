//
//  HTAnswerModel.h
//  School
//
//  Created by hublot on 17/8/13.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAnswerTagModel.h"

@class HTAnswerSolutionModel, HTAnswerReplyModel;

@interface HTAnswerModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *follow;

@property (nonatomic, copy) NSString *browse;

@property (nonatomic, copy) NSString *questionType;

@property (nonatomic, copy) NSString *tagId;

@property (nonatomic, strong) NSArray<HTAnswerSolutionModel *> *answer;

@property (nonatomic, strong) NSArray<HTAnswerTagModel *> *tags;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *praise;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *question;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userId;


@property (nonatomic, strong) NSMutableAttributedString *contentAttributedString;

@property (nonatomic, assign) BOOL isDetailModel;

@end

@interface HTAnswerSolutionModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *praise;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, assign) BOOL fabulous;

@property (nonatomic, strong) NSArray <HTAnswerReplyModel *> *reply;



@property (nonatomic, strong) NSMutableAttributedString *contentAttributedString;

@end



@interface HTAnswerReplyModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *praise;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *replyUser;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *addTime;

@end

