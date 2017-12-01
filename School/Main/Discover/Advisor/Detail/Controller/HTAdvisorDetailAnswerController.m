//
//  HTAdvisorDetailAnswerController.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailAnswerController.h"
#import "HTAdvisorDetailAnswerCell.h"
#import "HTIndexAdvisorDetailModel.h"
#import "HTAnswerDetailController.h"

@interface HTAdvisorDetailAnswerController ()

@end

@implementation HTAdvisorDetailAnswerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        [sectionMaker.cellClass([HTAdvisorDetailAnswerCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTIndexAdvisorDetailAnswerModel *model) {
            HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
            detailController.answerIdString = model.pid;
            [weakSelf.navigationController pushViewController:detailController animated:true];
        }];
    }];
}

@end
