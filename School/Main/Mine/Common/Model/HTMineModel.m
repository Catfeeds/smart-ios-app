//
//  HTMineModel.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMineModel.h"

@implementation HTMineModel

//之前的
+ (NSArray <HTMineModel *> *)packModelArray {
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *modelTypeKey = @"modelTypeKey";
	NSString *controllerClassKey = @"controllerClassKey";
	NSArray *keyValueArray = @[
							   //							   	 @{modelTypeKey:@(HTMineTypeMatriculate), titleNameKey:@"我的测评", imageNameKey:@"cn_mine_matriculate", controllerClassKey:NSStringFromClass([NSObject class])},
							   //							     @{modelTypeKey:@(HTMineTypeRecent), titleNameKey:@"最近浏览", imageNameKey:@"cn_mine_recent", controllerClassKey:NSStringFromClass([NSObject class])},
							   //								 @{modelTypeKey:@(HTMineTypeInformation), titleNameKey:@"个人资料", imageNameKey:@"cn_mine_information", controllerClassKey:NSStringFromClass([NSObject class])},
							   //								 @{modelTypeKey:@(HTMineTypeService), titleNameKey:@"我需要服务", imageNameKey:@"cn_mine_service", controllerClassKey:NSStringFromClass([NSObject class])},
							   //								 @{modelTypeKey:@(HTMineTypeMoney), titleNameKey:@"钱包", imageNameKey:@"cn_mine_money", controllerClassKey:NSStringFromClass([NSObject class])},
							   @{modelTypeKey:@(HTMineTypeIssue), titleNameKey:@"意见反馈", imageNameKey:@"cn_mine_issue", controllerClassKey:NSStringFromClass([NSObject class])},
							   @{modelTypeKey:@(HTMineTypeGood), titleNameKey:@"给个好评", imageNameKey:@"cn_mine_good", controllerClassKey:NSStringFromClass([NSObject class])},
							   ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTMineModel *model = [[HTMineModel alloc] init];
		model.type = [dictionary[modelTypeKey] integerValue];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.controllerClass = NSClassFromString(dictionary[controllerClassKey]);
		[modelArray addObject:model];
	}];
	return modelArray;
}

+ (NSArray <HTMineModel *> *)itemArrayWithSectionIndex:(NSInteger)index {
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *modelTypeKey = @"modelTypeKey";
	NSString *controllerClassKey = @"controllerClassKey";
	NSArray *keyValueArray = nil;
	if (index == 0){
		keyValueArray = @[
						  @{modelTypeKey:@(HTMineTypeMatriculate), titleNameKey:@"我的测评", imageNameKey:@"cn_mine_matriculate", controllerClassKey:NSStringFromClass([NSObject class])},
						  @{modelTypeKey:@(HTMineTypeRecent), titleNameKey:@"最近阅览", imageNameKey:@"cn_mine_recent", controllerClassKey:NSStringFromClass([NSObject class])},
						  ];
	}else if (index == 1){
		keyValueArray = @[
						  @{modelTypeKey:@(HTMineTypeInformation), titleNameKey:@"个人资料", imageNameKey:@"cn_mine_information", controllerClassKey:NSStringFromClass([NSObject class])},
						  @{modelTypeKey:@(HTMineTypeService), titleNameKey:@"我需要服务", imageNameKey:@"cn_mine_service", controllerClassKey:NSStringFromClass([NSObject class])},
						  ];
	}else if (index == 2){
		keyValueArray = @[
						  @{modelTypeKey:@(HTMineTypeIssue), titleNameKey:@"意见反馈", imageNameKey:@"cn_mine_issue", controllerClassKey:NSStringFromClass([NSObject class])},
						  @{modelTypeKey:@(HTMineTypeGood), titleNameKey:@"给个好评", imageNameKey:@"cn_mine_good", controllerClassKey:NSStringFromClass([NSObject class])},
						  ];
	}
	
	
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTMineModel *model = [[HTMineModel alloc] init];
		model.type = [dictionary[modelTypeKey] integerValue];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.controllerClass = NSClassFromString(dictionary[controllerClassKey]);
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
