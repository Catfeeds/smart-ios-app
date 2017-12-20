//
//  HTStudyAbroadController.m
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyAbroadController.h"
#import "MJRefresh.h"
#import <UIScrollView+HTRefresh.h>
#import "HTStudyAbroadCell.h"
#import "HTStudyAbroadSelectorController.h"

@interface HTStudyAbroadController () <UITableViewDataSource, UITableViewDelegate, HTSelectorDelegate>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *selectedCountryID;
@property (nonatomic, strong) NSString *selectedCategoryID;
@property (nonatomic, assign) NSInteger selectedSortType;
@property (nonatomic, strong) NSMutableArray *studyAbroadDataArray;
@property (nonatomic, strong) UIButton *selectedSortButton;
@property (nonatomic, strong) HTStudyAbroadSelectorController *studyAbroadSelectorController;
@property (nonatomic, strong) HTStudyAbroadModel *studyAbroadModel;

@end

@implementation HTStudyAbroadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.page = 1;
	self.studyAbroadDataArray = [NSMutableArray array];
	self.selectedSortButton = self.sortButton_all;
	self.studyAbroadSelectorController = self.childViewControllers.firstObject;
	self.studyAbroadSelectorController.delegate = self;
	[self loadInterface];
	[self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInterface{
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.page = 1;
		[self loadData];
	}];
	
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.tableView.mj_header = headerHeader;
	
	MJRefreshBackNormalFooter *footerHeader = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.page++;
		[self loadData];
	}];
    footerHeader.stateLabel.hidden = YES;
	self.tableView.mj_footer = footerHeader;
}

- (void)loadData{
	
	[HTRequestManager requestStudyAbroadWithNetworkModel:nil page:@(self.page).stringValue countryID:self.selectedCountryID categoryID:self.selectedCategoryID sortType:self.selectedSortType complete:^(id response, HTError *errorModel) {
		
		if (errorModel.existError) {
			[self.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
		
		self.studyAbroadModel = [HTStudyAbroadModel mj_objectWithKeyValues:response];
		NSArray *modelArray = self.studyAbroadModel.data;
		if (self.page == 1) {
			if (modelArray.count == 0) [self.tableView ht_endRefreshWithModelArrayCount:0];
            [self.studyAbroadDataArray setArray:modelArray];
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            if (ArrayNotEmpty(self.studyAbroadDataArray)) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
		}else if(ArrayNotEmpty(modelArray)){
			NSMutableArray *indexPathArray =  [NSMutableArray array];
			for (int i = 0; i < modelArray.count; i++) {
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.studyAbroadDataArray.count + i inSection:0];
				[indexPathArray addObject:indexPath];
			}
			[self.studyAbroadDataArray addObjectsFromArray:modelArray];
			[self.tableView beginUpdates];
			[self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
			[self.tableView endUpdates];
		}
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
	}];
}

/*
 排序
 tag-100:综合
 tag-101:销量
 tag-102:价格
 tag-103:最新
*/
- (IBAction)sortAction:(UIButton *)sender {
	NSInteger clickIndex = sender.tag - 100;
	if (sender != self.selectedSortButton) {
		sender.selected = YES;
		self.selectedSortButton.selected = NO;
		self.selectedSortButton = sender;
		self.lineCenterLayoutConstraint.constant += CGRectGetWidth(sender.frame) * (clickIndex - self.selectedSortType);
	}
	self.page = 1;
	self.selectedSortType = clickIndex;
	[self loadData];
}

//选择服务 / 国家
- (IBAction)showSelectorAction:(UIButton *)sender {
    
	if (sender == self.countryButton) {
        self.serviceButton.selected = NO;
		[self.studyAbroadSelectorController reloadDataModels:self.studyAbroadModel.countrys selecetdModelId:self.selectedCountryID];
	}else{
        self.countryButton.selected = NO;
		[self.studyAbroadSelectorController reloadDataModels:self.studyAbroadModel.serviceTypes selecetdModelId:self.selectedCategoryID];
	}
    sender.selected = YES;
	[self.view bringSubviewToFront:self.selectorView];
}


#pragma mark - HTSelectorDelegate

- (void)selectedModel:(HTStudyAbroadSelectorModel *)selectedMoel{
	if (selectedMoel.type == HTSelectorModelCountryType)
	{
        [self.countryButton setTitle:selectedMoel.name forState:UIControlStateNormal];
		self.selectedCountryID = selectedMoel.ID;
	}else{
        [self.serviceButton setTitle:selectedMoel.name forState:UIControlStateNormal];
		self.selectedCategoryID = selectedMoel.ID;
	}
    self.page = 1;
    [self loadData];
}

- (void)hiddenSelectorView{
    self.countryButton.selected = NO;
    self.serviceButton.selected = NO;
    [self.view sendSubviewToBack:self.selectorView];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.studyAbroadDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTStudyAbroadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTStudyAbroadCell"];
	cell.studyAbroadData = self.studyAbroadDataArray[indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate

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
