//
//  HTExampleSectionModel.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTExampleSectionModel.h"
#import "HTExampleSectionHeaderView.h"
#import "HTDiscoverExampleContentCell.h"
#import "HTDiscoverExampleModel.h"

@implementation HTExampleSectionModel

+ (NSArray *)packModelArrayWithResponse:(id)response {
	NSMutableArray *hotModelArray = [HTDiscoverExampleModel mj_objectArrayWithKeyValuesArray:response[@"hot"]];
	hotModelArray = hotModelArray ? hotModelArray : [@[] mutableCopy];
	
	NSString *typeNameKey = @"typeNameKey";
	NSString *headerClassKey = @"headerClassKey";
	NSString *cellClassKey = @"cellClassKey";
	NSString *headerHeightKey = @"headerHeightKey";
	NSString *cellHeigithKey = @"cellHeigithKey";
	NSString *footerHeightKey = @"footerHeightKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *separatorLineHiddenKey = @"separatorLineHiddenKey";
	NSString *modelArrayKey = @"modelArrayKey";
	NSArray *keyValueArray = @[
							   	@{typeNameKey:@(HTExampleSectionTypeHot), headerClassKey:NSStringFromClass([HTExampleSectionHeaderView class]), cellClassKey:NSStringFromClass([HTDiscoverExampleContentCell class]), headerHeightKey:@(50), cellHeigithKey:@(130), footerHeightKey:@(0), titleNameKey:@"热门案例", imageNameKey:@"", separatorLineHiddenKey:@(true), modelArrayKey:hotModelArray},
							   	@{typeNameKey:@(HTExampleSectionTypeSuccess), headerClassKey:NSStringFromClass([HTExampleSectionHeaderView class]), cellClassKey:NSStringFromClass([HTDiscoverExampleContentCell class]), headerHeightKey:@(50), cellHeigithKey:@(130), footerHeightKey:@(0), titleNameKey:@"成功案例", imageNameKey:@"", separatorLineHiddenKey:@(true), modelArrayKey:@[]},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTExampleSectionModel *model = [[HTExampleSectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.headerClass = NSClassFromString(dictionary[headerClassKey]);
		model.cellClass = NSClassFromString(dictionary[cellClassKey]);
		model.headerHeight = [dictionary[headerHeightKey] floatValue];
		model.cellHeigith = [dictionary[cellHeigithKey] floatValue];
		model.footerHeight = [dictionary[footerHeightKey] floatValue];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.separatorLineHidden = [dictionary[separatorLineHiddenKey] boolValue];
		
		NSArray *array = dictionary[modelArrayKey];
		model.modelArray = array;
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
