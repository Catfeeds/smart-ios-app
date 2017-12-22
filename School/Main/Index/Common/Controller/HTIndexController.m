//
//  HTIndexController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexController.h"
#import "HTIndexModel.h"
#import "HTIndexHeaderView.h"
#import "HTSearchTitleView.h"
#import <UITableView+HTSeparate.h>
#import "HTSearchController.h"
#import "HTIndexForYouIndexFooterView.h"
#import <UIScrollView+HTRefresh.h>
#import "HTManagerController.h"
#import "HTRootNavigationController.h"
#import "HTWebController.h"
#import "HTDiscoverActivityController.h"
#import "HTBookController.h"
#import "HTAnswerModel.h"
#import "HTIndexExampleIndexCell.h"
#import "HTExampleSuccessController.h"
#import "HTSchoolHotDetailController.h"
#import "HTDiscoverActivityModel.h"
#import "HTSchoolFilterController.h"
#import "HTStudyAbroadController.h"
#import "HTOpenCourseController.h"

@interface HTIndexController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTIndexHeaderView *indexHeaderView;

@property (nonatomic, strong) HTIndexForYouIndexFooterView *indexFooterView;

@end

@implementation HTIndexController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestActivityBannerWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			NSArray *bannerModelArray = [HTDiscoverActivityModel mj_objectArrayWithKeyValuesArray:response[@"banner"]];
			[weakSelf.indexHeaderView setBannerModelArray:bannerModelArray];
		}];
		
		HTNetworkModel *indexNetworkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestIndexListWithNetworkModel:indexNetworkModel complete:^(id response, HTError *errorModel) {
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
			if (errorModel.existError) {
				return;
			}
			HTIndexModel *indexModel = [HTIndexModel mj_objectWithKeyValues:response];
			weakSelf.tableView.tableHeaderView = weakSelf.indexHeaderView;
			
			[indexModel.headerModelArray enumerateObjectsUsingBlock:^(HTIndexHeaderModel *headerModel, NSUInteger idx, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:headerModel.type sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[sectionMaker.cellClass(headerModel.cellClass).rowHeight(headerModel.cellHeigith).modelArray(headerModel.modelArray).headerClass(headerModel.headerClass).headerHeight(headerModel.headerHeight).footerHeight(headerModel.footerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTIndexSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
						
						[reuseView setTitleName:headerModel.titleName imageName:headerModel.imageName separatorLineHidden:headerModel.separatorLineHidden];
						switch (headerModel.type) {
							case HTIndexHeaderTypeSchool: {
								[reuseView setHeaderRightDetailTapedBlock:^{
									//特色学校推荐 more
//									HTSchoolHotDetailController *hotController = [[HTSchoolHotDetailController alloc] init];
									HTSchoolFilterController *controller = [[HTSchoolFilterController alloc] init];
									[weakSelf.navigationController pushViewController:controller animated:true];
									
								}];
								break;
							}
							case HTIndexHeaderTypeExample: {
								break;
							}
							case HTIndexHeaderTypeActivity: {
								[reuseView setHeaderRightDetailTapedBlock:^{
//									HTDiscoverActivityController *activityController = [[HTDiscoverActivityController alloc] init];
									HTOpenCourseController *activityController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTOpenCourseController");
									[weakSelf.navigationController pushViewController:activityController animated:true];
								}];
								break;
							}
							case HTIndexHeaderTypeBook: {
								[reuseView setHeaderRightDetailTapedBlock:^{
									//HTBookController *bookController = [[HTBookController alloc] init];
									HTStudyAbroadController *studyAbroadController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTStudyAbroadController");
									[weakSelf.navigationController pushViewController:studyAbroadController animated:true];
								}];
								break;
							}
							case HTIndexHeaderTypeForYou: {
								
								break;
							}
						}
					}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						switch (headerModel.type) {
							case HTIndexHeaderTypeSchool: {
								break;
							}
							case HTIndexHeaderTypeExample: {
								HTExampleSuccessController *exampleController = [[HTExampleSuccessController alloc] init];
								[weakSelf.navigationController pushViewController:exampleController animated:true];
								break;
							}
							case HTIndexHeaderTypeActivity: {
								
								break;
							}
							case HTIndexHeaderTypeBook: {
								
								break;
							}
							case HTIndexHeaderTypeForYou: {
								break;
							}
						}
					}];
				}];
			}];
			
			weakSelf.indexFooterView.activityModelArray = indexModel.specialColumn;
		}];
		HTNetworkModel *answerNetworkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestAnswerListWithNetworkModel:answerNetworkModel answerTagString:nil pageSize:nil currentPage:nil complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			NSArray *answerModelArray = [HTAnswerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
			weakSelf.indexFooterView.answerModelArray = answerModelArray;
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	HTSearchTitleView *searchTitleView = [[HTSearchTitleView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 30)];
	
	[searchTitleView ht_whenTap:^(UIView *view) {
		[HTSearchController presentSearchControllerAnimated:false defaultSelectedType:HTSearchTypeSchool];
	}];
	self.navigationItem.titleView = searchTitleView;
	[self.view addSubview:self.tableView];
}

- (HTIndexHeaderView *)indexHeaderView {
	if (!_indexHeaderView) {
		_indexHeaderView = [[HTIndexHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 410)];
	}
	return _indexHeaderView;
}

- (HTIndexForYouIndexFooterView *)indexFooterView {
	if (!_indexFooterView) {
		//隐藏为你推荐
//		_indexFooterView = [[HTIndexForYouIndexFooterView alloc] init];
//		_indexFooterView.superTableView = self.tableView;
		
	}
	return _indexFooterView;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return _tableView;
}


@end

