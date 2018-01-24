//
//  HTApplyController.m
//  School
//
//  Created by Charles Cao on 2017/12/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTApplyController.h"
#import "HTDiscoverItemModel.h"
#import "HTLibraryModel.h"
#import "HTLibraryApplyController.h"
#import "HTUniversityRankClassModel.h"

@interface HTApplyController () <HTLibraryApplyControllerDelegate>

@property (nonatomic, strong) HTLibraryModel *libraryModel;

@end

@implementation HTApplyController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface:NO];
}



- (void)initializeDataSource {
	
}

//isRefreshWithService 是否从服务器刷新
- (void)initializeUserInterface:(BOOL)isRefreshWithService {
	
	self.magicView.navigationHeight = 44;
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.magicView.sliderHeight =  1 / [UIScreen mainScreen].scale;
	
	
	__weak typeof(self) weakSelf = self;
	NSArray *libraryModelArray = [HTDiscoverItemModel applyModelArray];
	NSMutableArray *pageModelArray = [@[] mutableCopy];
	[libraryModelArray enumerateObjectsUsingBlock:^(HTDiscoverItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		HTPageModel *pageModel = [[HTPageModel alloc] init];
		pageModel.selectedTitle = model.titleName;
		pageModel.reuseControllerClass = model.controllerClass;
		[pageModelArray addObject:pageModel];
	}];
	self.pageModelArray = pageModelArray;
	[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void(^modelArrayStatus)(NSArray *modelArray, HTError *errorModel)) {
		if (weakSelf.libraryModel && !isRefreshWithService) {
			modelArrayStatus(@[weakSelf.libraryModel], nil);
		} else {
			HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
			[HTRequestManager requestLibrarayListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					modelArrayStatus(nil, errorModel);
					return;
				}
				HTLibraryModel *libraryModel = [HTLibraryModel mj_objectWithKeyValues:response];
				[HTRequestManager requestRankClassListWithNetworkModel:networkModel currentPage:nil pageSize:nil complete:^(id response, HTError *errorModel) {
					if (errorModel.existError) {
						return;
					}
					
					//获取大学分类排名 替换知识库'申请前'里面的大学排名
					NSArray<HTUniversityRankClassModel *> *classArray = [HTUniversityRankClassModel mj_objectArrayWithKeyValuesArray:response[@"classes"]];
					NSMutableArray *arr = [NSMutableArray array];
					[classArray enumerateObjectsUsingBlock:^(HTUniversityRankClassModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						HTLibraryApplyContentModel *model = [[HTLibraryApplyContentModel alloc]init];
						model.name = obj.name;
						model.ID = obj.ID;
						model.type = 1;
						[arr addObject:model];
					}];
					//替换'申请前'的大学排名
					[libraryModel.apply enumerateObjectsUsingBlock:^(HTLibraryApplyTypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						if (obj.ID.integerValue == 339) {
							[obj.child enumerateObjectsUsingBlock:^(HTLibraryApplyHeaderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
								if (obj.ID.integerValue == 342) {
									obj.data = arr;
								}
							}];
						}
					}];
					weakSelf.libraryModel = libraryModel;
					modelArrayStatus(@[weakSelf.libraryModel], nil);
				}];
			}];
		}
	}];
	
	[self.magicView reloadData];
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	UIViewController *controller = [super magicView:magicView viewControllerAtPage:pageIndex];
	if ([controller isKindOfClass:[HTLibraryApplyController class]]) {
		HTLibraryApplyController *applyController = (HTLibraryApplyController *)controller;
		applyController.delegate = self;
		applyController.reuseControllerIndex = pageIndex;
	}
	return controller;
}


#pragma mark - HTLibraryApplyControllerDelegate

- (void)refresh{
	[self initializeUserInterface:YES];
}

@end
