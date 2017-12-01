//
//  HTSearchItemModel.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchItemModel.h"

@implementation HTSearchItemModel

+ (NSArray *)packModelArray {
	NSString *searchTypeKey = @"searchTypeKey";
	NSString *searchTitleKey = @"searchTitleKey";
	NSArray *keyValueArray = @[@{searchTypeKey:@(HTSearchTypeSchool), searchTitleKey:@"学校"},
							   @{searchTypeKey:@(HTSearchTypeProfessional), searchTitleKey:@"专业"},
							   @{searchTypeKey:@(HTSearchTypeAnswer), searchTitleKey:@"问答"},
							   @{searchTypeKey:@(HTSearchTypeActivity), searchTitleKey:@"活动"},
							   @{searchTypeKey:@(HTSearchTypeLibrary), searchTitleKey:@"知识库"}];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSearchItemModel *model = [[HTSearchItemModel alloc] init];
		model.type = [dictionary[searchTypeKey] integerValue];
		model.titleName = dictionary[searchTitleKey];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
