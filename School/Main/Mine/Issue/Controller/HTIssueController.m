//
//  HTIssueController.m
//  School
//
//  Created by hublot on 2017/8/14.
//  Copyright © 2017年 hublot. All rights reserved.
//





#ifndef DEBUG

//-----------------------------------------/ 用户界面 /-----------------------------------------//


#import "HTIssueController.h"
#import <UITableView+HTSeparate.h>
#import <HTPlaceholderTextView.h>
#import <NSAttributedString+HTAttributedString.h>
#import <NSObject+HTTableRowHeight.h>

@interface HTIssueController ()

@property (nonatomic, strong) UIBarButtonItem *issueBarButtonItem;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTPlaceholderTextView *textView;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HTIssueController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"意见反馈";
	[self.view addSubview:self.tableView];
	__weak typeof(self) weakSelf = self;
	UIBarButtonItem *issueBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"提交" style:UIBarButtonItemStylePlain handler:^(id sender) {
		[HTAlert showProgress];
		[HTRequestManager requestSendApplicationIssueWithNetworkModel:nil suggestionMessage:weakSelf.textView.text userContactWay:weakSelf.textField.text complete:^(id response, HTError *errorModel) {
			[HTAlert hideProgress];
			if (errorModel.existError) {
				[HTAlert title:errorModel.errorString];
				return;
			}
			[HTAlert title:@"谢谢"];
			[weakSelf.navigationController popViewControllerAnimated:true];
		}];
	}];
	self.issueBarButtonItem = issueBarButtonItem;
	self.navigationItem.rightBarButtonItem = issueBarButtonItem;
	[self validateIssueBarButtonItemEnable];
}

- (void)validateIssueBarButtonItemEnable {
	self.issueBarButtonItem.enabled = self.textView.hasText;
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableView.allowsSelection = false;
		_tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.03];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.modelArray(@[self.textView]) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof UIView *model) {
				[cell addSubview:model];
				[model ht_setRowHeightNumber:@(model.ht_h) forCellClass:cell.class];
			}];
		}];
		UIView *headerView = [[UIView alloc] init];
		[_tableView ht_updateSection:1 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[sectionMaker.modelArray(@[self.textField]).headerView(headerView).headerHeight(20) customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof UIView *model) {
				[cell addSubview:model];
				[model ht_setRowHeightNumber:@(model.ht_h) forCellClass:cell.class];
			}];
		}];
	}
	return _tableView;
}

- (HTPlaceholderTextView *)textView {
	if (!_textView) {
		_textView = [[HTPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 0, HTSCREENWIDTH - 20, 240)];
		_textView.font = [UIFont systemFontOfSize:15];
		NSMutableAttributedString *placeHolderAttributedString = [[NSMutableAttributedString alloc] initWithString:@"请输入反馈, 我们将为你不断改进"];
		[placeHolderAttributedString addAttributes:@{NSFontAttributeName:_textView.font,
													 NSForegroundColorAttributeName:[UIColor ht_colorStyle:HTColorStylePrimaryTitle]} range:NSMakeRange(0, placeHolderAttributedString.length)];
		[self.textField.attributedPlaceholder ht_EnumerateAttribute:NSForegroundColorAttributeName usingBlock:^(id value, NSRange range, BOOL *stop) {
			[placeHolderAttributedString addAttribute:NSForegroundColorAttributeName value:value range:NSMakeRange(0, placeHolderAttributedString.length)];
			*stop = true;
		}];
		
		__weak typeof(self) weakSelf = self;
		_textView.ht_attributedPlaceholder = placeHolderAttributedString;
		[_textView bk_addObserverForKeyPath:NSStringFromSelector(@selector(ht_currentText)) options:NSKeyValueObservingOptionInitial task:^(id obj, NSDictionary *change) {
			[weakSelf validateIssueBarButtonItemEnable];
		}];
	}
	return _textView;
}

- (UITextField *)textField {
	if (!_textField) {
		_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, HTSCREENWIDTH - 20, 50)];
		_textField.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
		_textField.font = [UIFont systemFontOfSize:15];
		_textField.placeholder = @"请输入你的联系方式(可选)";
	}
	return _textField;
}


@end



#else


//-----------------------------------------/ 开发界面 /-----------------------------------------//




#import "HTIssueController.h"
#import <UITableView+HTSeparate.h>
#import <UIScrollView+HTRefresh.h>
#import <NSObject+HTTableRowHeight.h>
#import <NSString+HTString.h>

@interface HTIssueController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HTIssueController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
	__weak typeof(self) weakSelf = self;
	[self.tableView ht_setRefreshBlock:^(NSString *pageSize, NSString *currentPage) {
		[HTRequestManager requestApplicationIssueListWithNetworkModel:nil complete:^(NSArray *modelArray, HTError *errorModel) {
			if (errorModel.existError) {
				[weakSelf.tableView ht_endRefreshWithModelArrayCount:errorModel.errorType];
				return;
			}
			[weakSelf.tableView ht_endRefreshWithModelArrayCount:modelArray.count];
			[weakSelf.tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
				sectionMaker.modelArray(modelArray);
			}];
		}];
	}];
	[self.tableView ht_startRefreshHeader];
}

- (void)initializeUserInterface {
	self.navigationItem.title = @"用户反馈";
	[self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
		[_tableView ht_updateSection:0 sectionMakerBlock:^(HTTableViewSectionMaker *sectionMaker) {
			[[sectionMaker customCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
				NSString *contactWay = [model objectForKey:@"contactWay"];
				if (!contactWay.length) {
					contactWay = @"匿名";
				}
				NSString *suggestionMessage = [model objectForKey:@"suggestionMessage"];
				
				UILabel *titleNameLabel = [cell viewWithTag:101];
				UILabel *detailNameLabel = [cell viewWithTag:102];
				if (!titleNameLabel) {
					titleNameLabel = [[UILabel alloc] init];
					titleNameLabel.font = [UIFont systemFontOfSize:14];
					titleNameLabel.textColor = [UIColor orangeColor];
					titleNameLabel.tag = 101;
					[cell addSubview:titleNameLabel];
					[titleNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
						make.left.mas_equalTo(cell).offset(15);
						make.top.mas_equalTo(cell).offset(10);
						make.right.mas_equalTo(cell).offset(- 15);
						make.height.mas_equalTo(17);
					}];
				}
				if (!detailNameLabel) {
					detailNameLabel = [[UILabel alloc] init];
					detailNameLabel.font = [UIFont systemFontOfSize:14];
					detailNameLabel.textColor = [UIColor ht_colorStyle:HTColorStylePrimaryTitle];
					detailNameLabel.numberOfLines = 0;
					detailNameLabel.tag = 102;
					[cell addSubview:detailNameLabel];
					[detailNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
						make.top.mas_equalTo(titleNameLabel.mas_bottom).offset(15);
						make.left.mas_equalTo(titleNameLabel);
						make.right.mas_equalTo(titleNameLabel);
					}];
				}
				
				titleNameLabel.text = contactWay;
				detailNameLabel.text = suggestionMessage;
				CGFloat modelHeight = [detailNameLabel.text ht_stringHeightWithWidth:HTSCREENWIDTH - 30 font:detailNameLabel.font textView:nil] + 10 + 15 + 17 + 10;
				[model ht_setRowHeightNumber:@(modelHeight) forCellClass:cell.class];
			}] didSelectedCellBlock:^(UITableView *tableView, NSInteger row, __kindof UITableViewCell *cell, __kindof NSObject *model) {
				
			}];
		}];
	}
	return _tableView;
}


@end

#endif
