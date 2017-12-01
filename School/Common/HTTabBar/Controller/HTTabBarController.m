//
//  HTTabBarController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTTabBarController.h"
#import "HTTabBar.h"
#import "HTRootNavigationController.h"
#import "HTIndexController.h"
#import "HTMineController.h"
#import "HTExampleController.h"
#import "HTManagerController.h"

@interface HTTabBarController ()

#define kHTTabBarCONTROLLERKEY			@"kHTTabBarCONTROLLERKEY"
#define kHTTabBarTITLEKEY				@"kHTTabBarTITLEKEY"
#define kHTTabBarIMAGEKEY				@"kHTTabBarIMAGEKEY"
#define kHTTabBarSELECTEDIMAGEKEY		@"kHTTabBarSELECTEDIMAGEKEY"

@end

@implementation HTTabBarController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	HTTabBar *tabBar = [[HTTabBar alloc] init];
	[self setValue:tabBar forKey:@"tabBar"];
	
	NSArray *childArray = @[
							@{kHTTabBarCONTROLLERKEY:NSStringFromClass([HTIndexController class]),
							  kHTTabBarTITLEKEY:@"首页",
							  kHTTabBarIMAGEKEY:@"cn2_icon_tabbaritem_1_n",
							  kHTTabBarSELECTEDIMAGEKEY:@"cn2_icon_tabbaritem_1_s"},
							@{kHTTabBarCONTROLLERKEY:NSStringFromClass([HTAnswerController class]),
							  kHTTabBarTITLEKEY:@"问答",
							  kHTTabBarIMAGEKEY:@"cn2_icon_tabbaritem_2_n",
							  kHTTabBarSELECTEDIMAGEKEY:@"cn2_icon_tabbaritem_2_s"},
							@{kHTTabBarCONTROLLERKEY:NSStringFromClass([HTDiscoverController class]),
							  kHTTabBarTITLEKEY:@"发现",
							  kHTTabBarIMAGEKEY:@"cn2_icon_tabbaritem_3_n",
							  kHTTabBarSELECTEDIMAGEKEY:@"cn2_icon_tabbaritem_3_s"},
							@{kHTTabBarCONTROLLERKEY:NSStringFromClass([HTExampleController class]),
							  kHTTabBarTITLEKEY:@"案例",
							  kHTTabBarIMAGEKEY:@"cn2_icon_tabbaritem_4_n",
							  kHTTabBarSELECTEDIMAGEKEY:@"cn2_icon_tabbaritem_4_s"},
							@{kHTTabBarCONTROLLERKEY:NSStringFromClass([HTMineController class]),
							  kHTTabBarTITLEKEY:@"我",
							  kHTTabBarIMAGEKEY:@"cn2_icon_tabbaritem_5_n",
							  kHTTabBarSELECTEDIMAGEKEY:@"cn2_icon_tabbaritem_5_s"},
							];
	
	[childArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		[self addChildViewControllerWithChildDictionary:dictionary];
	}];
}

- (void)addChildViewControllerWithChildDictionary:(NSDictionary *)dictionary {
	Class controllerClass = NSClassFromString(dictionary[kHTTabBarCONTROLLERKEY]);
	UIViewController *viewController;
	HTManagerController *managerController = [HTManagerController defaultManagerController];
	if ([managerController.answerController isKindOfClass:controllerClass]) {
		viewController = managerController.answerController;
	} else {
		viewController = [[controllerClass alloc] init];
	}
	
	
	HTRootNavigationController *navigationController = [[HTRootNavigationController alloc] initWithRootViewController:viewController];
	viewController.tabBarItem.title = dictionary[kHTTabBarTITLEKEY];
	UIImage *normalImage = [UIImage imageNamed:dictionary[kHTTabBarIMAGEKEY]];
	UIImage *selectedImage = [UIImage imageNamed:dictionary[kHTTabBarSELECTEDIMAGEKEY]];
	CGFloat minStandard = 20;
	normalImage = [[normalImage ht_resetSizeWithStandard:minStandard isMinStandard:true] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	selectedImage = [[selectedImage ht_resetSizeWithStandard:minStandard isMinStandard:true] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	viewController.tabBarItem.image = normalImage;
	[viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ht_colorString:@"4c4c4c"]} forState:UIControlStateNormal];
	[viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ht_colorString:@"8db424"]} forState:UIControlStateSelected];
	viewController.tabBarItem.selectedImage = selectedImage;
	[self addChildViewController:navigationController];
}

- (void)showUpdateVersionAlertWithUpdateModel:(HTVersionModel *)updateModel{
//	if (updateModel.results.lastObject.version.length && updateModel.results.lastObject.releaseNotes.length && [self.selectedViewController isKindOfClass:[HTRootNavigationController class]]) {
//		HTRootNavigationController *currentNavigationController = self.selectedViewController;
//		HTOctopusAlertView *octopusAlertView = [HTAlert title:updateModel.results.lastObject.releaseNotes message:[NSString stringWithFormat:@"有新的版本哦: %@", updateModel.results.lastObject.version] tryAgainTitle:@"更新啦" tryAgainBlock:^{
//			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/lei-ge-tuo-fu/id1086920895?l=zh&ls=1&mt=8"]];
//		}];
//		[currentNavigationController.childViewControllers.firstObject.view addSubview:octopusAlertView];
//	}
}

@end
