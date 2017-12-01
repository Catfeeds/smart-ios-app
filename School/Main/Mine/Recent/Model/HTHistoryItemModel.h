//
//  HTHistoryItemModel.h
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserHistoryModel.h"

@interface HTHistoryItemModel : NSObject

@property (nonatomic, assign) HTUserHistoryType type;

@property (nonatomic, copy) NSString *title;

+ (NSArray <HTHistoryItemModel *> *)packModelArray;

@end
