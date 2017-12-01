//
//  HTMatriculateRecordTypeModel.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateRecordTypeModel.h"
#import "HTMatriculateRecordModel.h"

@implementation HTMatriculateRecordTypeModel

+ (NSArray <HTMatriculateRecordTypeModel *> *)packModelArrayWithResponse:(id)response {
    HTMatriculateRecordModel *model = [HTMatriculateRecordModel mj_objectWithKeyValues:response];
    NSString *typeKey = @"typeKey";
    NSString *titleNameKey = @"titleNameKey";
    NSString *imageNameKey = @"imageNameKey";
    NSString *showDetailKey = @"showDetailKey";
    NSArray *keyValueArray = @[
                               @{typeKey:@(HTMatriculateRecordTypeAll), titleNameKey:@"选校测评", imageNameKey:@"cn_mine_matriculate_all_school", showDetailKey:@(model.schoolTest.count)},
                               @{typeKey:@(HTMatriculateRecordTypeSingle), titleNameKey:@"学校录取测评", imageNameKey:@"cn_mine_matriculate_single_school", showDetailKey:@(model.probabilityTest.count)},
                               ];
    NSMutableArray *modelArray = [@[] mutableCopy];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
        HTMatriculateRecordTypeModel *model = [[HTMatriculateRecordTypeModel alloc] init];
        model.titleName = dictionary[titleNameKey];
        model.type = [dictionary[typeKey] integerValue];
        model.imageName = dictionary[imageNameKey];
        model.showDetail = [dictionary[showDetailKey] boolValue];
        [modelArray addObject:model];
    }];
    return modelArray;
}

@end
