//
//  HTOrganizationDetialModel.h
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTOrganizationDetailAdvisorModel, HTOrganizationSectionModel;

@interface HTOrganizationDetialModel : NSObject

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *alternatives;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, strong) NSArray <HTOrganizationDetailAdvisorModel *> *adviser;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *listeningFile;

@property (nonatomic, copy) NSString *userId;







@property (nonatomic, strong) NSArray <HTOrganizationSectionModel *> *headerModelArray;


@end






typedef NS_ENUM(NSInteger, HTOrganizationSectionType) {
	HTOrganizationSectionTypeBase,
	HTOrganizationSectionTypeCountry,
	HTOrganizationSectionTypeService,
	HTOrganizationSectionTypeAdvisor,
	HTOrganizationSectionTypeExample,
};

@interface HTOrganizationSectionModel : NSObject

@property (nonatomic, assign) HTOrganizationSectionType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, assign) BOOL cellSeparatorHidden;

@property (nonatomic, strong) NSArray *modelArray;

@end




























@interface HTOrganizationDetailAdvisorModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *answer;

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




@property (nonatomic, copy) NSAttributedString *attributedString;

@end

