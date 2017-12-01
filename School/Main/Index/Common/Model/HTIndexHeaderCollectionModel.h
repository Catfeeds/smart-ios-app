//
//  HTIndexHeaderCollectionModel.h
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTIndexHeaderCollectionModel.h"

typedef NS_ENUM(NSInteger, HTIndexHeaderCollectionItemType) {
	HTIndexHeaderCollectionItemTypeSchool,
	HTIndexHeaderCollectionItemTypeRank,
	HTIndexHeaderCollectionItemTypeMajor,
	HTIndexHeaderCollectionItemTypeLibrary,
	HTIndexHeaderCollectionItemTypeMatriculate,
	HTIndexHeaderCollectionItemTypeWork,
	HTIndexHeaderCollectionItemTypeOrganization,
	HTIndexHeaderCollectionItemTypeAdvisor,
};

@interface HTIndexHeaderCollectionModel : NSObject

@property (nonatomic, assign) HTIndexHeaderCollectionItemType type;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *titleName;

+ (NSArray <HTIndexHeaderCollectionModel *> *)packModelArray;

@end
