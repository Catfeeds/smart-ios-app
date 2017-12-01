//
//  HTUserHistoryManager.h
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserHistoryModel.h"

@interface HTUserHistoryManager : NSObject

+ (void)appendHistoryModel:(HTUserHistoryModel *)model;

+ (NSMutableArray <HTUserHistoryModel *> *)selectedHistoryModelArrayWithType:(HTUserHistoryType)type pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage;

+ (void)deleteHistoryModel:(HTUserHistoryModel *)model;

+ (void)deleteAllHistoryModel;

@end
