//
//  HTOpenCourseController.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseController.h"
#import "MJRefresh.h"
#import <UIScrollView+HTRefresh.h>
#import "HTOpenCourseCell.h"
#import "HTOpenCourseDetailController.h"

@interface HTOpenCourseController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray <HTOpenCourseModel *> *courseArray;

@end

@implementation HTOpenCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.currentPage = 1;
	self.courseArray = [NSMutableArray array];
	[self loadInterface];
	[self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInterface{
	
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.currentPage = 1;
		[self loadData];
	}];
	
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.tableView.mj_header = headerHeader;
	
	MJRefreshBackNormalFooter *footerHeader = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.currentPage++;
		[self loadData];
	}];
	footerHeader.stateLabel.hidden = YES;
	self.tableView.mj_footer = footerHeader;
}

- (void)loadData{
	[HTRequestManager requestOpenCourseListWithNetworkModel:nil currentPage:@(self.currentPage).stringValue pageSize:@"10" complete:^(id response, HTError *errorModel) {
		
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
		
		if (errorModel.existError) {
			[self.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}

		NSArray *modelArray  = [HTOpenCourseModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
		
		if (self.currentPage == 1) {
			if (modelArray.count == 0) [self.tableView ht_endRefreshWithModelArrayCount:0];
			[self.courseArray setArray:modelArray];
			[self.tableView reloadData];
			
		}else if(ArrayNotEmpty(modelArray)){
			NSMutableArray *indexPathArray =  [NSMutableArray array];
			for (int i = 0; i < modelArray.count; i++) {
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.courseArray.count + i inSection:0];
				[indexPathArray addObject:indexPath];
			}
			[self.courseArray addObjectsFromArray:modelArray];
			[self.tableView beginUpdates];
			[self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
			[self.tableView endUpdates];
		}
	}];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.courseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTOpenCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTOpenCourseCell"];
	cell.courseModel = self.courseArray[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[self performSegueWithIdentifier:@"openCourseToDetail" sender:self.courseArray[indexPath.row]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	HTOpenCourseDetailController *detailController = [segue destinationViewController];
	detailController.courseId = ((HTOpenCourseModel *)sender).ID;
}


@end
