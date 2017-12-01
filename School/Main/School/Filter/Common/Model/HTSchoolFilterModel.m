//
//  HTSchoolFilterModel.m
//  School
//
//  Created by hublot on 2017/7/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolFilterModel.h"

@implementation HTSchoolFilterModel


+ (NSDictionary *)objectClassInArray{
    return @{@"country" : [HTFilterCountryModel class], @"major" : [HTFilterMajorModel class], @"rank" : [HTFilterRankModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
	NSMutableArray <HTDropBoxProtocol> *filterSelectedModelArray = [@[] mutableCopy];
	NSString *filterTypeKey = @"filterTypeKey";
	NSString *modelArrayKey = @"modelArrayKey";
	NSString *titleNameKey = @"titleNameKey";
	NSString *selectedIndexKey = @"selectedIndexKey";
	NSArray *keyValue = @[
							  @{filterTypeKey:@(HTFilterTypeCountry), modelArrayKey:self.country, titleNameKey:@"所在国家", selectedIndexKey:@(0)},
							  @{filterTypeKey:@(HTFilterTypeRank), modelArrayKey:self.rank, titleNameKey:@"综合排名", selectedIndexKey:@(0)},
							  @{filterTypeKey:@(HTFilterTypeMajor), modelArrayKey:self.major, titleNameKey:@"专业方向", selectedIndexKey:@(0)},
						  ];
	[keyValue enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
		HTSchoolFilterSelectedModel *model = [[HTSchoolFilterSelectedModel alloc] init];
		model.type = [dictionary[filterTypeKey] integerValue];
		model.title = dictionary[titleNameKey];
		NSMutableArray <HTDropBoxProtocol> *array = dictionary[modelArrayKey];
		model.selectedModelArray = array;
		[filterSelectedModelArray addObject:model];
	}];
	self.filterModelArray = filterSelectedModelArray;
}

@end

@implementation HTSelectedModel


@end


@implementation HTFilterCountryModel

- (NSMutableArray<HTDropBoxProtocol> *)selectedModelArray {
	return [@[] mutableCopy];
}

+ (void)load {
	[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
		return @{@"title":@"name"};
	}];
}

@end


@implementation HTFilterMajorModel

+ (void)load {
	[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
		return @{@"title":@"name"};
	}];
}

- (NSMutableArray <HTDropBoxProtocol> *)selectedModelArray {
	return self.child;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"child" : [HTFilterProfessionalModel class]};
}

@end


@implementation HTFilterProfessionalModel

+ (void)load {
	[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
		return @{@"title":@"name"};
	}];
}

- (NSMutableArray <HTDropBoxProtocol> *)selectedModelArray {
	return [@[] mutableCopy];
}

@end


@implementation HTFilterRankModel

+ (void)load {
	[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
		return @{@"title":@"name"};
	}];
}

- (NSMutableArray <HTDropBoxProtocol> *)selectedModelArray {
	return [@[] mutableCopy];
}

@end

@implementation HTSchoolFilterSelectedModel

@end
