//
//  HTSolutionRecordController.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSolutionRecordController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import <UITableViewCell_HTSeparate.h>
#import "HTAnswerModel.h"
#import "HTAnswerCell.h"
#import "HTAnswerDetailController.h"

@interface HTSolutionRecordController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTSolutionRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleSingleUser];
        [HTRequestManager requestUserSolutionListWithNetworkModel:networkModel uidString:weakSelf.uidString pageSize:pageSize currentPage:currentPage complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                [weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
                return;
            }
            NSMutableArray *modelArray = [HTAnswerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
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
    self.navigationItem.title = @"回答的问题";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor ht_colorString:@"efefef"];
        
        __weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTAnswerCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerModel *model) {
                HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
                detailController.answerIdString = model.ID;
                [detailController setReloadAnswerModel:^(HTAnswerModel *detailAnswerModel) {
                    [weakSelf.modelArray replaceObjectAtIndex:row withObject:detailAnswerModel];
                    [cell setModel:detailAnswerModel row:row];
                }];
                [weakSelf.navigationController pushViewController:detailController animated:true];
            }];
        }];
    }
    return _tableView;
}

@end
