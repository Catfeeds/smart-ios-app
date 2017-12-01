//
//  HTAnswerController.m
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerController.h"
#import "HTAnswerMainController.h"
#import "HTAnswerOnlineController.h"
#import "HTAnswerIssueController.h"
#import "HTSearchController.h"
#import "HTAnswerHeaderView.h"
#import <UIButton+HTButtonCategory.h>
#import "HTAnswerTagManager.h"
#import "HTAnswerContentController.h"
#import "HTDiscoverActivityModel.h"
#import "HTAnswerTagController.h"

@interface HTAnswerController ()

@property (nonatomic, strong) NSArray *tagModelArray;

@end

@implementation HTAnswerController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (!self.tagModelArray.count) {
		[self refreshAnswerControllerHeader];
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)initializeDataSource {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAnswerControllerHeader) name:kHTSelectedTagArrayDidChangeNotifacation object:nil];
}

- (void)initializeUserInterface {
	[self.navigationController setNavigationBarHidden:true animated:false];
	self.navigationItem.title = @"问答";
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	
	__weak typeof(self) weakSelf = self;
	UIButton *rightTagButton = [[UIButton alloc] init];
	[rightTagButton ht_whenTap:^(UIView *view) {
		HTAnswerTagController *tagController = [[HTAnswerTagController alloc] init];
		[weakSelf.navigationController pushViewController:tagController animated:true];
	}];
	UIImage *image = [UIImage imageNamed:@"cn_answer_append"];
	image = [image ht_resetSizeZoomNumber:0.6];
	[rightTagButton setImage:image forState:UIControlStateNormal];
	[rightTagButton setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 10)];
	[rightTagButton sizeToFit];
	self.magicView.rightNavigatoinItem = rightTagButton;

	
	[self initializeMagicView];
    [self refreshAnswerControllerHeader];
}

- (void)initializeMagicView {
	HTAnswerHeaderView *headerView = [[HTAnswerHeaderView alloc] initWithFrame:CGRectMake(0, 0, HTSCREENWIDTH, 240)];
	self.magicView.headerHeight = headerView.ht_h;
	self.magicView.headerHidden = false;
	[self.magicView.headerView addSubview:headerView];
}

- (void)refreshAnswerControllerHeader {
	
	__weak typeof(self) weakSelf = self;
	[HTAnswerTagManager requestCurrentAnswerTagArrayBlock:^(NSMutableArray *answerTagArray) {
		NSMutableArray *tagModelArray = [answerTagArray mutableCopy];
		
		[answerTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *tagModel, NSUInteger idx, BOOL * _Nonnull stop) {
			if (!tagModel.isEnable) {
				[tagModelArray removeObject:tagModel];
			}
		}];
		
		HTAnswerTagModel *model = [[HTAnswerTagModel alloc] init];
		model.name = @"全部";
		model.isEnable = true;
		[tagModelArray insertObject:model atIndex:0];
		
		_tagModelArray = tagModelArray;
		
		NSMutableArray *pageModelArray = [@[] mutableCopy];
		[tagModelArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *tagModel, NSUInteger index, BOOL * _Nonnull stop) {
			HTPageModel *pageModel = [[HTPageModel alloc] init];
			pageModel.selectedTitle = tagModel.name;
			pageModel.reuseControllerClass = [HTAnswerContentController class];
			[pageModelArray addObject:pageModel];
		}];
		self.pageModelArray = pageModelArray;
		[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<HTDiscoverActivityModel *> *, HTError *)) {
			if (pageIndex.integerValue > weakSelf.tagModelArray.count) {
				return;
			}
			HTAnswerTagModel *tagModel = tagModelArray[pageIndex.integerValue];
			HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
			NSString *answerTagString = tagModel.ID;
			[HTRequestManager requestAnswerListWithNetworkModel:networkModel answerTagString:answerTagString pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					modelArrayStatus(nil, errorModel);
					return;
				}
				NSArray *answerModelArray = [HTAnswerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
				modelArrayStatus(answerModelArray, nil);
			}];
		}];
		[self.magicView reloadData];
	}];
	
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
	UITableView *tableView = viewController.tableView;
	
	__weak typeof(self) weakSelf = self;
	[tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
		[sectionMaker willEndDraggingBlock:^(UIScrollView *scrollView, CGPoint contentOffSet, UIEdgeInsets contentInSet, CGPoint velocity, CGPoint targetContentOffSet) {
			if (velocity.y > 0.3) {
				if (!weakSelf.magicView.headerHidden) {
					[weakSelf.magicView setHeaderHidden:true duration:0.4];
					[self.navigationController setNavigationBarHidden:false animated:false];
				}
			} else if (targetContentOffSet.y < 0 || velocity.y < - 1) {
				if (weakSelf.magicView.headerHidden) {
					[weakSelf.magicView setHeaderHidden:false duration:0.4];
					[self.navigationController setNavigationBarHidden:true animated:false];
				}
			}
		}];
	}];
	
	[super magicView:magicView viewDidAppear:viewController atPage:pageIndex];
	
}
@end
