//
//  HTGossIPItemModel.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTGossIPItemModel.h"

@implementation HTGossIPItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"titleName" : @"name",
			 @"catIdString" : @"id"
			 };
}

+ (NSArray *)packModelArray {
	NSString *titleNameKey = @"titleNameKey";
	NSString *typeNameKey = @"typeNameKey";
	NSString *catIdStringKey = @"catIdStringKey";
	NSArray *keyValueArray = @[
							   	 @{typeNameKey:@(HTGossIPItemTypeSum), titleNameKey:@"全部", catIdStringKey:@"14"},
							 	 @{typeNameKey:@(HTGossIPItemTypeSchool), titleNameKey:@"学校项目", catIdStringKey:@"20"},
								 @{typeNameKey:@(HTGossIPItemTypeWork), titleNameKey:@"实习资源", catIdStringKey:@"21"},
								 @{typeNameKey:@(HTGossIPItemTypeCircel), titleNameKey:@"圈子大事", catIdStringKey:@"22"},
								 @{typeNameKey:@(HTGossIPItemTypeCourse), titleNameKey:@"留学课程", catIdStringKey:@"23"},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTGossIPItemModel *model = [[HTGossIPItemModel alloc] init];
	//	model.type = [dictionary[typeNameKey] integerValue];
		model.titleName = dictionary[titleNameKey];
		model.catIdString = dictionary[catIdStringKey];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
