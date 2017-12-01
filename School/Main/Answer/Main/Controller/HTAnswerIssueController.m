//
//  HTAnswerIssueController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerIssueController.h"
#import <UITableView+HTSeparate.h>
#import <HTPlaceholderTextView.h>
#import <NSObject+HTTableRowHeight.h>
#import "HTAnswerController.h"
#import "HTManagerController.h"
#import "HTAnswerIssueTagCell.h"
#import "HTAnswerTagModel.h"
#import "HTAnswerIssueTagModel.h"
#import "HTAnswerTagManager.h"
#import "HTUserManager.h"

@interface HTAnswerIssueController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *titleNameTextField;

@property (nonatomic, strong) HTPlaceholderTextView *detailNameTextView;

@property (nonatomic, strong) UIBarButtonItem *issueBarButtonItem;

@property (nonatomic, strong) HTAnswerIssueTagModel *tagSelectedModel;

@end

@implementation HTAnswerIssueController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[HTAnswerTagManager requestCurrentAnswerTagArrayBlock:^(NSMutableArray *answerTagArray) {
		HTAnswerIssueTagModel *tagSelectedModel = [[HTAnswerIssueTagModel alloc] init];
		tagSelectedModel.tagModelArray = answerTagArray;
		self.tagSelectedModel = tagSelectedModel;
		[self.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.modelArray(@[weakSelf.tagSelectedModel]);
		}];
	}];
}

- (void)initializeUserInterface {
    self.navigationItem.title = @"发表问答";
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *issueBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发表" style:UIBarButtonItemStylePlain handler:^(id sender) {
		HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
		networkModel.autoShowError = true;
		networkModel.autoAlertString = @"发表问答中";
		networkModel.offlineCacheStyle = HTCacheStyleNone;
		NSMutableArray *selectedTagIdArray = [@[] mutableCopy];
		[weakSelf.tagSelectedModel.selectedIndexArray enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger index, BOOL * _Nonnull stop) {
			NSString *selctedIdString = weakSelf.tagSelectedModel.tagModelArray[number.integerValue].ID;
			[selectedTagIdArray addObject:selctedIdString];
		}];
		[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
			[HTRequestManager requestCreateAnswerWithNetworkModel:networkModel tagIdArray:selectedTagIdArray answerTitle:weakSelf.titleNameTextField.text answerContent:weakSelf.detailNameTextView.text complete:^(id response, HTError *errorModel) {
				if (errorModel.errorType) {
					return;
				}
				[weakSelf.navigationController popViewControllerAnimated:true];
				HTAnswerController *answerController = [HTManagerController defaultManagerController].answerController;
				[answerController refreshAnswerControllerHeader];
			}];
		}];
    }];
    self.issueBarButtonItem = issueBarButtonItem;
    self.navigationItem.rightBarButtonItem = issueBarButtonItem;
    [self validateIssueBarButtonItem];
}

- (void)validateIssueBarButtonItem {
    self.issueBarButtonItem.enabled = self.titleNameTextField.hasText && self.detailNameTextView.hasText;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.allowsSelection = false;
        NSArray *modelArray = @[self.titleNameTextField, self.detailNameTextView];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			sectionMaker.cellClass([HTAnswerIssueTagCell class]);
		}];
        [_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
            [sectionMaker.modelArray(modelArray) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof UIView *model) {
                [cell addSubview:model];
                if (row > 0) {
                    cell.separatorInset = UIEdgeInsetsMake(0, HTSCREENWIDTH, 0, 0);
                }
                [model ht_setRowHeightNumber:@(model.ht_h) forCellClass:cell.class];
            }];
        }];
    }
    return _tableView;
}

- (UITextField *)titleNameTextField {
    if (!_titleNameTextField) {
        _titleNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.view.ht_w - 30, 50)];
        _titleNameTextField.font = [UIFont systemFontOfSize:14];
        _titleNameTextField.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" 请输入问题标题" attributes:@{NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStyleSecondaryTitle], NSFontAttributeName:_titleNameTextField.font}];
        _titleNameTextField.attributedPlaceholder = attributedString;
        
        __weak typeof(self) weakSelf = self;
        [_titleNameTextField bk_addEventHandler:^(id sender) {
            [weakSelf validateIssueBarButtonItem];
        } forControlEvents:UIControlEventEditingChanged];
    }
    return _titleNameTextField;
}

- (HTPlaceholderTextView *)detailNameTextView {
    if (!_detailNameTextView) {
        _detailNameTextView = [[HTPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 0, self.view.ht_w - 20, MIN(200, self.view.ht_h - 64 - self.titleNameTextField.ht_h))];
        _detailNameTextView.font = [UIFont systemFontOfSize:14];
        _detailNameTextView.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
        _detailNameTextView.ht_placeholder = @" 请输入问题详情";
        
        __weak typeof(self) weakSelf = self;
        [_detailNameTextView bk_addObserverForKeyPath:NSStringFromSelector(@selector(ht_currentText)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
            [weakSelf validateIssueBarButtonItem];
        }];
    }
    return _detailNameTextView;
}

@end
