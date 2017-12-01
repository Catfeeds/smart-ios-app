//
//  HTMajorContentController.m
//  School
//
//  Created by hublot on 17/9/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorContentController.h"
#import "HTMajorCell.h"
#import "HTMajorModel.h"
#import "HTMajorDetailController.h"

@interface HTMajorContentController ()

@end

@implementation HTMajorContentController

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
        [sectionMaker.cellClass([HTMajorCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTMajorModel *model) {
            HTMajorDetailController *detailController = [[HTMajorDetailController alloc] init];
            detailController.majorIdString = model.ID;
            [weakSelf.navigationController pushViewController:detailController animated:true];
        }];
    }];
}

@end
