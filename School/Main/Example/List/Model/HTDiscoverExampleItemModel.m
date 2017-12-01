//
//  HTDiscoverExampleItemModel.m
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverExampleItemModel.h"

@implementation HTDiscoverExampleItemModel

+ (NSArray <HTDiscoverExampleItemModel *> *)packModelArrayFromResponse:(NSDictionary *)response {
	if (![response isKindOfClass:[NSDictionary class]]) {
		return @[];
	}
	NSMutableArray *modelArray = [@[] mutableCopy];
	NSDictionary *catIdNameDictionary = @{@"282":@"美国留学", @"283":@"英国留学", @"284":@"澳洲加拿大", @"285":@"香港新加坡", @"286":@"欧洲国家"};
	NSArray *allCatIdArray = catIdNameDictionary.allKeys;
	NSString *otherCatIdNamePrefix = @"其他";
	__block NSInteger otherIndex = 1;
	[response enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *itemDictionary, BOOL * _Nonnull stop) {
		if ([itemDictionary isKindOfClass:[NSDictionary class]]) {
			NSString *catIdString = HTPlaceholderString([itemDictionary valueForKey:@"catId"], @"");
			NSString *catName = @"";
			if ([allCatIdArray containsObject:catIdString]) {
				catName = catIdNameDictionary[catIdString];
			} else {
				catName = [NSString stringWithFormat:@"%@%ld", otherCatIdNamePrefix, otherIndex];
				otherIndex ++;
			}
			HTDiscoverExampleItemModel *model = [[HTDiscoverExampleItemModel alloc] init];
			model.catId = catIdString;
			model.name = catName;
			[modelArray addObject:model];
		}
	}];
	return modelArray;
}

@end


