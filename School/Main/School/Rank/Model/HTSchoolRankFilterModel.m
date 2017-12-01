//
//  HTSchoolRankFilterModel.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolRankFilterModel.h"

@implementation HTSchoolRankFilterModel

+ (NSArray *)packModelArray {
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *rankTypeKey = @"rankTypeKey";
	NSString *inputTypeKey = @"inputTypeKey";
	NSArray *keyValueArray = @[@{titleNameKey:@"排名类型", imageNameKey:@"cn_school_rank", rankTypeKey:@(HTSchoolRankFilterTypeCategory), inputTypeKey:@(HTSchoolRankInputTypeSelected)},
							   @{titleNameKey:@"年   份", imageNameKey:@"cn2_school_rank_year", rankTypeKey:@(HTSchoolRankFilterTypeYear), inputTypeKey:@(HTSchoolRankInputTypePicker)},];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSchoolRankFilterModel *model = [[HTSchoolRankFilterModel alloc] init];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.type = [dictionary[rankTypeKey] integerValue];
		model.inputType = [dictionary[inputTypeKey] integerValue];
		model.modelArray = [HTSchoolRankSelectedModel packSelectedModelArrayForRankType:model.type];
		[modelArray addObject:model];
	}];
	return modelArray;
}

- (NSInteger)selectedIndex {
	__block NSInteger selectedIndex = - 1;
	[self.modelArray enumerateObjectsUsingBlock:^(HTSchoolRankSelectedModel *selectedModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (selectedModel.isSelected) {
			selectedIndex = index;
			*stop = true;
		}
	}];
	return selectedIndex;
}

@end

@implementation HTSchoolRankSelectedModel

+ (NSArray *)packSelectedModelArrayForRankType:(HTSchoolRankFilterType)type {
	NSString *titleNameKey = @"titleNameKey";
	NSString *selectedIDKey = @"selectedIDKey";
	NSString *isSelectedKey = @"isSelectedKey";
	NSArray *keyValueArray;
	NSMutableArray *modelArray = [@[] mutableCopy];
	switch (type) {
		case HTSchoolRankFilterTypeCategory: {
			
			break;
		}
		case HTSchoolRankFilterTypeYear: {
			keyValueArray = @[@{titleNameKey:@"2018", selectedIDKey:@"427", isSelectedKey:@(true)},
							  @{titleNameKey:@"2017", selectedIDKey:@"308", isSelectedKey:@(false)},
							  @{titleNameKey:@"2016", selectedIDKey:@"307", isSelectedKey:@(false)},];
			break;
		}
	}
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSchoolRankSelectedModel *model = [[HTSchoolRankSelectedModel alloc] init];
		model.name = dictionary[titleNameKey];
		model.ID = dictionary[selectedIDKey];
		model.isSelected = [dictionary[isSelectedKey] boolValue];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
