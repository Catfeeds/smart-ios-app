//
//  HTManagerController+HTLaunch.m
//  GMat
//
//  Created by hublot on 2017/7/14.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "HTManagerController+HTLaunch.h"
#import "HTLoginManager.h"
#import "HTFirstIntroduceController.h"
#import "HTBroadCastController.h"

@implementation HTManagerController (HTLaunch)

- (void)launchChildController {

//	UIView.appearance.tintColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	UIScrollView.appearance.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	UITextView.appearance.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
	UITextField.appearance.clearButtonMode = UITextFieldViewModeWhileEditing;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	
	NSString *infoPlistVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSString *firstLaunchFlag = @"First";
	NSString *firstLaunchValue = HTPlaceholderString([userDefault stringForKey:firstLaunchFlag], @"");
	if (!firstLaunchValue.length) {
		[HTLoginManager exitLoginWithComplete:nil];
		HTFirstIntroduceController *firstIntroduceController = [[HTFirstIntroduceController alloc] init];
		[self addChildViewController:firstIntroduceController];
		[firstIntroduceController setLoadViewBlock:^(UIView *view) {
			[self.view addSubview:view];
		}];
		firstIntroduceController.view = firstIntroduceController.view;
		[firstIntroduceController didMoveToParentViewController:self];
		[userDefault setValue:infoPlistVersionString forKey:firstLaunchFlag];
	} else {
		HTBroadCastController *bootAdvertController = [[HTBroadCastController alloc] init];
		[self addChildViewController:bootAdvertController];
		[bootAdvertController setLoadViewBlock:^(UIView *view) {
			[self.view addSubview:view];
		}];
		bootAdvertController.view = bootAdvertController.view;
		[bootAdvertController didMoveToParentViewController:self];
	}
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoAlertString = nil;
	networkModel.offlineCacheStyle = HTCacheStyleAllUser;
	networkModel.autoShowError = false;
	[HTRequestManager requestAppStoreMaxVersionWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
		self.versionManager.versionModel = [HTVersionModel mj_objectWithKeyValues:response];
		if (self.versionManager.versionModel.resultCount == 1 && self.versionManager.versionModel.results.count == 1) {
			HTUpdateResults *results = self.versionManager.versionModel.results.firstObject;
			NSComparisonResult comparisonResult = [infoPlistVersionString compare:results.version options:NSNumericSearch];
			if (comparisonResult == NSOrderedAscending) {
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					[self showUpdateVersionView];
				});
//				[self.tabBarController showUpdateVersionAlertWithUpdateModel:self.versionManager.versionModel];
			}
			if (comparisonResult == NSOrderedDescending) {
				self.versionManager.isAppStoreOnReviewingVersion = true;
			}
		}
	}];
	[HTLoginManager autoLoginWithComplete:nil];
}

- (void)showUpdateVersionView {
//	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//	paragraphStyle.alignment = NSTextAlignmentCenter;
//	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"每一次都带给你实质性的体验升级"
//																		   attributes:@{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle],
//																						NSFontAttributeName:[UIFont systemFontOfSize:16],
//																						NSParagraphStyleAttributeName:paragraphStyle}];
//	[HTUpdateVersionView showWithSureBlock:^{
//		[HTRequestManager requestOpenAppStore];
//	} attributedString:attributedString animate:true superView:self.drawerController.view];
}

@end
