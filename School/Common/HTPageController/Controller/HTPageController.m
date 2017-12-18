//
//  HTPageController.m
//  GMat
//
//  Created by hublot on 2016/11/1.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import "HTPageController.h"
#import "HTReuseController.h"
#import "UIScrollView+HTRefresh.h"

@interface HTPageController ()

@end

@implementation HTPageController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.magicView.layoutStyle = VTLayoutStyleDivide;
	self.magicView.sliderStyle = VTSliderStyleDefault;
	self.magicView.navigationHeight = 40;
	self.magicView.separatorColor = [UIColor clearColor];
	self.magicView.sliderColor = [UIColor clearColor];
	self.magicView.navigationColor = [UIColor whiteColor];
	self.magicView.bounces = false;
	/**
	 * MARK: 设置头部的 bounces
	 */
	UIScrollView *scrollView = [self.magicView valueForKey:@"menuBar"];
	scrollView.bounces = false;
	
	[self.magicView reloadData];
}

- (NSArray <NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
	NSMutableArray *titleArray = [@[] mutableCopy];
	[self.pageModelArray enumerateObjectsUsingBlock:^(HTPageModel *pageModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (pageModel.selectedTitle) {
			[titleArray addObject:pageModel.selectedTitle];
		}
	}];
	return titleArray;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	Class reuseControllerClass = self.pageModelArray[pageIndex].reuseControllerClass;
	NSString *identifier = NSStringFromClass(reuseControllerClass);
	id controller = [magicView dequeueReusablePageWithIdentifier:identifier];
	if (!controller) {
		controller = [[reuseControllerClass alloc] init];
	}
	return controller;
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
	if ([viewController isKindOfClass:[HTReuseController class]]) {
		if (pageIndex > self.pageModelArray.count) {
			return;
		}
		HTPageModel *pageModel = self.pageModelArray[pageIndex];
		pageModel.contentOffset = viewController.tableView.contentOffset;
	//	viewController.pageModel = nil;
	}
}

- (void(^)(NSArray *modelArray, HTError *errorModel))responseHandlerFroPageModel:(HTPageModel *)pageModel viewController:(HTReuseController *)viewController pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage {
	__weak typeof(viewController) weakViewController = viewController;
	void(^responseHandler)(NSArray *modelArray, HTError *errorModel) = ^(NSArray *itemArray, HTError *errorModel) {
		if (errorModel.existError) {
			pageModel.noMoreDataSource = [weakViewController.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
		if (itemArray.count) {
			NSMutableArray *modelArray = [itemArray mutableCopy];
			if (currentPage.integerValue == 1) {
				pageModel.modelArray = modelArray;
			} else {
				[pageModel.modelArray addObjectsFromArray:modelArray];
			}
			pageModel.currentPage = currentPage.integerValue;
			pageModel.noMoreDataSource = [weakViewController.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			weakViewController.pageModel = pageModel;
		} else {
			pageModel.noMoreDataSource = [weakViewController.tableView ht_endRefreshWithModelArrayCount:0];
		}
	};
	return responseHandler;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
	if (![viewController isKindOfClass:[HTReuseController class]]) {
		return;
	}
	__weak HTPageController *weakSelf = self;
    __weak HTReuseController *weakViewController = viewController;
	if (pageIndex > self.pageModelArray.count) {
		return;
	}
	HTPageModel *pageModel = self.pageModelArray[pageIndex];
	
	if (!pageModel.deleteScrollRefresh) {
		[viewController.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
			void(^modelArrayStatus)(NSArray *modelArray, HTError *errorModel) = [weakSelf responseHandlerFroPageModel:pageModel viewController:weakViewController pageSize:pageSize currentPage:currentPage];
			if (weakSelf.modelArrayBlock) {
				weakSelf.modelArrayBlock([NSString stringWithFormat:@"%ld", pageIndex], pageSize, currentPage, modelArrayStatus);
			}
		}];
	} else {
		NSString *pageSize = @"10";
		NSString *currentPage = @"1";
		void(^modelArrayStatus)(NSArray *modelArray, HTError *errorModel) = [weakSelf responseHandlerFroPageModel:pageModel viewController:weakViewController pageSize:pageSize currentPage:currentPage];
		if (weakSelf.modelArrayBlock) {
			weakSelf.modelArrayBlock([NSString stringWithFormat:@"%ld", pageIndex], pageSize, currentPage, modelArrayStatus);
		}
	}
	if (pageModel.modelArray.count) {
		weakViewController.tableView.ht_currentPage = pageModel.currentPage;
		[weakViewController.tableView ht_endRefreshWithModelArrayCount:pageModel.modelArray.count];
		[weakViewController.tableView ht_resetFooterWithDontHaveMoreData:pageModel.noMoreDataSource];
		weakViewController.pageModel = pageModel;
	} else {
		[weakViewController.tableView ht_startRefreshHeader];
	}
	viewController.tableView.contentOffset = pageModel.contentOffset;
}

@end
