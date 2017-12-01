//
//  HTIndexModel.h
//  School
//
//  Created by hublot on 2017/7/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTIndexSectionHeaderView.h"

@class HTIndexActivity, HTIndexSchools, HTIndexDocument, HTDiscoverActivityModel, HTIndexBanner, HTIndexHeaderModel;

typedef NS_ENUM(NSInteger, HTIndexHeaderType) {
	HTIndexHeaderTypeSchool = 0,
	HTIndexHeaderTypeActivity,
	HTIndexHeaderTypeExample,
	HTIndexHeaderTypeBook,
	HTIndexHeaderTypeForYou,
};

@interface HTIndexModel : NSObject


@property (nonatomic, strong) NSArray<HTIndexActivity *> *activity;

@property (nonatomic, strong) NSArray<HTIndexSchools *> *schools;

@property (nonatomic, strong) NSArray<HTIndexDocument *> *document;

@property (nonatomic, strong) NSArray<HTDiscoverActivityModel *> *specialColumn;

@property (nonatomic, strong) NSArray<HTIndexBanner *> *banner;





















@property (nonatomic, strong) NSArray <HTIndexHeaderModel *> *headerModelArray;

@end


@interface HTIndexHeaderModel : NSObject

@property (nonatomic, assign) HTIndexHeaderType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) BOOL separatorLineHidden;

@property (nonatomic, strong) NSArray *modelArray;

@end





































@interface HTIndexActivity : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *alternatives;

@end

@interface HTIndexSchools : NSObject

@property (nonatomic, copy) NSString *ID;

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

@property (nonatomic, copy) NSString *cnName;

@end

@interface HTIndexDocument : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *originalPrice;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *name;

@end

@interface HTIndexBanner : NSObject

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

@end

