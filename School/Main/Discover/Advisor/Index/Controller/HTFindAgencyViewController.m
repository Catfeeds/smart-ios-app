//
//  HTFindAgencyViewController.m
//  School
//
//  Created by Charles Cao on 2017/12/13.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTFindAgencyViewController.h"
#import "HTIndexAdvisorController.h"
#import "HTOrganizationController.h"

@interface HTFindAgencyViewController () <VTMagicViewDataSource, VTMagicViewDelegate >

@property (nonatomic, strong) UISegmentedControl *segement;

@end

@implementation HTFindAgencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.magicView.dataSource = self;
	self.magicView.delegate = self;
	self.magicView.navigationHeight = 0;
	[self.magicView reloadData];
	
	self.segement =  [[UISegmentedControl alloc]initWithItems:@[@"寻机构",@"选顾问"]];
	self.segement.frame = CGRectMake(0, 0, 180, 30);
	self.segement.selectedSegmentIndex = 0;
	[self.segement addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventValueChanged];
	self.segement.tintColor = [UIColor whiteColor];
	self.navigationItem.titleView = self.segement;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTFindAgencyTitleViewDelegate

- (void)changeController:(UISegmentedControl *)segmented{
	
	[self.magicView switchToPage:segmented.selectedSegmentIndex animated:YES];
}


#pragma mark - VTMagicViewDataSource

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
	return @[@"寻机构",@"选顾问"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
	static NSString *itemIdentifier = @"itemIdentifier";
	UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (!menuItem) {
		menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
		[menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
		[menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
		menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
	}
	return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
	if (pageIndex == 0) {
		static NSString *recomId = @"HTOrganizationController";
		HTOrganizationController *organizationController = [magicView dequeueReusablePageWithIdentifier:recomId];
		if (!organizationController) {
			organizationController = [[HTOrganizationController alloc] init];
		}
		return organizationController;
	}
	
	static NSString *gridId = @"HTIndexAdvisorController";
	HTIndexAdvisorController *advisorController = [magicView dequeueReusablePageWithIdentifier:gridId];
	if (!advisorController) {
		advisorController = [[HTIndexAdvisorController alloc] init];
	}
	return advisorController;
}


#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex{
	self.segement.selectedSegmentIndex = pageIndex;
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
