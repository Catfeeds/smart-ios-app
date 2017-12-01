//
//  HTIndexAnswerController.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAnswerController.h"
#import <UITableView+HTSeparate.h>
#import "HTAnswerCell.h"
#import "HTAnswerDetailController.h"
#import "HTRootNavigationController.h"
#import <UITableViewCell_HTSeparate.h>

@interface HTIndexAnswerController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HTIndexAnswerController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	[self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (NSInteger)tableHeightReloadModelArray:(NSArray *)modelArray {
    __block CGFloat tableHeight = 0;
    _modelArray = [modelArray mutableCopy];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        sectionMaker.modelArray(weakSelf.modelArray);
    }];
    [self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
        tableHeight = sectionMaker.section.sumRowHeight;
    }];
    return tableHeight;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] init];
		_tableView.scrollEnabled = false;
        
        __weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.cellClass([HTAnswerCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerModel *model) {
				HTAnswerDetailController *detailController = [[HTAnswerDetailController alloc] init];
				detailController.answerIdString = model.ID;
				[detailController setReloadAnswerModel:^(HTAnswerModel *detailAnswerModel) {
					[weakSelf.modelArray replaceObjectAtIndex:row withObject:detailAnswerModel];
					[cell setModel:detailAnswerModel row:row];
				}];
                [weakSelf.view.superview.ht_controller.rt_navigationController pushViewController:detailController animated:true];
			}];
		}];
	}
	return _tableView;
}

@end
