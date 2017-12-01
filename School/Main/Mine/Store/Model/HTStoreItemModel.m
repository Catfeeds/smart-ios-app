//
//  HTStoreItemModel.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStoreItemModel.h"

@implementation HTStoreItemModel

+ (NSArray <HTStoreItemModel *> *)packModelArray {
    NSString *itemTypeKey = @"itemTypeKey";
    NSString *itemTitleKey = @"itemTitleKey";
    NSMutableArray *modelArray = [@[] mutableCopy];
    NSArray *keyValueArray = @[
                               @{itemTypeKey:@(HTUserStoreTypeSchool), itemTitleKey:@"学校"},
                               @{itemTypeKey:@(HTUserStoreTypeProfessional), itemTitleKey:@"专业"},
                               @{itemTypeKey:@(HTUserStoreTypeAnswer), itemTitleKey:@"问答"},
                               @{itemTypeKey:@(HTUserStoreTypeActivity), itemTitleKey:@"活动"},
                               @{itemTypeKey:@(HTUserStoreTypeLibrary), itemTitleKey:@"知识库"},
                               ];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        HTStoreItemModel *model = [[HTStoreItemModel alloc] init];
        model.type = [dictionary[itemTypeKey] integerValue];
        model.title = dictionary[itemTitleKey];
        [modelArray addObject:model];
    }];
    return modelArray;
}

@end
