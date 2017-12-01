//
//  HTUserStoreManager.h
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserStoreModel.h"

@interface HTUserStoreManager : NSObject

+ (BOOL)isStoredWithModel:(HTUserStoreModel *)model;

+ (void)switchStoreStateWithModel:(HTUserStoreModel *)model;

+ (NSInteger)allStoreCount;

+ (NSMutableArray <HTUserStoreManager *> *)selectedStoreModelArrayWithType:(HTUserStoreType)type pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage;

@end
