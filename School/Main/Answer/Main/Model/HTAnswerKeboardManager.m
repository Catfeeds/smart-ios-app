//
//  HTAnswerKeboardManager.m
//  School
//
//  Created by hublot on 2017/8/30.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerKeboardManager.h"
#import "HTCommunityReplyKeyBoardView.h"
#import <UIScrollView+HTRefresh.h>
#import <NSObject+HTObjectCategory.h>

@implementation HTAnswerKeboardManager

+ (void)beginKeyboardWithAnswerModel:(HTAnswerModel *)answerModel success:(HTAnswerKeyboardSuccess)success {
	NSString *placeholder = [NSString stringWithFormat:@"请输入要回答的内容"];
	[HTCommunityReplyKeyBoardView showReplyKeyBoardViewPlaceHodler:placeholder keyBoardAppearance:UIKeyboardAppearanceDark completeBlock:^(NSString *replyText) {
		HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
		networkModel.autoAlertString = @"发表一个新的回答";
		networkModel.offlineCacheStyle = HTCacheStyleNone;
		networkModel.autoShowError = true;
		[HTRequestManager requestCreateAnswerSolutionWithNetworkModel:networkModel contentString:replyText answerModel:answerModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			[HTAlert title:@"发表回答成功"];
			if (success) {
				success();
			}
		}];
	}];
}

+ (void)beginKeyboardWithAnswerSolutionModel:(HTAnswerSolutionModel *)solutionModel answerReplyModel:(HTAnswerReplyModel *)answerReplyModel success:(HTAnswerKeyboardSuccess)success {
	NSString *placeholder = @"";
	if (!answerReplyModel) {
		placeholder = [NSString stringWithFormat:@"评论 %@ 的回答", HTPlaceholderString(solutionModel.nickname, solutionModel.username)];
	} else {
		placeholder = [NSString stringWithFormat:@"回复 %@ 的评论", HTPlaceholderString(solutionModel.nickname, solutionModel.username)];
	}
	[HTCommunityReplyKeyBoardView showReplyKeyBoardViewPlaceHodler:placeholder keyBoardAppearance:UIKeyboardAppearanceDark completeBlock:^(NSString *replyText) {
		HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
		networkModel.autoAlertString = @"发表一个新的评论";
		networkModel.offlineCacheStyle = HTCacheStyleNone;
		networkModel.autoShowError = true;
		[HTRequestManager requestCreateAnswerReplyWithNetworkModel:networkModel contentString:replyText answerSolutionModel:solutionModel answerReplyModel:answerReplyModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			[HTAlert title:@"发表评论成功"];
			if (success) {
				success();
			}
		}];
	}];
}

+ (void)tryRefreshWithView:(UIView *)view {
	UIViewController *viewController = view.ht_controller;
	SEL selector = @selector(tableView);
	if ([viewController respondsToSelector:selector]) {
		UITableView *tableView = [viewController ht_valueForSelector:selector runtime:false];
		[tableView ht_startRefreshHeader];
	}
}

@end
