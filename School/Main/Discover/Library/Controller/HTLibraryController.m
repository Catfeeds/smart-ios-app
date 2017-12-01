//
//  HTLibraryController.m
//  School
//
//  Created by hublot on 17/8/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLibraryController.h"
#import "HTDiscoverItemModel.h"
#import "HTLibraryModel.h"
#import "HTLibraryApplyController.h"

@interface HTLibraryController ()

@property (nonatomic, strong) HTLibraryModel *libraryModel;

@end

@implementation HTLibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"知识库";
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
    self.magicView.sliderHeight =  1 / [UIScreen mainScreen].scale;
	
	__weak typeof(self) weakSelf = self;
    NSArray *libraryModelArray = [HTDiscoverItemModel packModelArray];
    NSMutableArray *pageModelArray = [@[] mutableCopy];
    [libraryModelArray enumerateObjectsUsingBlock:^(HTDiscoverItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
        HTPageModel *pageModel = [[HTPageModel alloc] init];
        pageModel.selectedTitle = model.titleName;
        pageModel.reuseControllerClass = model.controllerClass;
        [pageModelArray addObject:pageModel];
    }];
    self.pageModelArray = pageModelArray;
    [self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void(^modelArrayStatus)(NSArray *modelArray, HTError *errorModel)) {
		if (weakSelf.libraryModel) {
			modelArrayStatus(@[weakSelf.libraryModel], nil);
		} else {
			HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
			[HTRequestManager requestLibrarayListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					modelArrayStatus(nil, errorModel);
					return;
				}
				HTLibraryModel *libraryModel = [HTLibraryModel mj_objectWithKeyValues:response];
				weakSelf.libraryModel = libraryModel;
				modelArrayStatus(@[weakSelf.libraryModel], nil);
			}];
		}
    }];
    
    [self.magicView reloadData];
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
	UIViewController *controller = [super magicView:magicView viewControllerAtPage:pageIndex];
	if ([controller isKindOfClass:[HTLibraryApplyController class]]) {
		HTLibraryApplyController *applyController = (HTLibraryApplyController *)controller;
		applyController.reuseControllerIndex = pageIndex;
	}
	return controller;
}

@end
