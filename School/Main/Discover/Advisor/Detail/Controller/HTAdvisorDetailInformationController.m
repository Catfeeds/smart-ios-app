//
//  HTAdvisorDetailInformationController.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAdvisorDetailInformationController.h"
#import "HTAdvisorDetailInformationCell.h"

@interface HTAdvisorDetailInformationController ()

@end

@implementation HTAdvisorDetailInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        [sectionMaker.cellClass([HTAdvisorDetailInformationCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
			
		}];
    }];
}

@end
