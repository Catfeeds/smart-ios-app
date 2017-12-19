//
//  HTStudyCommunityController.m
//  School
//
//  Created by Charles Cao on 2017/12/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyCommunityController.h"
#import "HTDiscoverController.h"
#import "HTCommunityController.h"
#import "THToeflDiscoverIssueController.h"
#import "HTCommunityIssueController.h"
#import "HTApplyController.h"

@interface HTStudyCommunityController ()

@property (nonatomic, strong) UISegmentedControl *segement;
@property (nonatomic, strong) UIBarButtonItem *postItem;

@property (nonatomic, strong) HTCommunityController *discussController;
@property (nonatomic, strong) HTDiscoverController *discoverController;
@property (nonatomic, strong) HTApplyController *applyController;

@end

@implementation HTStudyCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadInterface];
}

- (void)loadInterface{
	self.postItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cn_discover_issue"] style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
	
	self.discussController  = [HTCommunityController new];
	self.discoverController = [HTDiscoverController new];
	self.applyController    = [HTApplyController new];
	
	self.segement =  [[UISegmentedControl alloc]initWithItems:@[@"吐槽",@"发现",@"申请指南"]];
	[self.segement addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventValueChanged];
	self.segement.selectedSegmentIndex = 0;
	[self changeController:self.segement];
	self.segement.tintColor = [UIColor whiteColor];
	self.navigationItem.titleView = self.segement;
	self.magicView.navigationHeight = 0;
	
}

- (void)postAction{
	
	if (self.segement.selectedSegmentIndex == 0) {
		HTCommunityIssueController *issueController = [[HTCommunityIssueController alloc] init];
		issueController.delegate = self.discussController;
		[self.navigationController pushViewController:issueController animated:true];
	}else if (self.segement.selectedSegmentIndex == 1) {
		THToeflDiscoverIssueController *issueController = [[THToeflDiscoverIssueController alloc] init];
		issueController.catIdString = [self.discoverController getCurrentCatIDString];
		[self.navigationController pushViewController:issueController animated:true];
	}
}

- (void)changeController:(UISegmentedControl *)segement {
	
	self.navigationItem.rightBarButtonItem = segement.selectedSegmentIndex == 2 ? nil : self.postItem;
	[self.magicView switchToPage:segement.selectedSegmentIndex animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - VTMagicViewDataSource
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
	return @[@"吐槽",@"发现",@"申请指南"];
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex{
	if (pageIndex == 0) {
		return self.discussController;
	}else if (pageIndex == 1){
		return self.discoverController;
	}else{
		return self.applyController;
	}
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
