//
//  HTChooseSchoolEvaluationResultModel.h
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUser.h"
#import "HTSchoolModel.h"

@class HTData,HTScore,HTResultUser;

@interface HTChooseSchoolEvaluationResultModel : NSObject

@property (nonatomic, strong) HTData *data;
@property (nonatomic, strong) HTScore *score;
@property (nonatomic, strong) HTResultUser *user;

@end

@interface HTResultSchool : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *image;

@end

@interface HTData : NSObject

@property (nonatomic, strong) NSArray <HTResultSchool *> *res;
@property (nonatomic, strong) NSString *score;

@end

@interface HTCompareResult : NSObject

@property (nonatomic, strong) NSString *score;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *name;

@end

@interface HTScore : NSObject

@property (nonatomic, strong) HTCompareResult *gpa;
@property (nonatomic, strong) HTCompareResult *gmat;
@property (nonatomic, strong) HTCompareResult *toefl;
@property (nonatomic, strong) HTCompareResult *school;
@property (nonatomic, strong) HTCompareResult *work;

@end

@interface HTResultUser : NSObject

@property (nonatomic, strong) NSString *userName;

@end





