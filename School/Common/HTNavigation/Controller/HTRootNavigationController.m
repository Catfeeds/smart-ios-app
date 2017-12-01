//
//  HTRootNavigationController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTRootNavigationController.h"

@interface HTRootNavigationController ()

@end

@implementation HTRootNavigationController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.transferNavigationBarAttributes = true;
	self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
											   NSForegroundColorAttributeName:[UIColor whiteColor],
											   };
	self.navigationBar.barTintColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	viewController.hidesBottomBarWhenPushed = self.childViewControllers.count;
	[super pushViewController:viewController animated:animated];
	
	if (viewController.rt_navigationController) {
		viewController.navigationController.view = viewController.navigationController.view;
		if (!viewController.view.backgroundColor) {
			viewController.view.backgroundColor = [UIColor whiteColor];
		}
	}
}

@end
