//
//  HTSchoolFilterModel.h
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTDropBoxProtocol.h"

@class HTFilterCountryModel,HTFilterMajorModel,HTFilterProfessionalModel,HTFilterRankModel, HTSchoolFilterSelectedModel;

typedef NS_ENUM(NSInteger, HTFilterType) {
	HTFilterTypeCountry,
	HTFilterTypeRank,
	HTFilterTypeMajor,
};

@interface HTSchoolFilterModel : NSObject

@property (nonatomic, strong) NSMutableArray <HTFilterCountryModel *> *country;

@property (nonatomic, strong) NSMutableArray <HTFilterMajorModel *> *major;

@property (nonatomic, strong) NSMutableArray <HTFilterRankModel *> *rank;



@property (nonatomic, strong) NSArray <HTDropBoxProtocol> *filterModelArray;

@end



@interface HTSelectedModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@end



@interface HTFilterCountryModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *isMajor;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *pid;


@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@end

@interface HTFilterMajorModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *isMajor;

@property (nonatomic, strong) NSMutableArray <HTDropBoxProtocol> *child;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@property (nonatomic, strong) NSMutableArray <HTDropBoxProtocol> *selectedModelArray;

@end

@interface HTFilterProfessionalModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *isMajor;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@end

@interface HTFilterRankModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *isShow;

@property (nonatomic, copy) NSString *secondClass;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *isMajor;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@end




@interface HTSchoolFilterSelectedModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, assign) HTFilterType type;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@property (nonatomic, strong) NSMutableArray <HTDropBoxProtocol> *selectedModelArray;

@end
