//
//  HTOrganizationModel.h
//  School
//
//  Created by hublot on 2017/8/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTOrganizationListType) {
	HTOrganizationListTypeSum,
	HTOrganizationListTypeGood,
};

@interface HTOrganizationModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *cnName;

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

@end
