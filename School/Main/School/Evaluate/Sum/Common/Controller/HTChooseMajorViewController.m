//
//  HTChooseMajorViewController.m
//  School
//
//  Created by Charles Cao on 2017/12/4.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseMajorViewController.h"
#import "HTChooseMajorCell.h"
#import "RTRootNavigationController.h"

@interface HTChooseMajorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *majorTableView;
@property (nonatomic, strong) NSArray *majorArray;

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
        if (self.selectedDetailMajorId) {
            [self.selectMajorModel.child enumerateObjectsUsingBlock:^(HTMatriculateProfessionalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.ID isEqualToString:self.selectedDetailMajorId]) {
                    obj.isSelected = YES;
                }
            }];
        }
        
		[self.majorTableView reloadData];
	}else{
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		networkModel.autoAlertString = @"选择专业";
		[HTRequestManager requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				
			}
			HTMatriculateDynamicModel *majorModel = [HTMatriculateDynamicModel mj_objectWithKeyValues:response];
			self.majorArray = majorModel.major;
            if (self.selectedMajorId) {
                [self.majorArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    HTMatriculateMajorModel *major = (HTMatriculateMajorModel*)obj;
                    if ([major.ID isEqualToString:self.selectedMajorId]) {
                        major.isSelected = YES;
                        *stop = YES;
                    }
                }];
            }
            
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
	if (self.type == HTMajorFirstType) {
        HTSchoolMatriculateSelectedModel *selectedModel = self.majorArray[indexPath.row];
        selectedModel.isSelected = YES;
		HTChooseMajorViewController *controller = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseMajorViewController");
		controller.type = HTMajorSecondType;
        controller.selectedDetailMajorId = self.selectedDetailMajorId;
		controller.selectMajorModel = self.majorArray[indexPath.row];
		controller.delegate = self.delegate;
		[self.navigationController pushViewController:controller animated:YES];
	}else{
        HTSchoolMatriculateSelectedModel *selectedModel = self.selectMajorModel.child[indexPath.row];
        selectedModel.isSelected = YES;
		[self.delegate chooseMajor:self.selectMajorModel detailMajor:selectedModel];
        UIViewController *popToController = [self.rt_navigationController.rt_viewControllers objectAtIndex:self.rt_navigationController.rt_viewControllers.count - 3];
		
		[self.rt_navigationController popToViewController:popToController animated:YES];
		
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
