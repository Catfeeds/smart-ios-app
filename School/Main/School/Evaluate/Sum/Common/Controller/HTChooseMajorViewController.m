//
//  HTChooseMajorViewController.m
//  School
//
//  Created by Charles Cao on 2017/12/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseMajorViewController.h"
#import "HTChooseMajorCell.h"

@interface HTChooseMajorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *majorTableView;
//@property (nonatomic, strong) NSString *

@end

@implementation HTChooseMajorViewController

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
	if (self.selectMajorModel) {
		[self.majorTableView reloadData];
	}else{
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				
			}
			HTMatriculateDynamicModel *majorModel = [HTMatriculateDynamicModel mj_objectWithKeyValues:response];
			self.majorArray = majorModel.major;
			[self.majorTableView reloadData];
		}];
	}
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.type == HTMajorFirstType) {
		return self.majorArray.count;
	}else
		return self.selectMajorModel.child.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTChooseMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTChooseMajorCell"];
	
	HTSchoolMatriculateSelectedModel *selectedModel;
	if (self.type == HTMajorFirstType) {
		selectedModel = self.majorArray[indexPath.row];
	}else{
		selectedModel = self.selectMajorModel.child[indexPath.row];
	}
	
	cell.textLabel.textColor = [UIColor ht_colorString:@"525252"];
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = selectedModel.name;
	cell.accessoryType = selectedModel.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	HTSchoolMatriculateSelectedModel *selectedModel = self.majorArray[indexPath.row];
	selectedModel.isSelected = YES;
	if (self.type == HTMajorFirstType) {
		HTChooseMajorViewController *controller = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseMajorViewController");
		controller.type = HTMajorSecondType;
		controller.selectMajorModel = self.majorArray[indexPath.row];
		controller.delegate = self.delegate;
		[self.navigationController pushViewController:controller animated:YES];
	}else{
		[self.delegate chooseMajor:self.selectMajorModel detailMajor:selectedModel];

		UIViewController *popToController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
		[self.navigationController popToViewController:popToController animated:YES];
		
	}
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
