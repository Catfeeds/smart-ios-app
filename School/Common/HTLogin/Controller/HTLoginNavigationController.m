//
//  HTLoginNavigationController.m
//  School
//
//  Created by hublot on 2017/6/26.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginNavigationController.h"

@interface HTLoginNavigationController ()

@end

@implementation HTLoginNavigationController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	if (self.dismissLoginControllerComplete) {
		self.dismissLoginControllerComplete();
	}
}

- (void)initializeDataSource {
	
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[super pushViewController:viewController animated:animated];
	if (viewController.childViewControllers.count) {
		viewController.childViewControllers.lastObject.childViewControllers.lastObject.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTaped)];
	} else {
		viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTaped)];
	}
}

- (void)backButtonTaped {
	if (self.childViewControllers.count == 1) {
		[self dismissViewControllerAnimated:true completion:nil];
	} else {
		[self removeViewController:self.rt_topViewController animated:true];
	}
}

@end
