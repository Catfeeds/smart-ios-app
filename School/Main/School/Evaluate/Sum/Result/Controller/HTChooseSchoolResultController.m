//
//  HTChooseSchoolResultController.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolResultController.h"
#import "HTConditionCell.h"
#import "HTAllSchoolCell.h"
#import "HTChooseSchoolCell.h"
#import "HTChooseSchoolEvaluationResultModel.h"

@interface HTChooseSchoolResultController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HTChooseSchoolResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutHeaderView:(NSString *)userName score:(NSString *)score {
	self.tableHeaderView.layer.borderWidth 	 = 7;
	self.tableHeaderView.layer.borderColor 	 = [UIColor ht_colorString:@"8cb93e"].CGColor;
	self.tableHeaderView.layer.cornerRadius	 = 5;
	self.tableHeaderView.layer.masksToBounds = YES;
	
	NSMutableAttributedString *userNameAttributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@,%@",userName,@"你的得分"]];
	[userNameAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"8cb93e"] range:NSMakeRange(0, userName.length)];
	[userNameAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"484848"] range:NSMakeRange(userName.length, userNameAttributeString.length - userName.length)];

	self.userNameLabel.attributedText = userNameAttributeString;
	[self.scoreButton setTitle:score forState:UIControlStateNormal];
//	[self.tableHeaderView sizeToFit];
	
}

- (void)loadData{
	
	HTNetworkModel *resultNetwork = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
	[HTRequestManager requestSchoolMatriculateAllResultListWithNetworkModel:resultNetwork resultIdString:@"" complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
		
		HTChooseSchoolEvaluationResultModel *resultModel = [HTChooseSchoolEvaluationResultModel mj_objectWithKeyValues:response];
		[self layoutHeaderView:resultModel.user.userName score:resultModel.data.score];
		
	}];
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return nil;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
