//
//  HTSearchRequestManager.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchRequestManager.h"

@implementation HTSearchRequestManager

+ (void)searchItemType:(HTSearchType)type keyWord:(NSString *)keyWord pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	keyWord = HTPlaceholderString(keyWord, @"");
	switch (type) {
		case HTSearchTypeSchool: {
			NSDictionary *parameter = @{@"school":keyWord};
			[HTRequestManager requestSearchSchoolOrMajorListWithNetworkModel:networkModel parameter:parameter pageSize:pageSize currentPage:currentPage complete:complete];
			break;
		}
		case HTSearchTypeProfessional: {
			NSDictionary *parameter = @{@"majors":keyWord};
			[HTRequestManager requestSearchSchoolOrMajorListWithNetworkModel:networkModel parameter:parameter pageSize:pageSize currentPage:currentPage complete:complete];
			break;
		}
		case HTSearchTypeAnswer: {
			NSDictionary *parameter = @{@"questionWord":keyWord};
			[HTRequestManager requestSearchAnswerOrActivityOrLibraryWithNetworkModel:networkModel parameter:parameter pageSize:pageSize currentPage:currentPage complete:complete];
			break;
		}
		case HTSearchTypeActivity: {
			NSDictionary *parameter = @{@"activityWord":keyWord};
			[HTRequestManager requestSearchAnswerOrActivityOrLibraryWithNetworkModel:networkModel parameter:parameter pageSize:pageSize currentPage:currentPage complete:complete];
			break;
		}
		case HTSearchTypeLibrary: {
			NSDictionary *parameter = @{@"knowWord":keyWord};
			[HTRequestManager requestSearchAnswerOrActivityOrLibraryWithNetworkModel:networkModel parameter:parameter pageSize:pageSize currentPage:currentPage complete:complete];
			break;
		}
	}
}

@end
