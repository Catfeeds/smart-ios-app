//
//  HTOrganizationDetialModel.m
//  School
//
//  Created by hublot on 2017/8/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationDetialModel.h"
#import "HTOrganizationSectionHeader.h"
#import "HTOrganizationDetailCell.h"
#import "HTOrganizationCountryCell.h"
#import "HTOrganizationTextCell.h"
#import "HTOrganizationAdvisorCell.h"

@implementation HTOrganizationDetialModel


+ (NSDictionary *)objectClassInArray{
    return @{@"adviser" : [HTOrganizationDetailAdvisorModel class]};
}


- (void)mj_keyValuesDidFinishConvertingToObject {
	NSArray *countryArray = [self.answer componentsSeparatedByString:@","];
	countryArray = countryArray ? countryArray : @[];
	
	self.adviser = self.adviser ? self.adviser : @[];
	self.alternatives = self.alternatives ? self.alternatives : @"";
	self.listeningFile = self.listeningFile ? self.listeningFile : @"";
	
	self.headerModelArray = [@[] mutableCopy];
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
							   @{typeNameKey:@(HTOrganizationSectionTypeBase), headerClassKey:NSStringFromClass([HTOrganizationSectionHeader class]), cellClassKey:NSStringFromClass([HTOrganizationDetailCell class]), headerHeightKey:@(0), cellHeigithKey:@(130), footerHeightKey:@(7.5), titleNameKey:@"", cellSeparatorHiddenKey:@(true), modelArrayKey:@[self]},
							   @{typeNameKey:@(HTOrganizationSectionTypeCountry), headerClassKey:NSStringFromClass([HTOrganizationSectionHeader class]), cellClassKey:NSStringFromClass([HTOrganizationCountryCell class]), headerHeightKey:@(45), cellHeigithKey:@(0), footerHeightKey:@(7.5), titleNameKey:@"办理国家", cellSeparatorHiddenKey:@(true), modelArrayKey:@[countryArray]},
							   @{typeNameKey:@(HTOrganizationSectionTypeService), headerClassKey:NSStringFromClass([HTOrganizationSectionHeader class]), cellClassKey:NSStringFromClass([HTOrganizationTextCell class]), headerHeightKey:@(45), cellHeigithKey:@(0), footerHeightKey:@(7.5), titleNameKey:@"核心服务介绍", cellSeparatorHiddenKey:@(true), modelArrayKey:@[self.alternatives]},
							   @{typeNameKey:@(HTOrganizationSectionTypeAdvisor), headerClassKey:NSStringFromClass([HTOrganizationSectionHeader class]), cellClassKey:NSStringFromClass([HTOrganizationAdvisorCell class]), headerHeightKey:@(45), cellHeigithKey:@(110), footerHeightKey:@(7.5), titleNameKey:@"顾问推荐", cellSeparatorHiddenKey:@(false), modelArrayKey:self.adviser},
							   @{typeNameKey:@(HTOrganizationSectionTypeExample), headerClassKey:NSStringFromClass([HTOrganizationSectionHeader class]), cellClassKey:NSStringFromClass([HTOrganizationTextCell class]), headerHeightKey:@(45), cellHeigithKey:@(0), footerHeightKey:@(0), titleNameKey:@"案例", cellSeparatorHiddenKey:@(true), modelArrayKey:@[self.listeningFile]},
							   ];
	NSMutableArray *modelArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTOrganizationSectionModel *model = [[HTOrganizationSectionModel alloc] init];
		model.type = [dictionary[typeNameKey] integerValue];
		model.headerClass = NSClassFromString(dictionary[headerClassKey]);
		model.cellClass = NSClassFromString(dictionary[cellClassKey]);
		model.headerHeight = [dictionary[headerHeightKey] floatValue];
		model.cellHeigith = [dictionary[cellHeigithKey] floatValue];
		model.footerHeight = [dictionary[footerHeightKey] floatValue];
		model.titleName = dictionary[titleNameKey];
		model.cellSeparatorHidden = [dictionary[cellSeparatorHiddenKey] boolValue];
		
		NSArray *array = dictionary[modelArrayKey];
		model.modelArray = array.count ? array : @[];
		[modelArray addObject:model];
	}];
	self.headerModelArray = modelArray;
}


@end

@implementation HTOrganizationSectionModel

@end

@implementation HTOrganizationDetailAdvisorModel

@end


