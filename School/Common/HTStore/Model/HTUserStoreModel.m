//
//  HTUserStoreModel.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserStoreModel.h"

@implementation HTUserStoreModel

+ (instancetype)packStoreModelType:(HTUserStoreType)type lookId:(NSString *)lookId titleName:(NSString *)titleName {
    HTUserStoreModel *model = [[HTUserStoreModel alloc] init];
    model.type = type;
    model.lookId = lookId;
    model.titleName = titleName;
    return model;
}

@end
