//
//  HTRequestManager.m
//  GMat
//
//  Created by hublot on 2017/5/3.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "HTRequestManager.h"
#import "HTUserManager.h"
#import "HTLoginManager.h"
#import <HTValidateManager.h>
#import <HTNetworkManager+HTNetworkCache.h>
#import <HTEncodeDecodeManager.h>
#import "NSObject+HTObjectCategory.h"
#import <BmobSDK/Bmob.h>

static NSString *kHTApplicationIdString = @"1271275068";

// https://github.com/sy-obelisk/smartapply/blob/master/modules/cn/controllers/AppApiController.php

@implementation HTRequestManager

+ (void)requestBroadcastComplete:(HTUserTaskCompleteBlock)complete {
	NSDate *date = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	NSString *dateString = [dateFormatter stringFromDate:date];
	NSString *url = @"http://www.gmatonline.cn/index.php?web/webapi/AppAd";
	NSDictionary *parameter = @{@"date":dateString};
	
	NSDictionary *apiResponse = [HTNetworkManager cacheResponse:nil url:url parameter:parameter cacheStyle:HTCacheStyleAllUser];
	if (apiResponse && [apiResponse valueForKey:kHTBroadCastImage64Key]) {
		if (complete) {
			complete(apiResponse, nil);
		}
	} else {
		HTError *error = [[HTError alloc] init];
		error.errorType = HTErrorTypeUnknown;
		complete(nil, error);
		HTNetworkModel *apiNetworkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleNone];
		[HTNetworkManager requestModel:apiNetworkModel method:HTNetworkRequestMethodGet url:url parameter:parameter complete:^(NSDictionary *response, HTError *errorModel) {
			if (errorModel.existError) {
				return;
			}
			NSDictionary *responseDictionary = [response mutableCopy];
			NSString *imageUrl = [response valueForKey:@"image"];
			imageUrl = [NSString stringWithFormat:@"%@%@", @"http://www.gmatonline.cn/", imageUrl];
			HTNetworkModel *imageNetworkModel = [[HTNetworkModel alloc] init];
			imageNetworkModel.autoAlertString = nil;
			imageNetworkModel.autoShowError = false;
			imageNetworkModel.offlineCacheStyle = HTCacheStyleNone;
			[HTNetworkManager requestModel:imageNetworkModel method:HTNetworkRequestMethodDownload url:imageUrl parameter:nil complete:^(NSData *response, HTError *errorModel) {
				if (errorModel.existError || ![response isKindOfClass:[NSData class]]) {
					return;
				}
				NSString *image64 = [HTEncodeDecodeManager ht_encodeWithBase64:response];
				if (image64.length) {
					[responseDictionary setValue:image64 forKey:kHTBroadCastImage64Key];
					[HTNetworkManager cacheResponse:responseDictionary url:url parameter:parameter cacheStyle:HTCacheStyleAllUser];
				}
			}];
		}];
	}
}

+ (void)deleteGossipWithNetworkModel:(HTNetworkModel *)networkModel gossipIdString:(NSString *)gossipIdString complete:(HTUserTaskCompleteBlock)complete{
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://bbs.viplgw.cn/cn/app-api/delete-gossip" parameter:@{@"gossipId":HTPlaceholderString(gossipIdString, @"0")} complete:complete];
}

+ (void)requestGossipListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/gossip-list" parameter:@{@"page":HTPlaceholderString(currentPage, @"1"), @"pageSize":HTPlaceholderString(pageSize, @"10"), @"belong":@"3"} complete:complete];
}

+ (void)requestGossipDetailWithNetworkModel:(HTNetworkModel *)networkModel gossipIdString:(NSString *)gossipIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/gossip-details" parameter:@{@"gossipId":HTPlaceholderString(gossipIdString, @"0")} complete:complete];
}

+ (void)requestGossipReplyGossipOwnerWithNetworkModel:(HTNetworkModel *)networkModel replyContent:(NSString *)replyContent communityLayoutModel:(HTCommunityLayoutModel *)communityLayoutModel complete:(HTUserTaskCompleteBlock)complete {
	[self requestGossipReplyGossipLoopReplyWithNetworkModel:networkModel replyContent:replyContent communityLayoutModel:communityLayoutModel beingReplyModel:nil complete:complete];
}

+ (void)requestGossipReplyGossipLoopReplyWithNetworkModel:(HTNetworkModel *)networkModel replyContent:(NSString *)replyContent communityLayoutModel:(HTCommunityLayoutModel *)communityLayoutModel beingReplyModel:(HTCommunityReplyLayoutModel *)beingReplyModel complete:(HTUserTaskCompleteBlock)complete {
	NSString *typeString = @"1";
	if (beingReplyModel) {
		typeString = @"2";
	}
	[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
		[HTNetworkManager requestModel:networkModel
								method:HTNetworkRequestMethodPost
								   url:@"http://bbs.viplgw.cn/cn/app-api/reply"
							 parameter:@{@"content":HTPlaceholderString(replyContent, @""),
										 @"type":typeString,
										 @"id":HTPlaceholderString(communityLayoutModel.originModel.ID, @"0"),
										 @"gossipUser":HTPlaceholderString(communityLayoutModel.originModel.uid, @"0"),
										 @"uName":HTPlaceholderString([HTUserManager currentUser].nickname, @""),
										 @"userImage":HTPlaceholderString([HTUserManager currentUser].image, @""),
										 @"replyUser":HTPlaceholderString(beingReplyModel.originReplyModel.uid, @"0"),
										 @"replyUserName":HTPlaceholderString(beingReplyModel.originReplyModel.uName, @""),
										 @"belong":@"3"} complete:complete];
	}];
}

+ (void)requestGossipGoodGossipWithNetworkModel:(HTNetworkModel *)networkModel gossipIdString:(NSString *)gossipIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
		[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/add-like" parameter:@{@"gossipId":HTPlaceholderString(gossipIdString, @"0"), @"belong":@"3"} complete:complete];
	}];
}

+ (void)requestGossipUploadGossipImageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
		[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodUpload url:@"http://bbs.viplgw.cn/cn/app-api/app-image" parameter:nil complete:complete];
	}];
}

+ (void)requestGossipSendGossipWithNetworkModel:(HTNetworkModel *)networkModel gossipTitleString:(NSString *)gossipTitleString gossipDetailString:(NSString *)gossipDetailString imageSourceArray:(NSArray <NSString *> *)imageSourceArray complete:(HTUserTaskCompleteBlock)complete {
	if (!imageSourceArray) {
		imageSourceArray = @[];
	}
	[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
		[HTNetworkManager requestModel:networkModel
								method:HTNetworkRequestMethodPost
								   url:@"http://bbs.viplgw.cn/cn/app-api/add-gossip"
							 parameter:@{@"title":HTPlaceholderString(gossipTitleString, @""),
										 @"content":HTPlaceholderString(gossipDetailString, @""),
										 @"image":imageSourceArray,
										 @"video":@[],
										 @"audio":@[],
										 @"icon":HTPlaceholderString([HTUserManager currentUser].image, @""),
										 @"publisher":HTPlaceholderString([HTUserManager currentUser].nickname, @""),
										 @"belong":@"3"} complete:complete];
	}];
}

+ (void)requestGossipMessageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://bbs.viplgw.cn/cn/app-api/reply-list" parameter:@{@"uid":HTPlaceholderString([HTUserManager currentUser].uid, @"0"), @"belong":@"3"} complete:complete];
}



+ (void)requestIndexListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/home-page" parameter:nil complete:complete];
}

+ (void)requestSchoolFilterParameterWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
//	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://schools.smartapply.cn/cn/app-api/university-class" parameter:nil complete:complete];
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://schools.smartapply.cn/cn/app-api/university-class" parameter:nil complete:complete];
	
}

+ (void)requestSchoolMatriculateCountryListAndMajorListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://schools.smartapply.cn/cn/api/major-country?" parameter:nil complete:complete];
}

+ (void)requestSendSchoolMatriculateWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/school-storage" parameter:parameter complete:complete];
}

+ (void)requestSchoolSingleMatriculateResultWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/probability-storage" parameter:parameter complete:complete];
}

+ (void)requestSchoolDetailWithNetworkModel:(HTNetworkModel *)networkModel schoolId:(NSString *)schoolId complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://schools.smartapply.cn/cn/app-api/school-detail" parameter:@{@"schoolId":HTPlaceholderString(schoolId, @"0")} complete:complete];
}

+ (void)requestProfessionalWithNetworkModel:(HTNetworkModel *)networkModel professionalId:(NSString *)professionalId complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://schools.smartapply.cn/cn/app-api/major-detail" parameter:@{@"id":HTPlaceholderString(professionalId, @"0")} complete:complete];
}

+ (void)requestHotSchoolListWithNetworkModel:(HTNetworkModel *)networkModel currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodGet
							   url:@"http://schools.smartapply.cn/cn/app-api/hot-school"
						 parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestRankClassListWithNetworkModel:(HTNetworkModel *)networkModel currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodGet
							   url:@"http://www.smartapply.cn/cn/app-api/university-class"
						 parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestRankSchoolListWithNetworkModel:(HTNetworkModel *)networkModel classIdString:(NSString *)classIdString yearIdString:(NSString *)yearIdString currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete {
	
	NSURLSessionTask *task = [networkModel ht_valueForSelector:@selector(task) runtime:false];
	if(task)[task cancel]; //取消上次请求
	
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/university-rank"
						 parameter:@{@"classId":HTPlaceholderString(classIdString, @""),
									 @"yearId":HTPlaceholderString(yearIdString, @""),
									 @"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestSchoolFilterListWithNetworkModel:(HTNetworkModel *)networkModel countryIdString:(NSString *)countryIdString rankIdString:(NSString *)rankIdString professionalIdString:(NSString *)professionalIdString currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://schools.smartapply.cn/cn/app-api/class-school"
						 // 国家默认美国  155
						 parameter:@{@"country":HTPlaceholderString(countryIdString, @"155"),
									 @"rank":HTPlaceholderString(rankIdString, @""),
									 @"major":HTPlaceholderString(professionalIdString, @""),
									 @"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestActivityDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/activity-detail"
						 parameter:@{@"id":HTPlaceholderString(contentIdString, @"")} complete:complete];
}

+ (void)requestFilterSchoolListWithNetworkModel:(HTNetworkModel *)networkModel countryIdString:(NSString *)countryIdString rangkIdString:(NSString *)rangkIdString professionalIdString:(NSString *)professionalIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://schools.smartapply.cn/cn/app-api/class-school"
						 parameter:@{@"country":HTPlaceholderString(countryIdString, @""),
									 @"rank":HTPlaceholderString(rangkIdString, @""),
									 @"major":HTPlaceholderString(professionalIdString, @"")} complete:complete];
}

+ (void)requestLibrarayListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/know" parameter:nil complete:complete];
}

//sortType 0-综合 1-销量 2-价格 3-最新
+ (void)requestStudyAbroadWithNetworkModel:(HTNetworkModel *)networkModel page:(NSString *)page countryID:(NSString *)countryID categoryID:(NSString *)categoryID sortType:(NSInteger)type complete:(HTUserTaskCompleteBlock)complete{
	
	NSURLSessionTask *task = [networkModel ht_valueForSelector:@selector(task) runtime:false];
	if(task)[task cancel]; //取消上次请求
	
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	NSString *key = @"";
	if (type == 1)       key = @"buyNum";
	else if (type == 2)  key = @"price";
	else if (type  == 3) key = @"time";
	
	if (StringNotEmpty(key)) {
		[dic setObject:@"1" forKey:key];
	}
	if (StringNotEmpty(countryID)) [dic setObject:countryID forKey:@"country"];
	if (StringNotEmpty(categoryID)) [dic setObject:categoryID forKey:@"category"];
	[dic setObject:page forKey:@"page"];
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/goods-page" parameter:dic complete:complete];
}

+ (void)requestExampleItemWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/case" parameter:nil complete:complete];
}

+ (void)requestExampleListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	NSMutableDictionary *parameterDictionary = [@{@"page":HTPlaceholderString(currentPage, @"1"),
												 @"pageSize":HTPlaceholderString(pageSize, @"10")} mutableCopy];
	if (catIdString.length) {
		[parameterDictionary setValue:catIdString forKey:@"catId"];
	}
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/page-case"
						 parameter:parameterDictionary complete:complete];
}

+ (void)requestAnswerTagListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/question-tag" parameter:nil complete:complete];
}

+ (void)requestAnswerListWithNetworkModel:(HTNetworkModel *)networkModel answerTagString:(NSString *)answerTagString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/new-question"
						 parameter:@{@"tag":HTPlaceholderString(answerTagString, @""),
									 @"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestCreateAnswerWithNetworkModel:(HTNetworkModel *)networkModel tagIdArray:(NSArray *)tagIdArray answerTitle:(NSString *)answerTitle answerContent:(NSString *)answerContent complete:(HTUserTaskCompleteBlock)complete {
	NSString *answerIdString = [tagIdArray componentsJoinedByString:@","];
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/sub-question"
						 parameter:@{@"tag":HTPlaceholderString(answerIdString, @""),
									 @"question":HTPlaceholderString(answerTitle, @""),
									 @"contents":HTPlaceholderString(answerContent, @"")} complete:complete];
}

+ (void)requestCreateAnswerSolutionWithNetworkModel:(HTNetworkModel *)networkModel contentString:(NSString *)contentString answerModel:(HTAnswerModel *)anwerModel complete:(HTUserTaskCompleteBlock)complete {
	NSString *replyType = @"2";
	NSString *replyUid = @"";
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/sub-answer"
						 parameter:@{@"questionId":anwerModel.ID, @"contents":HTPlaceholderString(contentString, @""), @"replyUser":@"", @"type":replyType, @"replyUid":replyUid} complete:complete];
}

+ (void)requestCreateAnswerReplyWithNetworkModel:(HTNetworkModel *)networkModel contentString:(NSString *)contentString answerSolutionModel:(HTAnswerSolutionModel *)solutionModel 	answerReplyModel:(HTAnswerReplyModel *)answerReplyModel complete:(HTUserTaskCompleteBlock)complete {
	NSString *replyType = @"3";
	NSString *replyUser = HTPlaceholderString(answerReplyModel.nickname, answerReplyModel.username);
	replyUser = HTPlaceholderString(replyUser, @"");
	NSString *replyUid = HTPlaceholderString(answerReplyModel.userid, @"");
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/sub-answer"
						 parameter:@{@"questionId":solutionModel.ID, @"contents":HTPlaceholderString(contentString, @""), @"replyUser":replyUser, @"type":replyType, @"replyUid":replyUid} complete:complete];
}


+ (void)requestWorkListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/background-lift" parameter:nil complete:complete];
}

+ (void)requestActivityBannerWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/activity" parameter:nil complete:complete];
}

+ (void)requestOpenCourseListWithNetworkModel:(HTNetworkModel *)networkModel currentPage:(NSString *)currentPage pageSize:(NSString *)pageSize complete:(HTUserTaskCompleteBlock)complete{

	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://open.viplgw.cn/cn/api/study-open-list"
						 parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"20")} complete:complete];
}

+ (void)requestOpenCourseDetailWithNetworkModel:(HTNetworkModel *)networkModel courseID:(NSString *)courseID  complete:(HTUserTaskCompleteBlock)complete{
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://open.viplgw.cn/cn/api/app-open-details"
						 parameter:@{@"id":HTPlaceholderString(courseID, @"")} complete:complete];
}

+ (void)requestSignupOpenCourseWithNetworkModel:(HTNetworkModel *)networkModel courseID:(NSString *)courseID usernameString:(NSString *)usernameString phoneNumberString:(NSString *)phoneNumberString courseTitleString:(NSString *)courseTitleString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/api/add-content" parameter:@{@"catId":@"236", @"name":HTPlaceholderString(usernameString, @""), @"extend":@[HTPlaceholderString(courseID, @"0"), HTPlaceholderString(phoneNumberString, @""), HTPlaceholderString(courseTitleString, @""), @"iOS 留学"]} complete:complete];
}


+ (void)requestActivityListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/activity"
						 parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestLibrarayDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/know-detail"
						 parameter:@{@"contentId":HTPlaceholderString(contentIdString, @""),
									 @"catId":HTPlaceholderString(catIdString, @"")} complete:complete];
}

+ (void)requestWorkDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/background-detail"
						 parameter:@{@"id":HTPlaceholderString(contentIdString, @""),
									 @"catId":HTPlaceholderString(catIdString, @"")} complete:complete];
}

+ (void)requestExampleDetailWithNetworkModel:(HTNetworkModel *)networkModel contentIdString:(NSString *)contentIdString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/three"
						 parameter:@{@"contentid":HTPlaceholderString(contentIdString, @""),
									 @"catid":HTPlaceholderString(catIdString, @"")} complete:complete];
}

+ (void)requestStoreDetailWithNetworkModel:(HTNetworkModel *)networkModel storeIdString:(NSString *)storeIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/goods-detail"
						 parameter:@{@"id":HTPlaceholderString(storeIdString, @"")} complete:complete];
}

+ (void)requestOrganizationListWithNetworkModel:(HTNetworkModel *)networkModel organizationListType:(HTOrganizationListType)organizationListType pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	NSString *sortString = [NSString stringWithFormat:@"%ld", organizationListType];
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/mechanism"
						 parameter:@{@"sort":HTPlaceholderString(sortString, @""),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10"),
                                     @"page":HTPlaceholderString(currentPage, @"1")} complete:complete];
}

+ (void)requestOrganizationDetailWithNetworkModel:(HTNetworkModel *)networkModel organizationId:(NSString *)organizationId complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/mechanism-detail"
						 parameter:@{@"id":HTPlaceholderString(organizationId, @"")} complete:complete];
}

+ (void)requestAnswerDetailWithNetworkModel:(HTNetworkModel *)networkModel answerIdString:(NSString *)answerIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/question-detail" parameter:@{@"id":HTPlaceholderString(answerIdString, @"")} complete:complete];
}


















+ (void)requestResetPasswordWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString resetPassword:(NSString *)resetPassword messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete {
	NSString *forgetType = @"1";
	if ([HTValidateManager ht_validateMobile:phoneOrEmailString]) {
		forgetType = @"1";
	} else if ([HTValidateManager ht_validateEmail:phoneOrEmailString]) {
		forgetType = @"2";
	}
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/find-pass"
						 parameter:@{@"type":forgetType,
									 @"registerStr":HTPlaceholderString(phoneOrEmailString, @"0"),
									 @"pass":HTPlaceholderString(resetPassword, @""),
									 @"code":HTPlaceholderString(messageCode, @"")}
						  complete:complete];
}

+ (void)requestMessageCodeSurePersonWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://login.gmatonline.cn/cn/app-api/phone-request" parameter:nil complete:complete];
}

+ (void)requestRegisterOrForgetPasswordOrUpdataUserMessageCodeWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString requestMessageCodeStyle:(HTLoginTextFieldGroupType)requestMessageCodeStyle complete:(HTUserTaskCompleteBlock)complete {
	NSString *requestUrl;
	NSMutableDictionary *requestDictionary = [@{@"type":[NSString stringWithFormat:@"%ld", requestMessageCodeStyle + 1]} mutableCopy];
	if ([HTValidateManager ht_validateMobile:phoneOrEmailString]) {
		requestUrl = @"http://login.gmatonline.cn/cn/app-api/phone-code";
		[requestDictionary setValue:HTPlaceholderString(phoneOrEmailString, @"") forKey:@"phoneNum"];
	} else if ([HTValidateManager ht_validateEmail:phoneOrEmailString]) {
		requestUrl = @"http://login.gmatonline.cn/cn/app-api/send-mail";
		[requestDictionary setValue:HTPlaceholderString(phoneOrEmailString, @"") forKey:@"email"];
	}
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:requestUrl parameter:requestDictionary complete:complete];
}

+ (void)requestAppStoreMaxVersionWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	NSString *applicationIdString = kHTApplicationIdString;
	NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
	NSString *clearCacheKey = @"t";
	NSString *clearCacheValue = [NSString stringWithFormat:@"%.0lf", timeInterval];
	NSString *applicationVersionUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup/cn?id=%@&%@=%@", applicationIdString, clearCacheKey, clearCacheValue];
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:applicationVersionUrlString parameter:nil complete:complete];
}

+ (void)requestOpenAppStore {
	NSString *applicationIdString = kHTApplicationIdString;
	NSString *applicationDetailURLString = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/lei-gegmat/id%@?l=zh&ls=1&mt=8", applicationIdString];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:applicationDetailURLString]];
}

+ (void)requestRegisterWithNetworkModel:(HTNetworkModel *)networkModel phoneOrEmailString:(NSString *)phoneOrEmailString registerPassword:(NSString *)registerPassword messageCode:(NSString *)messageCode usernameString:(NSString *)usernameString complete:(HTUserTaskCompleteBlock)complete {
	NSString *registerTypeString = @"1";
	if ([HTValidateManager ht_validateMobile:phoneOrEmailString]) {
		registerTypeString = @"1";
	} else if ([HTValidateManager ht_validateEmail:phoneOrEmailString]) {
		registerTypeString = @"2";
	}
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/register"
						 parameter:@{@"type":registerTypeString,
									 @"registerStr":HTPlaceholderString(phoneOrEmailString, @"0"),
									 @"pass":HTPlaceholderString(registerPassword, @""),
									 @"code":HTPlaceholderString(messageCode, @""),
									 @"userName":HTPlaceholderString(usernameString, @""),
									 @"source":@"3",
									 @"belong":@"1"}
						  complete:complete];
}

+ (void)requestNormalLoginWithNetworkModel:(HTNetworkModel *)networkModel usernameString:(NSString *)usernameString passwordString:(NSString *)passwordString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/check-login"
						 parameter:@{@"userName":HTPlaceholderString(usernameString, @""),
									 @"userPass":HTPlaceholderString(passwordString, @"")} complete:complete];
}

+ (void)requestThirdLoginWithNetworkModel:(HTNetworkModel *)networkModel openIdString:(NSString *)openIdString nicknameString:(NSString *)nicknameString thirdIconSource:(NSString *)thirdIconSource complete:(HTUserTaskCompleteBlock)complete {
//	[HTNetworkManager requestModel:networkModel
//							method:HTNetworkRequestMethodPost
//							   url:GmatApi(@"/qqLoginForAppTest")
//						 parameter:@{@"openid":HTPlaceholderString(openIdString, @"0"),
//									 @"nickname":HTPlaceholderString(nicknameString, @""),
//									 @"figureurl_qq_2":HTPlaceholderString(thirdIconSource, @""),
//									 @"source":@"1"} complete:complete];
}

+ (void)requestResetLoginSessionWithNetworkModel:(HTNetworkModel *)networkModel requestParameterDictionary:(NSDictionary *)requestParameterDictionary responseParameterDictionary:(NSDictionary *)responseParameterDictionary complete:(HTUserTaskCompleteBlock)complete {
	NSArray *sessionUrlArray = @[@"http://www.toeflonline.cn/cn/app-api/unify-login",
								 @"http://www.smartapply.cn/cn/app-api/unify-login",
								 @"http://www.gmatonline.cn/index.php?web/appapi/unifyLogin",
								 @"http://bbs.viplgw.cn/cn/app-api/unify-login"];
	NSString *uidString = HTPlaceholderString(responseParameterDictionary[@"uid"], @"");
	NSString *nicknameString = HTPlaceholderString(responseParameterDictionary[@"nickname"], @"");
	NSString *usernameString = HTPlaceholderString(responseParameterDictionary[@"username"], @"");
	NSString *passwordString = HTPlaceholderString(responseParameterDictionary[@"password"], @"123456");
	NSString *emailString = HTPlaceholderString(responseParameterDictionary[@"email"], @"");
	NSString *phoneString = HTPlaceholderString(responseParameterDictionary[@"phone"], @"");
	
	NSDictionary *parameter = @{@"uid":uidString, @"nickname":nicknameString, @"username":usernameString, @"password":passwordString, @"email":emailString, @"phone":phoneString};
	
	__block HTUserTaskCompleteBlock resetComplete = complete;
	
	__block NSInteger receiveCount = 0;
	[sessionUrlArray enumerateObjectsUsingBlock:^(NSString *url, NSUInteger idx, BOOL * _Nonnull stop) {
		[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:url parameter:parameter complete:^(id response, HTError *errorModel) {
			if (errorModel.existError && errorModel.errorType != HTErrorTypeUnknown) {
				if (resetComplete) {
					errorModel.errorType = HTErrorTypeUnknown;
					errorModel.errorString = [NSString stringWithFormat:@"重置 session %@ 失败", url];
					resetComplete(nil, errorModel);
					resetComplete = nil;
				}
				return;
			}
			receiveCount ++;
			if (receiveCount == sessionUrlArray.count) {
				if (resetComplete) {
					resetComplete(response, nil);
				}
			}
		}];
	}];
}

+ (void)requestUserModelWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodGet url:@"http://www.smartapply.cn/cn/app-api/personal-data" parameter:nil complete:complete];
}

+ (void)requestUploadUserHeadImageWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodUpload url:@"http://www.smartapply.cn/cn/app-api/app-image" parameter:nil complete:complete];
}


+ (void)requestUpdateUserNicknameWithNetworkModel:(HTNetworkModel *)networkModel changeNickname:(NSString *)changeNickname complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://login.gmatonline.cn/cn/app-api/change-nickname" parameter:@{@"nickname":HTPlaceholderString(changeNickname, @"")} complete:complete];
}

+ (void)requestUpdateUserPhoneWithNetworkModel:(HTNetworkModel *)networkModel changePhone:(NSString *)changePhone messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/update-user"
						 parameter:@{@"uid":HTPlaceholderString([HTUserManager currentUser].uid, @"0"),
									 @"phone":HTPlaceholderString(changePhone, @""),
									 @"code":messageCode} complete:complete];
}

+ (void)requestUpdateUserEmailWithNetworkModel:(HTNetworkModel *)networkModel changeEmail:(NSString *)changeEmail messageCode:(NSString *)messageCode complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/update-user"
						 parameter:@{@"uid":HTPlaceholderString([HTUserManager currentUser].uid, @"0"),
									 @"email":HTPlaceholderString(changeEmail, @""),
									 @"code":messageCode} complete:complete];
}

+ (void)requestUpdateUserPasswordWithNetworkModel:(HTNetworkModel *)networkModel originPassword:(NSString *)originPassword changePassword:(NSString *)changePassword complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://login.gmatonline.cn/cn/app-api/update-user"
						 parameter:@{@"uid":HTPlaceholderString([HTUserManager currentUser].uid, @"0"),
									 @"oldPass":HTPlaceholderString(originPassword, @""),
									 @"newPass":HTPlaceholderString(changePassword, @"")} complete:complete];
}


+ (void)requestSendApplicationIssueWithNetworkModel:(HTNetworkModel *)networkModel suggestionMessage:(NSString *)suggestionMessage userContactWay:(NSString *)userContactWay complete:(HTUserTaskCompleteBlock)complete {
	BmobObject *suggestion = [BmobObject objectWithClassName:@"Suggestion"];
	[suggestion setObject:userContactWay forKey:@"contactWay"];
	[suggestion setObject:suggestionMessage forKey:@"suggestionMessage"];
	[suggestion saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
		if (complete) {
			if (isSuccessful) {
				complete(@{}, nil);
			} else {
				HTError *error = [[HTError alloc] init];
				error.errorType = HTErrorTypeNetwork;
				complete(nil, error);
			}
		}
	}];
}

+ (void)requestApplicationIssueListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
	BmobQuery *suggestionQuery = [BmobQuery queryWithClassName:@"Suggestion"];
	[suggestionQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
		if (complete) {
			if (!error) {
				complete(array, nil);
			} else {
				HTError *error = [[HTError alloc] init];
				error.errorType = HTErrorTypeNetwork;
				complete(nil, error);
			}
		}
	}];
}

+ (void)requestBackgroundResultWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://www.smartapply.cn/cn/app-api/background-result" parameter:parameter complete:complete];
}

+ (void)requestSearchSchoolOrMajorListWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	NSMutableDictionary *dictionary = [@{@"page":HTPlaceholderString(currentPage, @"1"),
										 @"pageSize":HTPlaceholderString(pageSize, @"10")} mutableCopy];
	[dictionary setValuesForKeysWithDictionary:parameter ? parameter : @{}];
	
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://schools.smartapply.cn/cn/app-api/app-select"
						 parameter:dictionary complete:complete];
}

+ (void)requestSearchAnswerOrActivityOrLibraryWithNetworkModel:(HTNetworkModel *)networkModel parameter:(NSDictionary *)parameter pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	NSMutableDictionary *dictionary = [@{@"page":HTPlaceholderString(currentPage, @"1"),
										 @"pageSize":HTPlaceholderString(pageSize, @"10")} mutableCopy];
	[dictionary setValuesForKeysWithDictionary:parameter ? parameter : @{}];
	
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/select-data"
						 parameter:dictionary complete:complete];
}

+ (void)requestAdvisorCateListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/mall-consultant"
                         parameter:nil complete:complete];
}


+ (void)requestAdvisorListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/adviser-class"
                         parameter:@{@"country":HTPlaceholderString(catIdString, @"0"),
                                     @"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestAdvisorDetailWithNetworkModel:(HTNetworkModel *)networkModel advisorIdString:(NSString *)advisorIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/adviser-detail"
						 parameter:@{@"contentid":HTPlaceholderString(advisorIdString, @"")} complete:complete];
}

+ (void)requestUserSolutionListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/answer-questions"
                         parameter:@{@"uid":HTPlaceholderString(uidString, @""),
                                     @"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestUserAnswerListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/user-question"
                         parameter:@{@"uid":HTPlaceholderString(uidString, @""),
                                     @"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}


+ (void)requestUserFansListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/user-fans"
                         parameter:@{@"uid":HTPlaceholderString(uidString, @""),
                                     @"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestUserAttentionListWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/user-follow"
                         parameter:@{@"uid":HTPlaceholderString(uidString, @""),
                                     @"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestAttentionUserWithNetworkModel:(HTNetworkModel *)networkModel toUidString:(NSString *)toUidString complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/follow-user"
                         parameter:@{@"followUser":HTPlaceholderString(toUidString, @"")} complete:complete];
}

+ (void)requestCancelAttentionUserWithNetworkModel:(HTNetworkModel *)networkModel toUidString:(NSString *)toUidString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/cancel-follow"
						 parameter:@{@"followUser":HTPlaceholderString(toUidString, @"")} complete:complete];
}

+ (void)requestUserInfomationWithNetworkModel:(HTNetworkModel *)networkModel uidString:(NSString *)uidString complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/user-data"
                         parameter:@{@"uid":HTPlaceholderString(uidString, @"")} complete:complete];
}

+ (void)requestMatriculateRecordWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/user-evaluation"
                         parameter:nil complete:complete];
}


+ (void)requestBookListWithNetworkModel:(HTNetworkModel *)networkModel pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/document"
						 parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
									 @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}

+ (void)requestAnswerSolutionLikeWithNetworkModel:(HTNetworkModel *)networkModel solutionIdString:(NSString *)solutionIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/spot-fabulous"
						 parameter:@{@"contentId":HTPlaceholderString(solutionIdString, @"")} complete:complete];
}

+ (void)requestAnswerSolutionCancelLikeWithNetworkModel:(HTNetworkModel *)networkModel solutionIdString:(NSString *)solutionIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/cancel-fabulous"
						 parameter:@{@"contentId":HTPlaceholderString(solutionIdString, @"")} complete:complete];
}

+ (void)requestSchoolMatriculateAllResultListWithNetworkModel:(HTNetworkModel *)networkModel resultIdString:(NSString *)resultIdString complete:(HTUserTaskCompleteBlock)complete {
	HTUser *user = [HTUserManager currentUser];
	NSString *uidString = user.uid;
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/school-result"
						 parameter:@{@"uid":HTPlaceholderString(uidString, @""),
									 @"id":HTPlaceholderString(resultIdString, @"")} complete:complete];
}

+ (void)requestSchoolMatriculateSingleResultListWithNetworkModel:(HTNetworkModel *)networkModel resultIdString:(NSString *)resultIdString complete:(HTUserTaskCompleteBlock)complete {
	HTUser *user = [HTUserManager currentUser];
	NSString *uidString = user.uid;
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/probability-result"
						 parameter:@{@"uid":HTPlaceholderString(uidString, @""),
									 @"id":HTPlaceholderString(resultIdString, @"")} complete:complete];
}


+ (void)requestMajorCatListWithNetworkModel:(HTNetworkModel *)networkModel complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/major-list"
                         parameter:@{@"page":@"1",
                                     @"pageSize":@"10"} complete:complete];
}

+ (void)requestMajorListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/major-list"
                         parameter:@{@"page":HTPlaceholderString(currentPage, @"1"),
                                     @"pageSize":HTPlaceholderString(pageSize, @"10"),
                                     @"catId":HTPlaceholderString(catIdString, @"")} complete:complete];
}

+ (void)requestMajorDetailWithNetworkModel:(HTNetworkModel *)networkModel majorParseId:(NSString *)majorParseId complete:(HTUserTaskCompleteBlock)complete {
    [HTNetworkManager requestModel:networkModel
                            method:HTNetworkRequestMethodPost
                               url:@"http://www.smartapply.cn/cn/app-api/major-detail"
                         parameter:@{@"id":HTPlaceholderString(majorParseId, @"")} complete:complete];
}

+ (void)requestMajorGoodWithNetworkModel:(HTNetworkModel *)networkModel majorIdString:(NSString *)majorIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/fabulous-content"
						 parameter:@{@"contentId":HTPlaceholderString(majorIdString, @"")} complete:complete];
}

+ (void)requestExampleIndexWithNetworkModel:(HTNetworkModel *)networkModel singleSectionItemCount:(NSInteger)singleSectionItemCount complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel
							method:HTNetworkRequestMethodPost
							   url:@"http://www.smartapply.cn/cn/app-api/success-case"
						 parameter:@{@"strip":[NSString stringWithFormat:@"%ld", singleSectionItemCount]} complete:complete];
}

+ (void)requestDiscoverListWithNetworkModel:(HTNetworkModel *)networkModel catIdString:(NSString *)catIdString pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/post-list" parameter:@{@"selectId":HTPlaceholderString(catIdString, @"1"), @"page":HTPlaceholderString(currentPage, @"1"), @"pageSize":HTPlaceholderString(pageSize, @"10")} complete:complete];
}


+ (void)requestDiscoverItemDetailWithNetworkModel:(HTNetworkModel *)networkModel discoverId:(NSString *)discoverId complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/post-details" parameter:@{@"postId":HTPlaceholderString(discoverId, @"")} complete:complete];
}


+ (void)requestDiscoverIssueWithNetworkModel:(HTNetworkModel *)networkModel titleString:(NSString *)titleString contentString:(NSString *)contentString catIdString:(NSString *)catIdString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/add-post" parameter:@{@"catId":HTPlaceholderString(catIdString, @"20"), @"title":HTPlaceholderString(titleString, @""), @"content":HTPlaceholderString(contentString, @"'")} complete:complete];
}

+ (void)requestDiscoverReplyWithNetworkModel:(HTNetworkModel *)networkModel discoverId:(NSString *)discoverId contentString:(NSString *)contentString complete:(HTUserTaskCompleteBlock)complete {
	[HTNetworkManager requestModel:networkModel method:HTNetworkRequestMethodPost url:@"http://bbs.viplgw.cn/cn/app-api/post-reply" parameter:@{@"postId":HTPlaceholderString(discoverId, @""), @"content":HTPlaceholderString(contentString, @"")} complete:complete];
}

@end
