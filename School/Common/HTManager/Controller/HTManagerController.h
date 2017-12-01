//
//  HTManagerController.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTabBarController.h"
#import "HTVersionManager.h"
#import "HTDiscoverAttentionController.h"

@interface HTManagerController : UIViewController

+ (HTManagerController *)defaultManagerController;

@property (nonatomic, strong) HTVersionManager *versionManager;

@property (nonatomic, strong) HTTabBarController *tabBarController;


@property (nonatomic, strong) HTAnswerController *answerController;

@property (nonatomic, strong) HTCommunityController *communityController;

@property (nonatomic, strong) HTDiscoverAttentionController *attentionController;

@end
