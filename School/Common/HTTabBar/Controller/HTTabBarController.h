//
//  HTTabBarController.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTVersionManager.h"
#import "HTAnswerController.h"
#import "HTStudyCommunityController.h"
#import "HTCommunityController.h"
#import "HTDiscoverActivityController.h"

@interface HTTabBarController : UITabBarController

- (void)showUpdateVersionAlertWithUpdateModel:(HTVersionModel *)updateModel;

@end
