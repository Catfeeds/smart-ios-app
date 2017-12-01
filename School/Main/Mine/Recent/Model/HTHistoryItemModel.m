//
//  HTHistoryItemModel.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTHistoryItemModel.h"

@implementation HTHistoryItemModel

+ (NSArray <HTHistoryItemModel *> *)packModelArray {
	NSString *itemTypeKey = @"itemTypeKey";
	NSString *itemTitleKey = @"itemTitleKey";
	NSMutableArray *modelArray = [@[] mutableCopy];
	NSArray *keyValueArray = @[
							     @{itemTypeKey:@(HTUserHistoryTypeSchoolDetail), itemTitleKey:@"学校"},
								 @{itemTypeKey:@(HTUserHistoryTypeProfessionalDetail), itemTitleKey:@"专业"},
								 @{itemTypeKey:@(HTUserHistoryTypeAnswerDetail), itemTitleKey:@"问答"},
								 @{itemTypeKey:@(HTUserHistoryTypeActivityDetail), itemTitleKey:@"活动"},
								 @{itemTypeKey:@(HTUserHistoryTypeLibraryDetail), itemTitleKey:@"知识库"},
							 ];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
		HTHistoryItemModel *model = [[HTHistoryItemModel alloc] init];
		model.type = [dictionary[itemTypeKey] integerValue];
		model.title = dictionary[itemTitleKey];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
