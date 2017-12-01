//
//  HTProfessionalSectionModel.m
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTProfessionalSectionModel.h"
#import "HTProfessionalSectionHeaderView.h"
#import "HTProfessionalTextCell.h"
#import "HTProfessionalRequireCell.h"

@implementation HTProfessionalSectionModel

+ (NSArray *)packModelArrayWithProfessionalModel:(HTProfessionalModel *)professionalModel {
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
							   @{typeNameKey:@(HTProfessionalSectionTypeBase), headerClassKey:NSStringFromClass([HTProfessionalSectionHeaderView class]), cellClassKey:NSStringFromClass([HTProfessionalTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"基本情况", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[professionalModel.professionalBaseAttributedString]},
							   @{typeNameKey:@(HTProfessionalSectionTypeRequire), headerClassKey:NSStringFromClass([HTProfessionalSectionHeaderView class]), cellClassKey:NSStringFromClass([HTProfessionalRequireCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(10), titleNameKey:@"申请要求", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[professionalModel]},
							   @{typeNameKey:@(HTProfessionalSectionTypeDecription), headerClassKey:NSStringFromClass([HTProfessionalSectionHeaderView class]), cellClassKey:NSStringFromClass([HTProfessionalTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"申请说明", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[professionalModel.professionalApplyAttributedString]},
							   @{typeNameKey:@(HTProfessionalSectionTypeLink), headerClassKey:NSStringFromClass([HTProfessionalSectionHeaderView class]), cellClassKey:NSStringFromClass([HTProfessionalTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"参考链接", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[professionalModel.professionalLinkAttributedString]},
							   ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTProfessionalSectionModel *model = [[HTProfessionalSectionModel alloc] init];
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
