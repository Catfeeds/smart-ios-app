//
//  HTMatriculateResultSectionModel.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateResultSectionModel.h"
#import "HTMatriculateResultSectionHeaderView.h"
#import "HTMatriculateResultAnalysisCell.h"
#import "HTMatriculateResultAnalysisFooterView.h"
#import "HTMatriculateResultAnalysisModel.h"
#import "HTSchoolCell.h"
#import "HTSchoolModel.h"

@implementation HTMatriculateResultSectionModel

+ (NSArray *)packModelArrayWithResponse:(id)response {
	NSMutableArray *analysisModelArray = [@[] mutableCopy];
	NSDictionary *dictionary = response[@"score"];
	__block NSInteger schoolIndex;
	[dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *value, BOOL * _Nonnull stop) {
		if ([value isKindOfClass:[NSDictionary class]]) {
			HTMatriculateResultAnalysisModel *model = [HTMatriculateResultAnalysisModel mj_objectWithKeyValues:value];
			if ([key isEqualToString:@"school"]) {
				model.score = [NSString stringWithFormat:@"%@院校", model.name];
				model.name = @"院校背景";
				schoolIndex = analysisModelArray.count;
			}
			[analysisModelArray addObject:model];
		}
	}];
	[analysisModelArray exchangeObjectAtIndex:0 withObjectAtIndex:schoolIndex];
	analysisModelArray = analysisModelArray ? analysisModelArray : [@[] mutableCopy];
	
	NSMutableArray *schoolModelArray = [HTSchoolModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"res"]];
	[schoolModelArray enumerateObjectsUsingBlock:^(HTSchoolModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
		model.answer = HTPlaceholderString(model.place, @"");
	}];
	schoolModelArray = schoolModelArray ? schoolModelArray : [@[] mutableCopy];
	
	NSString *typeNameKey = @"typeNameKey";
	NSString *headerClassKey = @"headerClassKey";
	NSString *footerClassKey = @"footerClassKey";
	NSString *cellClassKey = @"cellClassKey";
	NSString *headerHeightKey = @"headerHeightKey";
	NSString *cellHeigithKey = @"cellHeigithKey";
	NSString *footerHeightKey = @"footerHeightKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *separatorLineHiddenKey = @"separatorLineHiddenKey";
	NSString *modelArrayKey = @"modelArrayKey";
	NSArray *keyValueArray = @[
							 	 @{typeNameKey:@(HTMatriculateResultSectionTypeAnalysis), headerClassKey:NSStringFromClass([HTMatriculateResultSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMatriculateResultAnalysisCell class]), footerClassKey:NSStringFromClass([HTMatriculateResultAnalysisFooterView class]), headerHeightKey:@(35), cellHeigithKey:@(0), footerHeightKey:@(210), titleNameKey:@"背景条件分析", imageNameKey:@"", separatorLineHiddenKey:@(true), modelArrayKey:analysisModelArray},
								 @{typeNameKey:@(HTMatriculateResultSectionTypeSchool), headerClassKey:NSStringFromClass([HTMatriculateResultSectionHeaderView class]), cellClassKey:NSStringFromClass([HTSchoolCell class]), footerClassKey:NSStringFromClass([HTMatriculateResultAnalysisFooterView class]),headerHeightKey:@(35), cellHeigithKey:@(120), footerHeightKey:@(0), titleNameKey:@"以下是你的选校报告", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:schoolModelArray},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTMatriculateResultSectionModel *model = [[HTMatriculateResultSectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.headerClass = NSClassFromString(dictionary[headerClassKey]);
		model.cellClass = NSClassFromString(dictionary[cellClassKey]);
		model.footerClass = NSClassFromString(dictionary[footerClassKey]);
		model.headerHeight = [dictionary[headerHeightKey] floatValue];
		model.cellHeigith = [dictionary[cellHeigithKey] floatValue];
		model.footerHeight = [dictionary[footerHeightKey] floatValue];
		model.titleName = dictionary[titleNameKey];
		model.imageName = dictionary[imageNameKey];
		model.separatorLineHidden = [dictionary[separatorLineHiddenKey] boolValue];
		model.modelArray = dictionary[modelArrayKey];
		[modelArray addObject:model];
	}];
	return modelArray;
}

@end
