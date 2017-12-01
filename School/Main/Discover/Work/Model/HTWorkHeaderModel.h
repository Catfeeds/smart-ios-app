//
//  HTWorkHeaderModel.h
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTWorkModel;

@interface HTWorkHeaderModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *Relatedcatid;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<HTWorkModel *> *data;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *can;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *isMajor;

@end

@interface HTWorkModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *alternatives;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *answer;

@end

