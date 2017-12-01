//
//  HTMajorDetailModel.h
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTMajorSectionModel;

@interface HTMajorDetailModel : NSObject

@property (nonatomic, copy) NSString *catName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *alternatives;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *numbering;

@property (nonatomic, copy) NSString *problemComplement;

@property (nonatomic, copy) NSString *catId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sentenceNumber;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *show;

@property (nonatomic, copy) NSString *article;

@property (nonatomic, copy) NSString *trainer;

@property (nonatomic, copy) NSString *fabulous;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *listeningFile;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) NSArray <HTMajorSectionModel *> *sectionModelArray;

@end







typedef NS_ENUM(NSInteger, HTMajorSectionType) {
	HTMajorSectionTypeImage,
	HTMajorSectionTypeDetail,
	HTMajorSectionTypeExplain,
	HTMajorSectionTypeRequire,
	HTMajorSectionTypeSchool,
	HTMajorSectionTypeOrientation,
	HTMajorSectionTypeCourse,
};

@interface HTMajorSectionModel : NSObject

@property (nonatomic, assign) HTMajorSectionType type;

@property (nonatomic, assign) Class headerClass;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat cellHeigith;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, assign) BOOL cellSeparatorHidden;

@property (nonatomic, strong) NSArray *modelArray;

@end

@interface HTMajorDetailFormModel : NSObject

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *detailName;

+ (NSArray *)packFormModelArrayWithDetailModel:(HTMajorDetailModel *)model;

@end



@interface HTMajorSchoolModel : NSObject

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, assign) BOOL isHotSchool;

+ (NSArray *)packSchoolModelArrayWithDetailModel:(HTMajorDetailModel *)model;

@end
