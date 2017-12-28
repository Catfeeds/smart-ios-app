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
#import "HTAnswerInputView.h"

@interface HTAnswerDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTAnswerModel *answerModel;

@property (nonatomic, strong) HTAnswerInputView *inputView;

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

- (void)viewWillDisappear:(BOOL)animated{
    [self.inputView.inputTextView resignFirstResponder];
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
				[weakSelf.inputView showInputViewWithPlaceholder:nil sendText:^(NSString *text) {
					[weakSelf sendNewAnswer:text];
				}];
//                [HTAnswerKeboardManager beginKeyboardWithAnswerModel:weakSelf.answerModel success:^{
//                    [weakSelf.tableView ht_startRefreshHeader];
//                }];
            }];
            weakSelf.navigationItem.rightBarButtonItems = @[storeBarButtonItem, solutionBarButtonItem];
		}];
    }];
    [self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"问答详情";
    [self.view addSubview:self.tableView];
	[self.view addSubview:self.inputView];
	
	[self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(self.view);
		make.height.mas_equalTo(56);
	}];
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.inputView.mas_top);
	}];
}

#pragma mark -

//发一个新回答
- (void)sendNewAnswer:(NSString *)text{
    
    HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
    networkModel.autoAlertString = @"发表一个新的回答";
    networkModel.offlineCacheStyle = HTCacheStyleNone;
    networkModel.autoShowError = true;
    [HTRequestManager requestCreateAnswerSolutionWithNetworkModel:networkModel contentString:text answerModel:self.answerModel complete:^(id response, HTError *errorModel) {
        if (errorModel.existError) {
            return;
        }
        [self.tableView ht_startRefreshHeader];
        [HTAlert title:@"发表回答成功"];
    }];
	

}


//发一个新答案回复
- (void)sendNewSolution:(HTAnswerSolutionModel *)solutionModel  answerReplyModel:(HTAnswerReplyModel *)answerReplyModel text:(NSString *)text{
	    HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	    networkModel.autoAlertString = @"发表一个新的评论";
	    networkModel.offlineCacheStyle = HTCacheStyleNone;
	    networkModel.autoShowError = true;
	    [HTRequestManager requestCreateAnswerReplyWithNetworkModel:networkModel contentString:text answerSolutionModel:solutionModel answerReplyModel:answerReplyModel complete:^(id response, HTError *errorModel) {
	        if (errorModel.existError) {
	            return;
	        }
	        [HTAlert title:@"发表评论成功"];
	    }];
}

#pragma mark -

- (HTAnswerInputView *) inputView{
	if (!_inputView) {
		_inputView = [[NSBundle mainBundle] loadNibNamed:@"HTAnswerInputView" owner:nil options:nil].firstObject;
       
        
	}
	return _inputView;
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
//                [HTAnswerKeboardManager beginKeyboardWithAnswerModel:model success:^{
////                    [weakSelf.tableView ht_startRefreshHeader];
////                }];
				
					[weakSelf.inputView showInputViewWithPlaceholder:nil sendText:^(NSString *text) {
						[weakSelf sendNewAnswer:text];
					}];
            }];
        }];
		[_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker.cellClass([HTAnswerSolutionCell class]).headerHeight(7.5) didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof HTAnswerSolutionModel *model) {
//				[HTAnswerKeboardManager beginKeyboardWithAnswerSolutionModel:model answerReplyModel:nil success:^{
////////					[weakSelf.tableView ht_startRefreshHeader];
//				}];
				 NSString * placeholder = [NSString stringWithFormat:@"回复 %@ 的回答", HTPlaceholderString(model.nickname, model.username)];
				[weakSelf.inputView showInputViewWithPlaceholder:placeholder sendText:^(NSString *text) {
					[weakSelf sendNewSolution:model answerReplyModel:nil text:text];
				}];
			}] customCellBlock:^(UITableView *tableView, NSInteger row, __kindof HTAnswerSolutionCell *cell, __kindof NSObject *model) {
			
				
				if (!cell.replycommentBlock) {
					cell.replycommentBlock = ^(HTAnswerSolutionModel *solutionModel, HTAnswerReplyModel *answerReplyModel) {
					NSString *placeholder = [NSString stringWithFormat:@"回复 %@ 的评论", HTPlaceholderString(solutionModel.nickname, solutionModel.username)];
						[weakSelf.inputView showInputViewWithPlaceholder:placeholder sendText:^(NSString *text) {
							[weakSelf sendNewSolution:solutionModel answerReplyModel:answerReplyModel text:text];
						}];
					};
				}
				
			}];
		}];
    }
    return _tableView;
}

@end
