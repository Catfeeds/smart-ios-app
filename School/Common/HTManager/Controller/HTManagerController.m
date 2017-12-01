//
//  HTManagerController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTManagerController.h"
#import "HTManagerController+HTLaunch.h"

@interface HTManagerController ()

@end

@implementation HTManagerController

+ (HTManagerController *)defaultManagerController {
	static HTManagerController *managerController;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		managerController = [[HTManagerController alloc] init];
	});
	return managerController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
		
	[self addChildViewController:self.tabBarController];
	[self.view addSubview:self.tabBarController.view];
	[self.tabBarController didMoveToParentViewController:self];
	
	[self launchChildController];
	
}

- (HTTabBarController *)tabBarController {
	if (!_tabBarController) {
		_tabBarController = [[HTTabBarController alloc] init];
	}
	return _tabBarController;
}

- (HTAnswerController *)answerController {
	if (!_answerController) {
		_answerController = [[HTAnswerController alloc] init];
	}
	return _answerController;
}


- (HTCommunityController *)communityController {
	if (!_communityController) {
//		_communityController = [[HTCommunityController alloc] init];
	}
	return _communityController;
}

- (HTDiscoverAttentionController *)attentionController {
	if (!_attentionController) {
		_attentionController = [[HTDiscoverAttentionController alloc] init];
	}
	return _attentionController;
}

@end
