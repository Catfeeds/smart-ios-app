//
//  HTProfessionalModel.h
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTProfessionalSchoolModel,HTProfessionalDetailModel,HTProfessionLinkModel;
@interface HTProfessionalModel : NSObject

@property (nonatomic, strong) NSAttributedString *professionalBaseAttributedString;

@property (nonatomic, strong) NSAttributedString *professionalApplyAttributedString;

@property (nonatomic, strong) NSAttributedString *professionalLinkAttributedString;






@property (nonatomic, strong) NSArray<HTProfessionalSchoolModel *> *school;

@property (nonatomic, strong) NSArray<HTProfessionalDetailModel *> *data;

@property (nonatomic, strong) NSArray<HTProfessionLinkModel *> *link;


@end
@interface HTProfessionalSchoolModel : NSObject

@property (nonatomic, copy) NSString *ID;

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

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *duration;

@end

@interface HTProfessionalDetailModel : NSObject

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *numbering;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *admissionTime;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *comprehensive;

@property (nonatomic, copy) NSString *tuition;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *problemComplement;

@property (nonatomic, copy) NSString *performance;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *system;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *speak;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *deadline;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *userId;

@end

@interface HTProfessionLinkModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@end

