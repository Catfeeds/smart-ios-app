//
//  HTSchoolMatriculateResultController.m
//  School
//
//  Created by hublot on 2017/6/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateResultController.h"
#import "HTSchoolMatriculateResultHeaderView.h"
#import "HTSchoolCell.h"
#import "HTSchoolController.h"
#import "HTSchoolModel.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTShareView.h"
#import "HTMatriculateResultSectionModel.h"
#import "HTMatriculateResultSectionHeaderView.h"
#import "HTMatriculateResultAnalysisFooterView.h"

@interface HTSchoolMatriculateResultController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTSchoolMatriculateResultHeaderView *resultHeaderView;

@end

@implementation HTSchoolMatriculateResultController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
		[HTRequestManager requestSchoolMatriculateAllResultListWithNetworkModel:networkModel resultIdString:weakSelf.resultIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSString *scoreString = [NSString stringWithFormat:@"%@", response[@"data"][@"score"]];
			NSInteger schoolCount = [response[@"data"][@"res"] count];
			[weakSelf.resultHeaderView setModel:scoreString];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
			weakSelf.tableView.tableHeaderView = weakSelf.resultHeaderView;
			NSArray *sectionModelArray = [HTMatriculateResultSectionModel packModelArrayWithResponse:response];
			[sectionModelArray enumerateObjectsUsingBlock:^(HTMatriculateResultSectionModel *sectionModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[[[sectionMaker.headerClass(sectionModel.headerClass).headerHeight(sectionModel.headerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTMatriculateResultSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
						[reuseView setTitleName:sectionModel.titleName];
					}].cellClass(sectionModel.cellClass).rowHeight(sectionModel.cellHeigith).modelArray(sectionModel.modelArray) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						cell.separatorInset = sectionModel.separatorLineHidden ? UIEdgeInsetsMake(0, HTSCREENWIDTH, 0, 0) : UIEdgeInsetsMake(0, 15, 0, 0);
					}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						UIViewController *viewController;
						switch (sectionModel.type) {
							case HTMatriculateResultSectionTypeSchool: {
								HTSchoolModel *schoolModel = (HTSchoolModel *)model;
								HTSchoolController *detailController = [[HTSchoolController alloc] init];
								detailController.schoolIdString = schoolModel.ID;
								viewController = detailController;
								break;
							}
							default: {
								break;
							}
						}
						if (viewController) {
							[weakSelf.navigationController pushViewController:viewController animated:true];
						}
					}].footerClass(sectionModel.footerClass).footerHeight(sectionModel.footerHeight) customFooterBlock:^(UITableView *tableView, NSInteger section, __kindof HTMatriculateResultAnalysisFooterView *reuseView, __kindof NSArray *modelArray) {
						[reuseView setSchoolCount:schoolCount];
					}];
				}];
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"选校报告";
	[self.view addSubview:self.tableView];
	UIImage *shareImage = [[UIImage imageNamed:@"cn_school_share"] ht_tintColor:[UIColor ht_colorStyle:HTColorStyleTintColor]];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:shareImage style:UIBarButtonItemStylePlain handler:^(id sender) {
		[HTShareView showTitle:@"" detail:@"" image:nil url:nil type:SSDKContentTypeImage];
	}];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		_tableView.separatorColor = [UIColor ht_colorString:@"f4f4f4"];
		_tableView.backgroundColor = [UIColor whiteColor];
	}
	return _tableView;
}


- (HTSchoolMatriculateResultHeaderView *)resultHeaderView {
	if (!_resultHeaderView) {
		_resultHeaderView = [[HTSchoolMatriculateResultHeaderView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 410)];
	}
	return _resultHeaderView;
}

@end
