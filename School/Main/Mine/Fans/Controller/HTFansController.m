//
//  HTFansController.m
//  School
//
//  Created by hublot on 17/8/18.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFansController.h"
#import <UIScrollView+HTRefresh.h>
#import <UITableView+HTSeparate.h>
#import "HTFansCell.h"
#import "HTFansModel.h"
#import "HTSomeoneController.h"

@interface HTFansController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleSingleUser];
        [HTRequestManager requestUserFansListWithNetworkModel:networkModel uidString:weakSelf.uidString pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
                return;
            }
            NSMutableArray *modelArray = [HTFansModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
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
    self.navigationItem.title = @"粉丝列表";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor ht_colorString:@"efefef"];
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTFansCell class]).rowHeight(80) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTFansModel *model) {
                HTSomeoneController *someoneController = [[HTSomeoneController alloc] init];
                someoneController.userIdString = model.uid;
                [weakSelf.navigationController pushViewController:someoneController animated:true];
            }];
        }];
    }
    return _tableView;
}

@end
