//
//  HTUniversityRankController.m
//  School
//
//  Created by Charles Cao on 2017/12/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUniversityRankController.h"
#import <UIScrollView+HTRefresh.h>
#import "HTUniversityRankCell.h"
#import "MJRefresh.h"
#import "HTSchoolController.h"
#import "HTRankYearCollectionCell.h"

@interface HTUniversityRankController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) HTYearModel *selectedYear;
@property (nonatomic, strong) NSMutableArray<HTUniversityRankModel *> *schoolRankModelArray;
@property (nonatomic, strong) HTNetworkModel *networkModel;
@property (nonatomic, strong) NSArray<HTYearModel *> *yearArray;

@property (weak, nonatomic) IBOutlet UICollectionView *yearCollectionView;

@end

@implementation HTUniversityRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.schoolRankModelArray = [NSMutableArray array];
	self.currentPage = 1;
	self.networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	[self loadInterface];
    [self requestUniversityRank];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInterface{
	
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.currentPage = 1;
		[self requestUniversityRank];
	}];
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.tableView.mj_header = headerHeader;
	
    
    MJRefreshBackNormalFooter *footerHeader = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.currentPage++;
		[self requestUniversityRank];
	}];
    footerHeader.stateLabel.hidden = YES;
	self.tableView.mj_footer = footerHeader;
	
	//[self chooseYearAction:self.yearButton_2018];
}

- (void)setSelectedRankClassModel:(HTUniversityRankClassModel *)selectedRankClassModel{
	_selectedRankClassModel = selectedRankClassModel;
	self.title = selectedRankClassModel.name;
}

- (void)chooseYearAction:(HTYearModel *)yaer{
    self.selectedYear = yaer;
    self.currentPage = 1;
    [self requestUniversityRank];
}

- (void)requestUniversityRank{
	
	[HTRequestManager requestRankSchoolListWithNetworkModel:self.networkModel classIdString:self.selectedRankClassModel.ID yearIdString:self.selectedYear.ID currentPage:@(self.currentPage).stringValue pageSize:@"10" complete:^(id response, HTError *errorModel) {
		
		[self.tableView.mj_header endRefreshing];
		[self.tableView.mj_footer endRefreshing];
		
		if (errorModel.existError) {
			[self.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
			return;
		}
				
        HTSchoolRankModel *schoolRankModel = [HTSchoolRankModel mj_objectWithKeyValues:response];
        NSArray *modelArray = schoolRankModel.data;
		if (!ArrayNotEmpty(self.yearArray)) {
			self.yearArray = schoolRankModel.years;;
			[self.yearCollectionView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.yearCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
            [self chooseYearAction:self.yearArray.firstObject];
		}
		if (self.currentPage == 1) {
            [self.tableView setContentOffset:CGPointZero];
            [self.schoolRankModelArray setArray:modelArray];
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            if (ArrayNotEmpty(self.schoolRankModelArray)) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
		}else if(ArrayNotEmpty(modelArray)){
			NSMutableArray *indexPathArray =  [NSMutableArray array];
			for (int i = 0; i < modelArray.count; i++) {
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.schoolRankModelArray.count + i inSection:0];
				[indexPathArray addObject:indexPath];
			}
			[self.schoolRankModelArray addObjectsFromArray:modelArray];
			[self.tableView beginUpdates];
			[self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
			[self.tableView endUpdates];
        }
        
      //  [self.tableView ht_endRefreshWithModelArrayCount:self.schoolRankModelArray.count];
        
	}];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.schoolRankModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTUniversityRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTUniversityRankCell"];
	cell.rankModel = self.schoolRankModelArray[indexPath.row];
	cell.rankNum = indexPath.row + 1;
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTSchoolController *schoolController = [HTSchoolController new];
	schoolController.schoolIdString = self.schoolRankModelArray[indexPath.row].relationId;
	[self.navigationController pushViewController:schoolController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.yearArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	HTRankYearCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTRankYearCollectionCell" forIndexPath:indexPath];
    cell.year = self.yearArray[indexPath.row];
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self chooseYearAction:self.yearArray[indexPath.row]];
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
