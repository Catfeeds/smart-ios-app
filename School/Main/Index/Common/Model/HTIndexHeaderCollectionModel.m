//
//  HTIndexHeaderCollectionModel.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexHeaderCollectionModel.h"

@implementation HTIndexHeaderCollectionModel

+ (NSArray <HTIndexHeaderCollectionModel *> *)packModelArray {
	NSString *typeNameKey = @"typeNameKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSArray *response = @[
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeSchool), titleNameKey:@"查院校", imageNameKey:@"cn2_index_collection_school"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeRank), titleNameKey:@"看排名", imageNameKey:@"cn2_index_collection_rank"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeMajor), titleNameKey:@"专业库", imageNameKey:@"cn2_index_collection_major"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeLibrary), titleNameKey:@"Mentor课程", imageNameKey:@"cn2_index_collection_library"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeMatriculate), titleNameKey:@"选校匹配", imageNameKey:@"cn_index_collection_matricuclate"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeWork), titleNameKey:@"找实习", imageNameKey:@"cn_index_collection_work"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeOrganization), titleNameKey:@"找中介", imageNameKey:@"cn_index_collection_organization"},
							@{typeNameKey:@(HTIndexHeaderCollectionItemTypeAdvisor), titleNameKey:@"留学商城", imageNameKey:@"cn_index_collection_advisor"},
						];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[response enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTIndexHeaderCollectionModel *model = [[HTIndexHeaderCollectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
