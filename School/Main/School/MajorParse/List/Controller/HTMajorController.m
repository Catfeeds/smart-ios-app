//
//  HTMajorController.m
//  School
//
//  Created by hublot on 17/9/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTMajorController.h"
#import "HTMajorContentController.h"
#import "HTMajorItemModel.h"
#import "HTMajorModel.h"

@interface HTMajorController ()

@property (nonatomic, strong) NSArray *itemModelArray;

@end

@implementation HTMajorController

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
            [HTRequestManager requestMajorCatListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
                BOOL error = errorModel.existError;
                if (error) {
                    weakSelf.view.placeHolderState = HTPlaceholderStateNetwork;
                    return;
                }
                NSMutableArray *itemModelArray = [HTMajorItemModel mj_objectArrayWithKeyValuesArray:response[@"category"]];
                weakSelf.itemModelArray = itemModelArray;
                [weakSelf packPageModelArray];
            }];
        }
    }];
    weakSelf.view.reloadNetworkBlock();
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"专业解析";
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
    self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
}

- (void)packPageModelArray {
    
    
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *pageModelArray = [@[] mutableCopy];
    [self.itemModelArray enumerateObjectsUsingBlock:^(HTMajorItemModel *model, NSUInteger index, BOOL * _Nonnull stop) {
        HTPageModel *pageModel = [[HTPageModel alloc] init];
        pageModel.selectedTitle = model.name;
        pageModel.reuseControllerClass = [HTMajorContentController class];
        [pageModelArray addObject:pageModel];
    }];
    self.pageModelArray = pageModelArray;
    [self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<NSString *> *, HTError *)) {
        HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
        HTMajorItemModel *model = weakSelf.itemModelArray[pageIndex.integerValue];
        [HTRequestManager requestMajorListWithNetworkModel:networkModel catIdString:model.ID pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
            if (errorModel.existError) {
                modelArrayStatus(nil, errorModel);
                return;
            }
            NSArray *modelArray = [HTMajorModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
            modelArrayStatus(modelArray, nil);
        }];
    }];
    [self.magicView reloadData];
}

@end
