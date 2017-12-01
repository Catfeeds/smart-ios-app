//
//  HTSearchRequestManager.h
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSearchItemModel.h"

@interface HTSearchRequestManager : NSObject

+ (void)searchItemType:(HTSearchType)type keyWord:(NSString *)keyWord pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete;

@end
