//
//  HTStoreController.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStoreController.h"
#import "HTReuseController.h"
#import "HTUserStoreManager.h"
#import <UIScrollView+HTRefresh.h>
#import "HTStoreItemModel.h"
#import "HTStoreContentController.h"

@interface HTStoreController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation HTStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    HTReuseController *reuseController = [self currentViewController];
    [reuseController.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.magicView.scrollEnabled = false;
    self.navigationItem.title = @"我的收藏";
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
    self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
        
    NSArray *itemModelArray = [HTStoreItemModel packModelArray];
    NSMutableArray *pageModelArray = [@[] mutableCopy];
    [itemModelArray enumerateObjectsUsingBlock:^(HTStoreItemModel *itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
        HTPageModel *pageModel = [[HTPageModel alloc] init];
        pageModel.selectedTitle = itemModel.title;
        pageModel.reuseControllerClass = [HTStoreContentController class];
        [pageModelArray addObject:pageModel];
    }];
    self.pageModelArray = pageModelArray;
    
    [self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<HTUserStoreModel *> *, HTError *)) {
        HTStoreItemModel *itemModel = itemModelArray[pageIndex.integerValue];
        HTUserStoreType type = itemModel.type;
        NSMutableArray *modelArray = [HTUserStoreManager selectedStoreModelArrayWithType:type pageSize:pageCount currentPage:currentPage];
        modelArrayStatus(modelArray, nil);
    }];
    [self.magicView reloadData];
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof HTReuseController *)viewController atPage:(NSUInteger)pageIndex {
    [viewController.tableView addGestureRecognizer:self.panGestureRecognizer];
    [super magicView:magicView viewDidAppear:viewController atPage:pageIndex];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    [self.magicView handlePanGesture:recognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return false;
    }
    return true;
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGestureRecognizer.cancelsTouchesInView = true;
        _panGestureRecognizer.delegate = self;
    }
    return _panGestureRecognizer;
}

@end
