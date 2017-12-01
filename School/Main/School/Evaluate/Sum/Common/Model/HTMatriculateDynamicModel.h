//
//  HTMatriculateDynamicModel.h
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolMatriculateModel.h"

@class HTMatriculateMajorModel,HTMatriculateProfessionalModel,HTMatriculateCountryModel;
@interface HTMatriculateDynamicModel : NSObject

@property (nonatomic, strong) NSArray<HTMatriculateMajorModel *> *major;

@property (nonatomic, strong) NSArray<HTMatriculateCountryModel *> *country;

@end
@interface HTMatriculateMajorModel : HTSchoolMatriculateSelectedModel

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, assign) NSInteger isShow;

@property (nonatomic, assign) NSInteger majorCount;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<HTMatriculateProfessionalModel *> *child;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger isMajor;

@end

@interface HTMatriculateProfessionalModel : HTSchoolMatriculateSelectedModel

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger isMajor;

@property (nonatomic, assign) NSInteger majorCount;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, assign) NSInteger pid;

@end

@interface HTMatriculateCountryModel : HTSchoolMatriculateSelectedModel

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *isMajor;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *pid;

@end

