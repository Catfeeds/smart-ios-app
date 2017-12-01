//
//  HTMinePreferenceModel.h
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTMinePreferenceModelInterfaceType) {
    HTMinePreferenceModelInterfaceTypeTitleDetail,
    HTMinePreferenceModelInterfaceTypeSectionTitle,
    HTMinePreferenceModelInterfaceTypeRightImage
};

typedef NS_ENUM(NSInteger, HTMinePreferenceModelDataSourceType) {
    HTMinePreferenceModelDataSourceTypeDetail,
    HTMinePreferenceModelDataSourceTypeHeadImage,
    //	THMinePreferenceModelEveryOneUsername,
    HTMinePreferenceModelDataSourceTypeNickname,
    HTMinePreferenceModelDataSourceTypePhoneCode,
    HTMinePreferenceModelDataSourceTypeEmailCode,
    HTMinePreferenceModelDataSourceTypePassword,
    HTMinePreferenceModelDataSourceTypeAnswerTag,
//    HTMinePreferenceModelDataSourceTypeAboutUs,
//    HTMinePreferenceModelDataSourceTypeWebSite,
//    HTMinePreferenceModelDataSourceTypeWeChat,
//    HTMinePreferenceModelDataSourceTypeTencent,
    HTMinePreferenceModelDataSourceTypeIssue,
    HTMinePreferenceModelDataSourceTypeStar,
//    HTMinePreferenceModelDataSourceTypeFontSize,
    HTMinePreferenceModelDataSourceTypeClearCache
};

@interface HTMinePreferenceModel : NSObject

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *detailName;

@property (nonatomic, strong) NSString *headImageName;


@property (nonatomic, assign) BOOL accessoryAble;

@property (nonatomic, assign) HTMinePreferenceModelInterfaceType interfaceType;

@property (nonatomic, assign) HTMinePreferenceModelDataSourceType dataSourceType;

+ (NSArray <HTMinePreferenceModel *> *)packUserInformationModelArray;

+ (NSArray <HTMinePreferenceModel *> *)packAppInformationModelArray;

+ (NSArray <HTMinePreferenceModel *> *)packClearModelArray;

@end
