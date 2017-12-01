//
//  HTBookController.m
//  School
//
//  Created by hublot on 17/8/13.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTBookController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTBookCell.h"
#import "HTBookModel.h"
#import "HTSellerDetailController.h"

@interface HTBookController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestBookListWithNetworkModel:networkModel pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			NSMutableArray *modelArray = [HTBookModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			if (currentPage.integerValue <= 1) {
				weakSelf.modelArray = modelArray;
			} else {
				[weakSelf.modelArray addObjectsFromArray:modelArray];
			}
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(weakSelf.modelArray);
			}];
		}];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"留学文书";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTBookCell class]).rowHeight(90) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTBookModel *model) {
                HTSellerDetailController *detailController = [[HTSellerDetailController alloc] init];
                detailController.sellerIdString = model.ID;
                [weakSelf.navigationController pushViewController:detailController animated:true];
            }];
        }];
    }
    return _tableView;
}

@end
