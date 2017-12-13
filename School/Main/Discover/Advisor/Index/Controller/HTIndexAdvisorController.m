//
//  HTIndexAdvisorController.m
//  School
//
//  Created by hublot on 17/8/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAdvisorController.h"
#import "HTIndexAdvisorItemModel.h"
#import "HTIndexAdvisorModel.h"
#import "HTIndexAdvisorContentController.h"

@interface HTIndexAdvisorController ()

@property (nonatomic, strong) NSArray <HTIndexAdvisorItemModel *> *itemModelArray;

@end

@implementation HTIndexAdvisorController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}       

- (void)initializeDataSource {
    __weak typeof(self) weakSelf = self;
    [self.view setReloadNetworkBlock:^{
        if (!weakSelf.itemModelArray.count) {
            HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
            [HTRequestManager requestAdvisorCateListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
                BOOL error = errorModel.existError;
                if (error) {
                    weakSelf.view.placeHolderState = HTPlaceholderStateNetwork;
                    return;
                }
                NSMutableArray *itemModelArray = [HTIndexAdvisorItemModel mj_objectArrayWithKeyValuesArray:response[@"country"]];
				HTIndexAdvisorItemModel *sumItemModel = [[HTIndexAdvisorItemModel alloc] init];
				sumItemModel.name = @"全部";
				sumItemModel.ID = @"";
				[itemModelArray insertObject:sumItemModel atIndex:0];
                weakSelf.itemModelArray = itemModelArray;
                [weakSelf packPageModelArray];
            }];
        }
    }];
    weakSelf.view.reloadNetworkBlock();
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"选顾问";
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
    self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
}

- (void)packPageModelArray {
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *pageModelArray = [@[] mutableCopy];
    [self.itemModelArray enumerateObjectsUsingBlock:^(HTIndexAdvisorItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
        HTPageModel *pageModel = [[HTPageModel alloc] init];
        pageModel.selectedTitle = model.name;
        pageModel.reuseControllerClass = [HTIndexAdvisorContentController class];
        [pageModelArray addObject:pageModel];
    }];
    self.pageModelArray = pageModelArray;
    [self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<NSString *> *, HTError *)) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
        HTIndexAdvisorItemModel *model = weakSelf.itemModelArray[pageIndex.integerValue];
        [HTRequestManager requestAdvisorListWithNetworkModel:networkModel catIdString:model.ID pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                modelArrayStatus(nil, errorModel);
                return;
            }
            NSArray *modelArray = [HTIndexAdvisorModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            modelArrayStatus(modelArray, nil);
        }];
    }];
    [self.magicView reloadData];
}

@end
