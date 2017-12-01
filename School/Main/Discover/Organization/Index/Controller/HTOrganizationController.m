//
//  HTOrganizationController.m
//  School
//
//  Created by hublot on 2017/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOrganizationController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTOrganizationHeaderView.h"
#import "HTOrganizationContentController.h"
#import "HTOrganizationModel.h"

@interface HTOrganizationController ()

@property (nonatomic, strong) HTOrganizationHeaderView *headerView;

@end

@implementation HTOrganizationController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTOrganizationContentController *)viewController atPage:(NSUInteger)pageIndex {
	UITableView *tableView = viewController.tableView;
	
	__weak typeof(self) weakSelf = self;
	[tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		[sectionMaker willEndDraggingBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet, CGPoint velocity, CGPoint targetContentOffSet) {
			if (velocity.y > 0.3) {
				if (!weakSelf.magicView.headerHidden) {
					[weakSelf.magicView setHeaderHidden:true duration:0.4];
				}
			} else if (targetContentOffSet.y < 0 || velocity.y < - 1) {
				if (weakSelf.magicView.headerHidden) {
					[weakSelf.magicView setHeaderHidden:false duration:0.4];
				}
			}
		}];
	}];
	
	[super magicView:magicView viewDidAppear:viewController atPage:pageIndex];
}

- (void)initializeUserInterface {
	
	self.navigationItem.title = @"留学机构";
	self.magicView.headerHeight = self.headerView.ht_h;
	[self.magicView.headerView addSubview:self.headerView];
	self.magicView.headerHidden = false;
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	NSArray *titleArray = @[@"综合", @"好评度"];
	NSMutableArray *pageModelArray = [@[] mutableCopy];
	[titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
		HTPageModel *pageModel = [[HTPageModel alloc] init];
		pageModel.selectedTitle = title;
		pageModel.reuseControllerClass = [HTOrganizationContentController class];
		[pageModelArray addObject:pageModel];
	}];
	self.pageModelArray = pageModelArray;
	[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<NSString *> *, HTError *)) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		HTOrganizationListType type = pageIndex.integerValue;
        [HTRequestManager requestOrganizationListWithNetworkModel:networkModel organizationListType:type pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				modelArrayStatus(nil, errorModel);
				return;
			}
			NSArray *modelArray = [HTOrganizationModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
			modelArrayStatus(modelArray, nil);
		}];
	}];

	
	[self.magicView reloadData];
}

- (HTOrganizationHeaderView *)headerView {
	if (!_headerView) {
		_headerView = [[HTOrganizationHeaderView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 180)];
	}
	return _headerView;
}



@end
