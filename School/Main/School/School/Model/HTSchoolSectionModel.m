//
//  HTSchoolSectionModel.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolSectionModel.h"
#import "HTSchoolSectionHeaderView.h"
#import "HTSchoolTextCell.h"
#import "HTSchoolBaseDataCell.h"
#import "HTSchoolMajorCell.h"

@implementation HTSchoolSectionModel

+ (NSArray *)packModelArrayWithSchoolModel:(HTSchoolModel *)schoolModel {
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
								   @{typeNameKey:@(HTSchoolSectionTypeBaseInformation), headerClassKey:NSStringFromClass([HTSchoolSectionHeaderView class]), cellClassKey:NSStringFromClass([HTSchoolTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(10), titleNameKey:@"基本信息", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[schoolModel.schoolInformationAttributedString]},
								   @{typeNameKey:@(HTSchoolSectionTypeDescription), headerClassKey:NSStringFromClass([HTSchoolSectionHeaderView class]), cellClassKey:NSStringFromClass([HTSchoolTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(10), titleNameKey:@"学校简介", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[schoolModel.schoolDescriptionAttributedString]},
								   @{typeNameKey:@(HTSchoolSectionTypeBaseData), headerClassKey:NSStringFromClass([HTSchoolSectionHeaderView class]), cellClassKey:NSStringFromClass([HTSchoolBaseDataCell class]), headerHeightKey:@(40), cellHeigithKey:@(60), footerHeightKey:@(10), titleNameKey:@"基本数据", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:schoolModel.baseDataArray},
								   @{typeNameKey:@(HTSchoolSectionTypeMajorList), headerClassKey:NSStringFromClass([HTSchoolSectionHeaderView class]), cellClassKey:NSStringFromClass([HTSchoolMajorCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(30), titleNameKey:@"基本数据", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[schoolModel.major]},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTSchoolSectionModel *model = [[HTSchoolSectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.headerClass = NSClassFromString(dictionary[headerClassKey]);
		model.cellClass = NSClassFromString(dictionary[cellClassKey]);
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
