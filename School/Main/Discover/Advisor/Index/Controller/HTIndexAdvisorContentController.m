//
//  HTIndexAdvisorContentController.m
//  School
//
//  Created by hublot on 17/8/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAdvisorContentController.h"
#import "HTIndexAdvisorCell.h"
#import "HTIndexAdvisorModel.h"
#import "HTIndexAdvisorDetailController.h"

@interface HTIndexAdvisorContentController ()

@end

@implementation HTIndexAdvisorContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    self.tableView.backgroundColor = [UIColor ht_colorString:@"efefef"];
    self.tableView.separatorColor = self.tableView.backgroundColor;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        [sectionMaker.cellClass([HTIndexAdvisorCell class]).rowHeight(120) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTIndexAdvisorModel *model) {
            HTIndexAdvisorDetailController *detailController = [[HTIndexAdvisorDetailController alloc] init];
            detailController.advisorIdString = model.ID;
            [weakSelf.navigationController pushViewController:detailController animated:true];
        }];
    }];
}

@end
