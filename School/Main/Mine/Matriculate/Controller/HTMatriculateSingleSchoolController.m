//
//  HTMatriculateSingleSchoolController.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateSingleSchoolController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTMatriculateSingleCell.h"
#import "HTMatriculateRecordModel.h"
#import "HTSchoolMatriculateSingleResultView.h"

@interface HTMatriculateSingleSchoolController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTMatriculateSingleSchoolController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleSingleUser];
        [HTRequestManager requestMatriculateRecordWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
                return;
            }
            HTMatriculateRecordModel *model = [HTMatriculateRecordModel mj_objectWithKeyValues:response];
            [weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
            [weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
                sectionMaker.modelArray(model.probabilityTest);
            }];
        }];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"录取报告";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTMatriculateSingleCell class]).rowHeight(150).footerClass([UITableViewHeaderFooterView class]).footerHeight(15) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMatriculateSingleSchoolModel *model) {
				[HTSchoolMatriculateSingleResultView showResultViewWithResultModel:model];
				HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleSingleUser];
				[HTRequestManager requestSchoolMatriculateSingleResultListWithNetworkModel:networkModel resultIdString:model.ID complete:^(id response, HTError *errorModel) {
				}];
			}] customFooterBlock:^(UITableView *tableView, NSInteger section, __kindof UITableViewHeaderFooterView *reuseView, __kindof NSArray *modelArray) {
				reuseView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage ht_pureColor:[UIColor clearColor]]];
			}];
		}];
	}
	return _tableView;
}


@end
