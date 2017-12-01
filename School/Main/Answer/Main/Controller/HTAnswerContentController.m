//
//  HTAnswerContentController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerContentController.h"
#import "HTAnswerCell.h"
#import "HTAnswerDetailController.h"
#import <UITableViewCell_HTSeparate.h>

@interface HTAnswerContentController ()

@end

@implementation HTAnswerContentController

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
		[sectionMaker.cellClass([HTAnswerCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerModel *model) {
            HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
			detailController.answerIdString = model.ID;
			[detailController setReloadAnswerModel:^(HTAnswerModel *detailAnswerModel) {
				[weakSelf.pageModel.modelArray replaceObjectAtIndex:row withObject:detailAnswerModel];
				[cell setModel:detailAnswerModel row:row];
			}];
            [weakSelf.navigationController pushViewController:detailController animated:true];
        }];
	}];
}


@end
