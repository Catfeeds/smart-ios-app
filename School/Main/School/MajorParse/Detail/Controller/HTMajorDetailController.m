//
//  HTMajorDetailController.m
//  School
//
//  Created by hublot on 17/9/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorDetailController.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTMajorSectionHeaderView.h"
#import "HTMajorDetailModel.h"

@interface HTMajorDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTMajorDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
        [HTRequestManager requestMajorDetailWithNetworkModel:networkModel majorParseId:weakSelf.majorIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.errorType) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			HTMajorDetailModel *detailModel = [HTMajorDetailModel mj_objectWithKeyValues:response];
			weakSelf.navigationItem.title = detailModel.name;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:detailModel ? 1 : 0];
			[detailModel.sectionModelArray enumerateObjectsUsingBlock:^(HTMajorSectionModel *headerModel, NSUInteger index, BOOL * _Nonnull stop) {
				[weakSelf.tableView ht_updateSection:index sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
					[[[sectionMaker.cellClass(headerModel.cellClass).rowHeight(headerModel.cellHeigith).modelArray(headerModel.modelArray).headerClass(headerModel.headerClass).headerHeight(headerModel.headerHeight).footerHeight(headerModel.footerHeight) customHeaderBlock:^(UITableView *tableView, NSInteger section, __kindof HTMajorSectionHeaderView *reuseView, __kindof NSArray *modelArray) {
						[reuseView setTitleName:headerModel.titleName];
					}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
//						cell.separatorInset = headerModel.cellSeparatorHidden ? UIEdgeInsetsMake(0, HTSCREENWIDTH, 0, 0) : UIEdgeInsetsZero;
					}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
						
					}];
				}];
			}];
        }];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"专业详情";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.allowsSelection = false;
		UIView *backgroundView = [[UIView alloc] init];
		CGFloat timeLineCenterX = [HTMajorSectionHeaderView timeLineCenterX];
		CGFloat lineWidth =  1 / [UIScreen mainScreen].scale;
		CGFloat lineLeft = timeLineCenterX - lineWidth / 2;
		UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(lineLeft, 0, lineWidth, self.view.bounds.size.height)];
		separatorView.backgroundColor = [UIColor ht_colorStyle:HTColorStylePrimarySeparate];
		[backgroundView addSubview:separatorView];
		_tableView.backgroundView = backgroundView;
    }
    return _tableView;
}

@end
