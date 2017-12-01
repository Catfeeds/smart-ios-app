//
//  HTMineModel.h
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTMineType) {
	HTMineTypeMatriculate,     
	HTMineTypeRecent,
	HTMineTypeInformation,
	HTMineTypeProgress,
	HTMineTypeService,
	HTMineTypeMoney,
	HTMineTypeIssue,
	HTMineTypeSeting,
	HTMineTypeGood
};

@interface HTMineModel : NSObject

@property (nonatomic, assign) HTMineType type;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, assign) Class controllerClass;

+ (NSArray <HTMineModel *> *)packModelArray;
+ (NSArray <HTMineModel *> *)itemArrayWithSectionIndex:(NSInteger)index;
@end
