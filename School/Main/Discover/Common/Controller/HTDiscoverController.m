//
//  HTDiscoverController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverController.h"
#import "HTDiscoverHeaderView.h"
#import "HTDiscoverActivityController.h"
#import "HTDiscoverAttentionController.h"
#import "HTReuseController.h"
#import "HTManagerController.h"
#import "THToeflDiscoverIssueController.h"
#import "HTDiscoverActivityModel.h"
#import "HTGossIPItemModel.h"
#import "THToeflDiscoverModel.h"
#import "HTDiscoverActivityDetailController.h"

@interface HTDiscoverController () <HTHeadlineHeaderViewDelegate>

@property (nonatomic, strong) HTDiscoverHeaderView *headerView; //之前的

@property (nonatomic, strong) NSMutableArray *itemModelArray;

@property (nonatomic, strong) NSMutableDictionary *controllerDictionary;

@property (nonatomic, strong) HTHeadlineHeaderView *headlineHeaderView;

@end

@implementation HTDiscoverController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//if (!self.headlineHeaderView.activityModelArray.count) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestActivityBannerWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			NSArray *bannerModelArray = [HTDiscoverActivityModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
			self.headlineHeaderView.activityModelArray = bannerModelArray;
		//	[self.headerView setBannerModelArray:bannerModelArray];
		//	[self.headerView setTopLineModelArray:bannerModelArray];
		}];
	//}
}

- (void)initializeDataSource {
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
//	networkModel.autoAlertString = @"loding";
	[HTRequestManager requestDiscoverListWithNetworkModel:networkModel catIdString:@"14" pageSize:@"" currentPage:@"" complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
		//	modelArrayStatus(nil, errorModel);
			return;
		}
		
		self.itemModelArray = [HTGossIPItemModel mj_objectArrayWithKeyValuesArray:response[@"catChild"]];
		
		HTGossIPItemModel *all = [HTGossIPItemModel new];
		all.titleName = @"全部";
		all.catIdString = @"14";
		[self.itemModelArray insertObject:all atIndex:0];
		[self initializeUserInterface];
	}];
}

- (NSString *)getCurrentCatIDString{
	HTGossIPItemModel *model = self.itemModelArray[self.currentPage];
	return model.catIdString;
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"发现";
//	__weak typeof(self) weakSelf = self;

//	UIButton *issueButton = [[UIButton alloc] init];
//	UIImage *image = [UIImage imageNamed:@"cn_discover_issue"];
//	image = [image ht_tintColor:[UIColor whiteColor]];
//	[issueButton setImage:image forState:UIControlStateNormal];
//	[issueButton ht_whenTap:^(UIView *view) {
//		THToeflDiscoverIssueController *issueController = [[THToeflDiscoverIssueController alloc] init];
//		HTGossIPItemModel *model = weakSelf.itemModelArray[weakSelf.currentPage];
//		issueController.catIdString = model.catIdString;
//		[weakSelf.navigationController pushViewController:issueController animated:true];
//	}];
//	[issueButton sizeToFit];
//	UIBarButtonItem *issueBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:issueButton];
//	self.navigationItem.rightBarButtonItem = issueBarButtonItem;
	
//  self.magicView.headerHeight = self.headerView.ht_h;
//	[self.magicView.headerView addSubview:self.headerView];

	self.magicView.headerHeight = self.headlineHeaderView.ht_h;
	[self.magicView.headerView addSubview:self.headlineHeaderView];
	
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	self.magicView.headerHidden = false;
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	
	self.headlineHeaderView.frame = CGRectMake(0, 0, HTSCREENWIDTH, 144);
	
	NSArray *itemModelArray = self.itemModelArray;
	NSMutableArray *pageModelArray = [@[] mutableCopy];
	[itemModelArray enumerateObjectsUsingBlock:^(HTGossIPItemModel *itemModel, NSUInteger index, BOOL * _Nonnull stop) {
		HTPageModel *pageModel = [[HTPageModel alloc] init];
		pageModel.selectedTitle = itemModel.titleName;
		pageModel.reuseControllerClass = [HTDiscoverAttentionController class];
		[pageModelArray addObject:pageModel];
	}];
	
	[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void(^modelArrayStatus)(NSArray *modelArray, HTError *errorModel)) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		HTGossIPItemModel *model = itemModelArray[pageIndex.integerValue];
		[HTRequestManager requestDiscoverListWithNetworkModel:networkModel catIdString:model.catIdString pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				modelArrayStatus(nil, errorModel);
				return;
			}
			NSArray *modelArray = [THToeflDiscoverModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
			modelArrayStatus(modelArray, nil);
		}];
	}];

	self.pageModelArray = pageModelArray;
	[self.magicView reloadData];
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
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

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	UIViewController *viewController;
	if (pageIndex == 0) {
		viewController = [HTManagerController defaultManagerController].attentionController;
	} else {
		viewController = [super magicView:magicView viewControllerAtPage:pageIndex];
	}
	return viewController;
}

#pragma mark - HTHeadlineHeaderViewDelegate

- (void)clickHeadLinde:(HTDiscoverActivityModel *)activityModel{
	HTDiscoverActivityDetailController *detailController = [[HTDiscoverActivityDetailController alloc] init];
	detailController.activityIdString = activityModel.ID;
	[self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -

- (HTDiscoverHeaderView *)headerView {
	if (!_headerView) {
		_headerView = [[HTDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 320)];
	}
	return _headerView;
}

- (HTHeadlineHeaderView *) headlineHeaderView{
	if (!_headlineHeaderView) {
		_headlineHeaderView =  [[NSBundle mainBundle] loadNibNamed:@"HTHeadlineHeaderView" owner:nil options:nil].firstObject;
		_headlineHeaderView.frame = CGRectMake(0, 0, HTSCREENWIDTH, 144);
		_headlineHeaderView.delegate = self;
	}
	return _headlineHeaderView;
}

//- (NSArray *)itemModelArray {
//	if (!_itemModelArray) {
//		_itemModelArray = [HTGossIPItemModel packModelArray];
//	}
//	return _itemModelArray;
//}

- (NSMutableDictionary *)controllerDictionary {
	if (!_controllerDictionary) {
		_controllerDictionary = [@{} mutableCopy];
	}
	return _controllerDictionary;
}

@end
