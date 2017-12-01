//
//  HTMinePreferenceModel.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMinePreferenceModel.h"
#import "HTUserManager.h"
#import <HTCacheManager.h>

@implementation HTMinePreferenceModel

+ (NSArray <HTMinePreferenceModel *> *)packUserInformationModelArray {
    HTUser *user = [HTUserManager currentUser];
    NSString *titleNameKey = @"titleNameKey";
    NSString *modelInterfaceTypeKey = @"modelTypeKey";
    NSString *modelDataSourceTypeKey = @"modelDataSourceTypeKey";
    NSString *detailNameKey = @"detailNameKey";
    NSString *headImageKey = @"headImageKey";
    NSString *accessoryKey = @"accessoryKey";
    NSMutableArray *keyValueArray = [@[
                                         @{titleNameKey:@"个人信息", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeSectionTitle), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeDetail), detailNameKey:@"", headImageKey:@"",  accessoryKey:@(false)},
                                     ] mutableCopy];
    if (user.uid.integerValue > 0) {
        NSArray *appendArray = @[
                                     @{titleNameKey:@"头像", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeRightImage), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeHeadImage), detailNameKey:@"", headImageKey:user.image,  accessoryKey:@(false)},
                                     @{titleNameKey:@"昵称", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeNickname), detailNameKey:user.nickname, headImageKey:@"",  accessoryKey:@(true)},
                                     @{titleNameKey:@"电话", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypePhoneCode), detailNameKey:user.phone, headImageKey:@"",  accessoryKey:@(true)},
                                     @{titleNameKey:@"邮箱", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeEmailCode), detailNameKey:user.email, headImageKey:@"",  accessoryKey:@(true)},
                                     @{titleNameKey:@"密码", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypePassword), detailNameKey:user.password, headImageKey:@"",  accessoryKey:@(true)},
                                ];
        [keyValueArray addObjectsFromArray:appendArray];
    }
    NSArray *appendArray = @[
                                @{titleNameKey:@"问答标签", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeAnswerTag), detailNameKey:@"", headImageKey:@"",  accessoryKey:@(true)},
                            ];
    [keyValueArray addObjectsFromArray:appendArray];
    
    NSMutableArray *modelArray = [@[] mutableCopy];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
        HTMinePreferenceModel *model = [[HTMinePreferenceModel alloc] init];
        model.interfaceType = [dictionary[modelInterfaceTypeKey] integerValue];
        model.dataSourceType = [dictionary[modelDataSourceTypeKey] integerValue];
        model.titleName = dictionary[titleNameKey];
        model.detailName = dictionary[detailNameKey];
        model.headImageName = dictionary[headImageKey];
        model.accessoryAble = [dictionary[accessoryKey] boolValue];
        [modelArray addObject:model];
    }];
    return modelArray;
}

+ (NSArray <HTMinePreferenceModel *> *)packAppInformationModelArray {
    NSString *appVersionString = [NSString stringWithFormat:@"%@_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
    NSString *titleNameKey = @"titleNameKey";
    NSString *modelInterfaceTypeKey = @"modelTypeKey";
    NSString *modelDataSourceTypeKey = @"modelDataSourceTypeKey";
    NSString *detailNameKey = @"detailNameKey";
    NSString *headImageKey = @"headImageKey";
    NSString *accessoryKey = @"accessoryKey";
    NSArray *keyValueArray = @[
                                 @{titleNameKey:@"意见反馈", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeIssue), detailNameKey:appVersionString, headImageKey:@"",  accessoryKey:@(true)},
                                 @{titleNameKey:@"商店好评", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeStar), detailNameKey:@"", headImageKey:@"",  accessoryKey:@(true)},
                             ];
    NSMutableArray *modelArray = [@[] mutableCopy];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
        HTMinePreferenceModel *model = [[HTMinePreferenceModel alloc] init];
        model.interfaceType = [dictionary[modelInterfaceTypeKey] integerValue];
        model.dataSourceType = [dictionary[modelDataSourceTypeKey] integerValue];
        model.titleName = dictionary[titleNameKey];
        model.detailName = dictionary[detailNameKey];
        model.headImageName = dictionary[headImageKey];
        model.accessoryAble = [dictionary[accessoryKey] boolValue];
        [modelArray addObject:model];
    }];
    return modelArray;
}

+ (NSArray <HTMinePreferenceModel *> *)packClearModelArray {
    NSString *cacheSizeString = [NSString stringWithFormat:@"%.1lfM", [HTCacheManager ht_size]];
    NSString *titleNameKey = @"titleNameKey";
    NSString *modelInterfaceTypeKey = @"modelTypeKey";
    NSString *modelDataSourceTypeKey = @"modelDataSourceTypeKey";
    NSString *detailNameKey = @"detailNameKey";
    NSString *headImageKey = @"headImageKey";
    NSString *accessoryKey = @"accessoryKey";
    NSArray *keyValueArray = @[
                               @{titleNameKey:@"清理缓存", modelInterfaceTypeKey:@(HTMinePreferenceModelInterfaceTypeTitleDetail), modelDataSourceTypeKey:@(HTMinePreferenceModelDataSourceTypeClearCache), detailNameKey:cacheSizeString, headImageKey:@"",  accessoryKey:@(false)},
                               ];
    NSMutableArray *modelArray = [@[] mutableCopy];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
        HTMinePreferenceModel *model = [[HTMinePreferenceModel alloc] init];
        model.interfaceType = [dictionary[modelInterfaceTypeKey] integerValue];
        model.dataSourceType = [dictionary[modelDataSourceTypeKey] integerValue];
        model.titleName = dictionary[titleNameKey];
        model.detailName = dictionary[detailNameKey];
        model.headImageName = dictionary[headImageKey];
        model.accessoryAble = [dictionary[accessoryKey] boolValue];
        [modelArray addObject:model];
    }];
    return modelArray;
}

@end
