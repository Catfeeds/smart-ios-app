//
//  HTDiscoverExampleItemModel.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTDiscoverExampleItemModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSString *catId;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *modelArray;

+ (NSArray <HTDiscoverExampleItemModel *> *)packModelArrayFromResponse:(NSDictionary *)response;

@end
