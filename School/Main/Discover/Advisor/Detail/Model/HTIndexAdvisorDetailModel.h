//
//  HTIndexAdvisorDetailModel.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTIndexAdvisorModel.h"

@class HTIndexAdvisorDetailAnswerModel, HTIndexAdvisorDetailStudentModel, HTIndexAdvisorDetailCircelModel;

@interface HTIndexAdvisorDetailModel : NSObject

@property (nonatomic, strong) NSArray <HTIndexAdvisorDetailAnswerModel *> *answer;

@property (nonatomic, strong) NSArray <HTIndexAdvisorModel *> *data;

@property (nonatomic, strong) NSArray *caseList;


@property (nonatomic, strong) NSArray <HTIndexAdvisorDetailStudentModel *> *studentList;

@property (nonatomic, strong) NSArray <HTIndexAdvisorDetailCircelModel *> *circelModelArray;

@end
@interface HTIndexAdvisorDetailAnswerModel : NSObject

@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *question;

@end

@interface HTIndexAdvisorDetailStudentModel : NSObject

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *numbering;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *problemComplement;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sentenceNumber;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *listeningFile;

@property (nonatomic, copy) NSString *userId;

@end

@interface HTIndexAdvisorDetailCircelModel : NSObject

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *detailName;

@property (nonatomic, strong) UIColor *backgroundColor;

@end
