//
//  HTStoreItemModel.h
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserStoreModel.h"

@interface HTStoreItemModel : NSObject

@property (nonatomic, assign) HTUserStoreType type;

@property (nonatomic, copy) NSString *title;

+ (NSArray <HTStoreItemModel *> *)packModelArray;

@end
