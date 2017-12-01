//
//  HTAnswerDetailController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerDetailController.h"
#import "HTAnswerCell.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import "HTAnswerSolutionCell.h"
#import "HTAnswerKeboardManager.h"
#import "HTUserActionManager.h"
#import "HTUserHistoryManager.h"
#import "HTUserStoreManager.h"
#import "HTStoreBarButtonItem.h"

@interface HTAnswerDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTAnswerModel *answerModel;

@end

@implementation HTAnswerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.reloadAnswerModel && self.answerModel) {
		HTAnswerModel *answerModel = [HTAnswerModel mj_objectWithKeyValues:self.answerModel.mj_keyValues];
		answerModel.isDetailModel = false;
        self.reloadAnswerModel(answerModel);
    }
}

- (void)initializeDataSource {
    __weak typeof(self) weakSelf = self;
    [self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestAnswerDetailWithNetworkModel:networkModel answerIdString:weakSelf.answerIdString complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			weakSelf.answerModel = [HTAnswerModel mj_objectWithKeyValues:response];
			weakSelf.navigationItem.title = weakSelf.answerModel.question;
			weakSelf.answerModel.isDetailModel = true;
			weakSelf.answerModel.answer = weakSelf.answerModel.answer ? weakSelf.answerModel.answer : @[];
			[weakSelf.tableView ht_endRefreshWithModelArrayCount: 1];
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(@[weakSelf.answerModel]);
			}];
			[weakSelf.tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(weakSelf.answerModel.answer);
			}];
			
			NSString *answerIdString = HTPlaceholderString(weakSelf.answerIdString, @"");
			[HTUserActionManager trackUserActionWithType:HTUserActionTypeVisitAnswerDetail keyValue:@{@"id":answerIdString}];
			[HTUserHistoryManager appendHistoryModel:[HTUserHistoryModel packHistoryModelType:HTUserHistoryTypeAnswerDetail lookId:answerIdString titleName:weakSelf.answerModel.question]];
            
            HTUserStoreModel *model = [HTUserStoreModel packStoreModelType:HTUserStoreTypeAnswer lookId:weakSelf.answerModel.ID titleName:weakSelf.answerModel.question];
            HTStoreBarButtonItem *storeBarButtonItem = [[HTStoreBarButtonItem alloc] initWithTapHandler:^(HTStoreBarButtonItem *item) {
                [HTUserStoreManager switchStoreStateWithModel:model];
                item.selected = [HTUserStoreManager isStoredWithModel:model];
            }];
            storeBarButtonItem.selected = [HTUserStoreManager isStoredWithModel:model];
            
            UIImage *image = [UIImage imageNamed:@"cn2_index_answer_reply"];
            image = [image ht_resetSizeZoomNumber:1.1];
            UIBarButtonItem *solutionBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:image style:UIBarButtonItemStylePlain handler:^(id sender) {
                [HTAnswerKeboardManager beginKeyboardWithAnswerModel:weakSelf.answerModel success:^{
					[weakSelf.tableView ht_startRefreshHeader];
                }];
            }];
            weakSelf.navigationItem.rightBarButtonItems = @[storeBarButtonItem, solutionBarButtonItem];
		}];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"问答详情";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		_tableView.backgroundColor = [UIColor ht_colorString:@"eeeeee"];
		_tableView.separatorColor = _tableView.backgroundColor;
		_tableView.separatorInset = UIEdgeInsetsMake(0, - 15, 0, 0);
		
		__weak typeof(self) weakSelf = self;
        [_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.cellClass([HTAnswerCell class]) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerModel *model) {
				[HTAnswerKeboardManager beginKeyboardWithAnswerModel:model success:^{
					[weakSelf.tableView ht_startRefreshHeader];
				}];
            }];
        }];
		[_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTAnswerSolutionCell class]).headerHeight(7.5) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerSolutionModel *model) {
				[HTAnswerKeboardManager beginKeyboardWithAnswerSolutionModel:model answerReplyModel:nil success:^{
					[weakSelf.tableView ht_startRefreshHeader];
				}];
			}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTAnswerSolutionCell *cell, __kindof NSObject *model) {
				if (!cell.reloadHeightBlock) {
					[cell setReloadHeightBlock:^{
						@try {
							[weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
						} @catch (NSException *exception) {
							
						} @finally {
							
						}
					}];
				}
			}];
		}];
    }
    return _tableView;
}

@end
