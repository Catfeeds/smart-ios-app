//
//  HTFilterResultSchoolModel.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTFilterResultProfessionalModel;

@interface HTFilterResultSchoolModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *listeningFile;

@property (nonatomic, strong) NSArray<HTFilterResultProfessionalModel *> *major;

@property (nonatomic, copy) NSString *seat;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *reply;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *rank;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *place;

@end

@interface HTFilterResultProfessionalModel : NSObject

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

