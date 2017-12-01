//
//  HTMajorDetailModel.m
//  School
//
//  Created by hublot on 2017/9/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorDetailModel.h"
#import "HTMajorSectionHeaderView.h"
#import "HTMajorImageCell.h"
#import "HTMajorDetailCell.h"
#import "HTMajorSchoolCell.h"
#import "HTMajorCourseCell.h"
#import "HTMajorTextCell.h"

@implementation HTMajorDetailModel

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSArray *formModelArray = [HTMajorDetailFormModel packFormModelArrayWithDetailModel:self];
	NSArray *schoolModelArray = [HTMajorSchoolModel packSchoolModelArrayWithDetailModel:self];
	schoolModelArray = schoolModelArray ? schoolModelArray : @[];
	
	NSArray *courseModelArray = [self.trainer componentsSeparatedByString:@","];
	courseModelArray = courseModelArray ? courseModelArray : @[];
	
	
	
	NSMutableArray *sectionModelArray = [@[] mutableCopy];
	
	
	NSString *typeNameKey = @"typeNameKey";
	NSString *headerClassKey = @"headerClassKey";
	NSString *cellClassKey = @"cellClassKey";
	NSString *headerHeightKey = @"headerHeightKey";
	NSString *cellHeigithKey = @"cellHeigithKey";
	NSString *footerHeightKey = @"footerHeightKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *cellSeparatorHiddenKey = @"cellSeparatorHiddenKey";
	NSString *modelArrayKey = @"modelArrayKey";
	NSArray *keyValueArray = @[
								   @{typeNameKey:@(HTMajorSectionTypeImage), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorImageCell class]), headerHeightKey:@(0), cellHeigithKey:@(150), footerHeightKey:@(0), titleNameKey:@"", cellSeparatorHiddenKey:@(true), modelArrayKey:@[self]},
								   @{typeNameKey:@(HTMajorSectionTypeDetail), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorDetailCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"专业详情", cellSeparatorHiddenKey:@(true), modelArrayKey:formModelArray},
								   @{typeNameKey:@(HTMajorSectionTypeExplain), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"专业解释", cellSeparatorHiddenKey:@(true), modelArrayKey:@[HTPlaceholderString(self.numbering, @"")]},
								   @{typeNameKey:@(HTMajorSectionTypeRequire), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"适合申请人背景", cellSeparatorHiddenKey:@(true), modelArrayKey:@[HTPlaceholderString(self.sentenceNumber, @"")]},
								   @{typeNameKey:@(HTMajorSectionTypeSchool), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorSchoolCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"相关院校", cellSeparatorHiddenKey:@(true), modelArrayKey:@[schoolModelArray]},
								   @{typeNameKey:@(HTMajorSectionTypeOrientation), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorTextCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"专业开设课程", cellSeparatorHiddenKey:@(true), modelArrayKey:@[HTPlaceholderString(self.problemComplement, @"")]},
								   @{typeNameKey:@(HTMajorSectionTypeCourse), headerClassKey:NSStringFromClass([HTMajorSectionHeaderView class]), cellClassKey:NSStringFromClass([HTMajorCourseCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"专业课程方向", cellSeparatorHiddenKey:@(true), modelArrayKey:@[courseModelArray]},
							 ];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTMajorSectionModel *model = [[HTMajorSectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.headerClass = NSClassFromString(dictionary[headerClassKey]);
		model.cellClass = NSClassFromString(dictionary[cellClassKey]);
		model.headerHeight = [dictionary[headerHeightKey] floatValue];
		model.cellHeigith = [dictionary[cellHeigithKey] floatValue];
		model.footerHeight = [dictionary[footerHeightKey] floatValue];
		model.titleName = dictionary[titleNameKey];
		model.cellSeparatorHidden = [dictionary[cellSeparatorHiddenKey] boolValue];
		
		model.modelArray = dictionary[modelArrayKey];
		[sectionModelArray addObject:model];
	}];
	self.sectionModelArray = sectionModelArray;
	
	
}

@end


@implementation HTMajorSectionModel

@end




@implementation HTMajorDetailFormModel

+ (NSArray *)packFormModelArrayWithDetailModel:(HTMajorDetailModel *)model {
	NSString *titleNameKey = @"titleNameKey";
	NSString *detailNameKey = @"detailNameKey";
	NSArray *keyValueArray = @[
							     @{titleNameKey:@"开设学位", detailNameKey:HTPlaceholderString(model.answer, @"")},
								 @{titleNameKey:@"就业方向", detailNameKey:HTPlaceholderString(model.alternatives, @"")},
								 @{titleNameKey:@"从事职业", detailNameKey:HTPlaceholderString(model.article, @"")},
								 @{titleNameKey:@"相关证书", detailNameKey:HTPlaceholderString(model.listeningFile, @"")},
								 @{titleNameKey:@"相关排名", detailNameKey:HTPlaceholderString(model.cnName, @"")},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTMajorDetailFormModel *formModel = [[HTMajorDetailFormModel alloc] init];
		formModel.titleName = dictionary[titleNameKey];
		formModel.detailName = dictionary[detailNameKey];
		[modelArray addObject:formModel];
	}];
	return modelArray;
}

@end



@implementation HTMajorSchoolModel

+ (NSArray *)packSchoolModelArrayWithDetailModel:(HTMajorDetailModel *)model {
	NSArray *titleNameArray = [model.duration componentsSeparatedByString:@","];
	NSMutableArray *schoolModelArray = [@[] mutableCopy];
	[titleNameArray enumerateObjectsUsingBlock:^(NSString *titleName, NSUInteger index, BOOL * _Nonnull stop) {
		HTMajorSchoolModel *schoolModel = [[HTMajorSchoolModel alloc] init];
		schoolModel.titleName = titleName;
		if (index == 0) {
			schoolModel.isHotSchool = true;
		}
		[schoolModelArray addObject:schoolModel];
	}];
	return schoolModelArray;
}

@end
