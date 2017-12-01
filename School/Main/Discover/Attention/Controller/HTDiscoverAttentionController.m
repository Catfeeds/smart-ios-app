//
//  HTDiscoverAttentionController.m
//  GMat
//
//  Created by hublot on 2017/7/5.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "HTDiscoverAttentionController.h"
#import <UIScrollView+HTRefresh.h>
#import "THToeflDiscoverTableCell.h"
#import "THToeflDiscoverModel.h"
#import "THToeflDiscoverDetailController.h"
#import <UITableViewCell_HTSeparate.h>

@interface HTDiscoverAttentionController ()

@end

@implementation HTDiscoverAttentionController

@synthesize tableView = _tableView;

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	
}

- (void)didSelectedTableView:(UITableView *)tableView cell:(UITableViewCell *)cell row:(NSInteger)row model:(THToeflDiscoverModel *)model {
	THToeflDiscoverDetailController *detailController = [[THToeflDiscoverDetailController alloc] init];
	detailController.discoverId = model.ID;
	[detailController setDetailDidDismissBlock:^(THToeflDiscoverModel *discoverModel) {
		[self.pageModel.modelArray replaceObjectAtIndex:row withObject:discoverModel];
		[cell setModel:discoverModel row:row];
	}];
	[self.navigationController pushViewController:detailController animated:true];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ht_w, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 44)];
		_tableView.backgroundColor = [UIColor ht_colorStyle:HTColorStyleCompareBackground];
		_tableView.ht_pageSize = 20;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		__weak typeof(self) weakSelf = self;
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([THToeflDiscoverTableCell class]).rowHeight(100) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
				[weakSelf didSelectedTableView:tableView cell:cell row:row model:model];
			}] didScrollBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet) {
				
            }];
		}];
	}
	return _tableView;
}

@end
