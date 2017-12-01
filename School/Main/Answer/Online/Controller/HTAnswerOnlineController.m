//
//  HTAnswerOnlineController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerOnlineController.h"
#import "HTAnswerOnlineCell.h"

@interface HTAnswerOnlineController ()

@end

@implementation HTAnswerOnlineController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		sectionMaker.cellClass([HTAnswerOnlineCell class]).rowHeight(195);
	}];
}

@end
