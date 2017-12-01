//
//  HTSchoolModel.h
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSchoolMatriculateModel.h"

@class HTSchoolDetailModel,HTSchoolProfessionalModel,HTSchoolProfessionalSubModel, HTSchoolBaseDataModel;

@interface HTSchoolModel : HTSchoolMatriculateSelectedModel

@property (nonatomic, strong) NSArray <HTSchoolBaseDataModel *> *baseDataArray;

@property (nonatomic, strong) NSAttributedString *schoolDescriptionAttributedString;

@property (nonatomic, strong) NSAttributedString *schoolInformationAttributedString;



@property (nonatomic, copy) NSString *listeningFile;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *sentenceNumber;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *alternatives;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *place;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, strong) NSArray<HTSchoolProfessionalModel *> *major;


@end

@interface HTSchoolProfessionalModel : NSObject

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL sectionIsSelected;



@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger isShow;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, strong) NSArray<HTSchoolProfessionalSubModel *> *content;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger isMajor;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger pid;

@end

@interface HTSchoolProfessionalSubModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *degree;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *direction;

@end

@interface HTSchoolBaseDataModel : NSObject

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *detailName;

@end
