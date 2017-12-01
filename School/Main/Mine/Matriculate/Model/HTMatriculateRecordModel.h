//
//  HTMatriculateRecordModel.h
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMatriculateRecordAllSchoolModel,HTMatriculateSingleSchoolModel;

@interface HTMatriculateRecordModel : NSObject


@property (nonatomic, strong) NSArray<HTMatriculateSingleSchoolModel *> *probabilityTest;

@property (nonatomic, strong) NSArray<HTMatriculateRecordAllSchoolModel *> *schoolTest;


@end


@interface HTMatriculateRecordAllSchoolModel : NSObject

@property (nonatomic, copy) NSString *education;

@property (nonatomic, copy) NSString *gpa;

@property (nonatomic, copy) NSString *enterpriseGrade;

@property (nonatomic, copy) NSString *active;

@property (nonatomic, copy) NSString *project;

@property (nonatomic, copy) NSString *workLevel;

@property (nonatomic, copy) NSString *winning;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *applyMajor;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *schoolGrade;

@property (nonatomic, copy) NSString *toefl;

@property (nonatomic, copy) NSString *nowMajor;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *majorName;

@property (nonatomic, copy) NSString *most;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *attendSchool;

@property (nonatomic, copy) NSString *studyTour;

@property (nonatomic, copy) NSString *majorDirection;

@property (nonatomic, copy) NSString *gmat;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *result;

@end

@interface HTMatriculateSingleSchoolModel : NSObject

@property (nonatomic, copy) NSString *education;

@property (nonatomic, copy) NSString *gpa;

@property (nonatomic, copy) NSString *project;

@property (nonatomic, copy) NSString *school;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *privateEnterprise;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *enterprises;

@property (nonatomic, copy) NSString *awards;

@property (nonatomic, copy) NSString *percent;

@property (nonatomic, copy) NSString *schoolGrade;

@property (nonatomic, copy) NSString *toefl;

@property (nonatomic, copy) NSString *nowMajor;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *bigFour;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *attendSchool;

@property (nonatomic, copy) NSString *publicBenefit;

@property (nonatomic, copy) NSString *foreignCompany;

@property (nonatomic, copy) NSString *study;

@property (nonatomic, copy) NSString *gmat;

@property (nonatomic, copy) NSString *createTime;

@end

