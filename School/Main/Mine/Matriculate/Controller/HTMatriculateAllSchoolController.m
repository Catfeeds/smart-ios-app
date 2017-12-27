//
//  HTMatriculateAllSchoolController.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMatriculateAllSchoolController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTMatriculateAllHeaderCell.h"
#import "HTMatriculateAllCell.h"
#import "HTMatriculateRecordModel.h"
#import "HTChooseSchoolResultController.h"

@interface HTMatriculateAllSchoolController ()

@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation HTMatriculateAllSchoolController

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
            [weakSelf.tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
                sectionMaker.modelArray(model.schoolTest);
            }];
        }];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"我的选校报告";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
		_tableView.separatorColor = _tableView.backgroundColor;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.cellClass([HTMatriculateAllHeaderCell class]).rowHeight(40).modelArray(@[@""]);
		}];
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTMatriculateAllCell class]).rowHeight(60) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMatriculateSingleSchoolModel *model) {
			//	HTSchoolMatriculateResultController *resultController = [[HTSchoolMatriculateResultController alloc] init];
			//	resultController.resultIdString = model.ID;
				
				HTChooseSchoolResultController *resultController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseSchoolResultController");
				resultController.resultID = model.ID;
				[weakSelf.navigationController pushViewController:resultController animated:true];
			}];
		}];
	}
	return _tableView;
}


@end
