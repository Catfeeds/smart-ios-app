//
//  HTAnswerMainController.m
//  School
//
//  Created by hublot on 2017/8/1.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerMainController.h"
#import "HTAnswerContentController.h"
#import "HTIndexModel.h"
#import "HTAnswerTagController.h"
#import "HTAnswerTagModel.h"
#import "HTAnswerModel.h"
#import "HTAnswerTagManager.h"

@interface HTAnswerMainController ()

@property (nonatomic, strong) NSArray *tagModelArray;

@end

@implementation HTAnswerMainController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(packPageModelArray) name:kHTSelectedTagArrayDidChangeNotifacation object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	if (!self.tagModelArray.count) {
		[self packPageModelArray];
	}
}

- (void)initializeUserInterface {
	
	__weak typeof(self) weakSelf = self;
	self.magicView.sliderHeight = 1 / [UIScreen mainScreen].scale;
	self.magicView.sliderColor = [UIColor ht_colorStyle:HTColorStyleTintColor];
	self.magicView.layoutStyle = VTLayoutStyleDefault;
	
	UIButton *rightTagButton = [[UIButton alloc] init];
	[rightTagButton ht_whenTap:^(UIView *view) {
		HTAnswerTagController *tagController = [[HTAnswerTagController alloc] init];
		[weakSelf.navigationController pushViewController:tagController animated:true];
	}];
	UIImage *image = [UIImage imageNamed:@"cn_answer_append"];
	image = [image ht_resetSizeZoomNumber:0.6];
	[rightTagButton setImage:image forState:UIControlStateNormal];
	[rightTagButton setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 10)];
	[rightTagButton sizeToFit];
	self.magicView.rightNavigatoinItem = rightTagButton;
}

- (void)packPageModelArray {
	
	__weak typeof(self) weakSelf = self;
	[HTAnswerTagManager requestCurrentAnswerTagArrayBlock:^(NSMutableArray *answerTagArray) {
		NSMutableArray *tagModelArray = [answerTagArray mutableCopy];
		
		[answerTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *tagModel, NSUInteger idx, BOOL * _Nonnull stop) {
			if (!tagModel.isEnable) {
				[tagModelArray removeObject:tagModel];
			}
		}];
		
		HTAnswerTagModel *model = [[HTAnswerTagModel alloc] init];
		model.name = @"全部";
		model.isEnable = true;
		[tagModelArray insertObject:model atIndex:0];
		
		_tagModelArray = tagModelArray;
		
		NSMutableArray *pageModelArray = [@[] mutableCopy];
		[tagModelArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *tagModel, NSUInteger index, BOOL * _Nonnull stop) {
			HTPageModel *pageModel = [[HTPageModel alloc] init];
			pageModel.selectedTitle = tagModel.name;
			pageModel.reuseControllerClass = [HTAnswerContentController class];
			[pageModelArray addObject:pageModel];
		}];
		self.pageModelArray = pageModelArray;
		[self setModelArrayBlock:^(NSString *pageIndex, NSString *pageCount, NSString *currentPage, void (^modelArrayStatus)(NSArray<HTDiscoverActivityModel *> *, HTError *)) {
			if (pageIndex.integerValue > weakSelf.tagModelArray.count) {
				return;
			}
			HTAnswerTagModel *tagModel = tagModelArray[pageIndex.integerValue];
			HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
			NSString *answerTagString = tagModel.ID;
			[HTRequestManager requestAnswerListWithNetworkModel:networkModel answerTagString:answerTagString pageSize:pageCount currentPage:currentPage complete:^(id response, HTError *errorModel) {
				if (errorModel.existError) {
					modelArrayStatus(nil, errorModel);
					return;
				}
				NSArray *answerModelArray = [HTAnswerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"data"]];
				modelArrayStatus(answerModelArray, nil);
			}];
		}];
		[self.magicView reloadData];
	}];
	
}

@end
