//
//  HTLoginNavigationController.h
//  School
//
//  Created by hublot on 2017/6/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTRootNavigationController.h"

@interface HTLoginNavigationController : HTRootNavigationController

@property (nonatomic, copy) void(^dismissLoginControllerComplete)(void);

@end
