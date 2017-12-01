//
//  HTIndexModel.m
//  School
//
//  Created by hublot on 2017/7/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexModel.h"
#import "HTIndexSchoolIndexCell.h"
#import "HTIndexExampleIndexCell.h"
#import "HTIndexBookIndexCell.h"
#import "HTIndexActivityIndexCell.h"
#import "HTDiscoverActivityModel.h"

@implementation HTIndexModel


+ (NSDictionary *)objectClassInArray{
    return @{@"activity" : [HTIndexActivity class], @"schools" : [HTIndexSchools class], @"document" : [HTIndexDocument class], @"specialColumn" : [HTDiscoverActivityModel class], @"banner" : [HTIndexBanner class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	self.headerModelArray = [@[] mutableCopy];
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
								   @{typeNameKey:@(HTIndexHeaderTypeSchool), headerClassKey:NSStringFromClass([HTIndexSectionHeaderView class]), cellClassKey:NSStringFromClass([HTIndexSchoolIndexCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"特色学校推荐", imageNameKey:@"cn2_index_school_header_left", separatorLineHiddenKey:@(false), modelArrayKey:self.schools},
								   @{typeNameKey:@(HTIndexHeaderTypeActivity), headerClassKey:NSStringFromClass([HTIndexSectionHeaderView class]), cellClassKey:NSStringFromClass([HTIndexActivityIndexCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"特色活动推荐", imageNameKey:@"cn2_index_activity_header_left", separatorLineHiddenKey:@(false), modelArrayKey:self.activity},
//								   @{typeNameKey:@(HTIndexHeaderTypeExample), headerClassKey:NSStringFromClass([HTIndexSectionHeaderView class]), cellClassKey:NSStringFromClass([HTIndexExampleIndexCell class]), headerHeightKey:@(0), cellHeigithKey:@(80), footerHeightKey:@(0), titleNameKey:@"", imageNameKey:@"", separatorLineHiddenKey:@(false), modelArrayKey:@[@""]},
								   @{typeNameKey:@(HTIndexHeaderTypeBook), headerClassKey:NSStringFromClass([HTIndexSectionHeaderView class]), cellClassKey:NSStringFromClass([HTIndexBookIndexCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"特色文书服务", imageNameKey:@"cn2_index_document_header_left", separatorLineHiddenKey:@(false), modelArrayKey:self.document},
								   @{typeNameKey:@(HTIndexHeaderTypeForYou), headerClassKey:NSStringFromClass([HTIndexSectionHeaderView class]), cellClassKey:NSStringFromClass([HTIndexExampleIndexCell class]), headerHeightKey:@(40), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"为你推荐", imageNameKey:@"cn2_index_recommend_header_left", separatorLineHiddenKey:@(true), modelArrayKey:@[]},
							 ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTIndexHeaderModel *model = [[HTIndexHeaderModel alloc] init];
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
		model.modelArray = array.count ? @[array] : @[];
		[modelArray addObject:model];
	}];
	self.headerModelArray = modelArray;
}






@end

@implementation HTIndexHeaderModel

@end


@implementation HTIndexActivity

@end


@implementation HTIndexSchools

@end


@implementation HTIndexDocument

@end


@implementation HTIndexBanner

@end


