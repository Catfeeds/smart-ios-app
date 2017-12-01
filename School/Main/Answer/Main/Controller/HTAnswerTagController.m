//
//  HTAnswerTagController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerTagController.h"
#import "HTAnswerTagModel.h"
#import <UIScrollView+HTRefresh.h>
#import "HTAnswerTagCell.h"
#import <UITableViewCell_HTSeparate.h>
#import "RTDragCellTableView.h"
#import "HTAnswerTagManager.h"

@interface HTAnswerTagController () <RTDragCellTableViewDataSource, RTDragCellTableViewDelegate>

@property (nonatomic, strong) RTDragCellTableView *tableView;

@property (nonatomic, strong) NSMutableArray *tagModelArray;

@end

@implementation HTAnswerTagController

static NSString *kHTAnswerTagCellIdentifier = @"kHTAnswerTagCellIdentifier";

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[HTAnswerTagManager saveSelectedAnswerTagArray:self.tagModelArray];
}

- (void)initializeDataSource {
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		[HTAnswerTagManager requestCurrentAnswerTagArrayBlock:^(NSMutableArray *answerTagArray) {
			weakSelf.tagModelArray = answerTagArray;
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:1];
			[weakSelf.tableView reloadData];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"标签管理";
	[self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.tagModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	HTAnswerTagCell *cell = [tableView dequeueReusableCellWithIdentifier:kHTAnswerTagCellIdentifier];
	NSInteger row = indexPath.row;
	HTAnswerTagModel *model = self.tagModelArray[row];
	[cell setModel:model row:row];
	return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	[self.tagModelArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

- (NSArray *)originalArrayDataForTableView:(RTDragCellTableView *)tableView {
	return self.tagModelArray;
}

- (void)tableView:(RTDragCellTableView *)tableView newArrayDataForDataSource:(NSMutableArray *)newArray {
	self.tagModelArray = newArray;
}

- (RTDragCellTableView *)tableView {
	if (!_tableView) {
		_tableView = [[RTDragCellTableView alloc] init];
		_tableView.frame = self.view.bounds;
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.rowHeight = 50;
		_tableView.allowsSelection = false;
		[_tableView registerClass:[HTAnswerTagCell class] forCellReuseIdentifier:kHTAnswerTagCellIdentifier];
	}
	return _tableView;
}


@end
