//
//  HTVersionManager.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTVersionModel.h"

@interface HTVersionManager : NSObject

@property (nonatomic, strong) HTVersionModel *versionModel;

@property (nonatomic, assign) BOOL isAppStoreOnReviewingVersion;

@end
