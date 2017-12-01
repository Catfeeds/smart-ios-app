//
//  HTUserStoreModel.h
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTUserStoreType) {
    HTUserStoreTypeSchool,
    HTUserStoreTypeProfessional,
    HTUserStoreTypeAnswer,
    HTUserStoreTypeActivity,
    HTUserStoreTypeLibrary,
};

@interface HTUserStoreModel : NSObject

@property (nonatomic, assign) HTUserStoreType type;

@property (nonatomic, strong) NSString *lookId;

@property (nonatomic, strong) NSString *titleName;

+ (instancetype)packStoreModelType:(HTUserStoreType)type lookId:(NSString *)lookId titleName:(NSString *)titleName;


@property (nonatomic, assign) NSInteger lookTime;

@property (nonatomic, assign) NSInteger ID;

@end
