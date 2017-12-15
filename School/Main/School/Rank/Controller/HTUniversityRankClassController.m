//
//  HTUniversityRankController.m
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUniversityRankClassController.h"
#import "HTUniversityRankClassModel.h"
#import "HTUniversityRankClassCell.h"
#import "HTUniversityRankController.h"

@interface HTUniversityRankClassController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *rankClassArray;

@end

@implementation HTUniversityRankClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	networkModel.autoAlertString = @"获取排名分类";
	[HTRequestManager requestRankClassListWithNetworkModel:networkModel currentPage:nil pageSize:nil complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
		self.rankClassArray = [HTUniversityRankClassModel mj_objectArrayWithKeyValuesArray:response[@"class"]];
		[self.tableView reloadData];
	}];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.rankClassArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTUniversityRankClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTUniversityRankClassCell"];
	cell.rankClass = self.rankClassArray[indexPath.section];
	return cell;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	UIView *v = [UIView new];
	v.backgroundColor = [UIColor whiteColor];
	return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTUniversityRankClassModel *selectModel = self.rankClassArray[indexPath.section];
	[self performSegueWithIdentifier:@"RankClassToRankList" sender:selectModel];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	HTUniversityRankController *controller = segue.destinationViewController;
	controller.selectedRankClassModel = sender;
}


@end
