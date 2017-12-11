//
//  HTSchoolMatriculateParameterModel.h
//  School
//
//  Created by Charles Cao on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSchoolMatriculateParameterModel : NSObject

@property (nonatomic, strong) NSString *attendSchool;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *gmat;
@property (nonatomic, strong) NSString *gpa;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *majorName;
@property (nonatomic, strong) NSString *major_top;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *schoolName;
@property (nonatomic, strong) NSString *toefl;
@property (nonatomic, strong) NSString *bigFour;          //四大
@property (nonatomic, strong) NSString *foreignCompany;   //外企
@property (nonatomic, strong) NSString *enterprises;      //国企
@property (nonatomic, strong) NSString *privateEnterprise;//私企
@property (nonatomic, strong) NSString *project;		  //项目
@property (nonatomic, strong) NSString *study;			  //游学
@property (nonatomic, strong) NSString *publicBenefit; 	  //公益
@property (nonatomic, strong) NSString *awards;			  //得奖

@end

