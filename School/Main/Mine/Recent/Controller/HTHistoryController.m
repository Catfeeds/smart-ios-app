//
//  HTHistoryController.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTHistoryController.h"
#import "HTHistoryItemModel.h"
#import "HTUserHistoryManager.h"
#import "HTHistoryContentController.h"
#import <UIScrollView+HTRefresh.h>

@interface HTHistoryController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation HTHistoryController

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
	self.navigationItem.title = @"浏览历史";
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
    
    __weak typeof(self) weakSelf = self;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"全部清空" style:UIBarButtonItemStylePlain handler:^(id sender) {
		[HTAlert title:@"确定要全部清空吗" sureAction:^{
			[HTUserHistoryManager deleteAllHistoryModel];
            [weakSelf initializeUserInterface];
		}];
	}];

	NSArray *itemModelArray = [HTHistoryItemModel packModelArray];
	NSMutableArray *pageModelArray = [@[] mutableCopy];
	[itemModelArray enumerateObjectsUsingBlock:^(HTHistoryItemModel *itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
		HTPageModel *pageModel = [[HTPageModel alloc] init];
		pageModel.selectedTitle = itemModel.title;
		pageModel.reuseControllerClass = [HTHistoryContentController class];
		[pageModelArray addObject:pageModel];
	}];
	self.pageModelArray = pageModelArray;
	
	[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<HTUserHistoryModel *> *, HTError *)) {
		HTHistoryItemModel *itemModel = itemModelArray[pageIndex.integerValue];
		HTUserHistoryType type = itemModel.type;
		NSMutableArray *modelArray = [HTUserHistoryManager selectedHistoryModelArrayWithType:type pageSize:pageCount currentPage:currentPage];
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
