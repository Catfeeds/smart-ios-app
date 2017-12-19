//
//  HTStudyCommunityController.m
//  School
//
//  Created by Charles Cao on 2017/12/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyCommunityController.h"
#import "HTDiscoverController.h"

@interface HTStudyCommunityController ()

@property (nonatomic, strong) UISegmentedControl *segement;
@property (nonatomic, strong) NSArray *childControllerArray;

@end

@implementation HTStudyCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.segement =  [[UISegmentedControl alloc]initWithItems:@[@"吐槽",@"发现",@"申请指南"]];
	self.segement.selectedSegmentIndex = 0;
	[self.segement addTarget:self action:@selector(changeController:) forControlEvents:UIControlEventValueChanged];
	self.segement.tintColor = [UIColor whiteColor];
	self.navigationItem.titleView = self.segement;
	
	self.magicView.navigationHeight = 0;
	
	HTDiscoverController *discover = [HTDiscoverController new];
	UIViewController *discuss = [UIViewController new];
	UIViewController *apply = [UIViewController new];
	self.childControllerArray = @[discover,discuss,apply];
	
}

- (void)changeController:(UISegmentedControl *)segement{
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
	return  self.childControllerArray[pageIndex];
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
