//
//  HTSearchResultModel.m
//  School
//
//  Created by hublot on 2017/9/12.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSearchResultModel.h"
#import "HTSchoolModel.h"
#import "HTProfessionalModel.h"
#import "HTAnswerModel.h"
#import "HTDiscoverActivityModel.h"
#import "HTLibraryModel.h"
#import <NSString+HTString.h>

@implementation HTSearchResultModel

+ (NSArray *)packModelArrayWithResponse:(id)response type:(HTSearchType)type {
	NSMutableArray *modelArray = [@[] mutableCopy];
	switch (type) {
		case HTSearchTypeSchool: {
			NSArray *responseArray = [HTSchoolModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[responseArray enumerateObjectsUsingBlock:^(HTSchoolModel *schoolModel, NSUInteger index, BOOL * _Nonnull stop) {
				HTSearchResultModel *resultModel = [[HTSearchResultModel alloc] init];
				resultModel.ID = schoolModel.ID;
				resultModel.titleName = schoolModel.name;
				resultModel.detailName = schoolModel.title;
				resultModel.image = schoolModel.image;
				[modelArray addObject:resultModel];
			}];
			break;
		}
		case HTSearchTypeProfessional: {
			NSArray *responseArray = [HTProfessionalDetailModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[responseArray enumerateObjectsUsingBlock:^(HTProfessionalDetailModel *majorModel, NSUInteger index, BOOL * _Nonnull stop) {
				HTSearchResultModel *resultModel = [[HTSearchResultModel alloc] init];
				resultModel.ID = majorModel.ID;
				resultModel.titleName = majorModel.name;
				resultModel.detailName = majorModel.title;
				resultModel.image = majorModel.image;
				[modelArray addObject:resultModel];
			}];
			break;
		}
		case HTSearchTypeAnswer: {
			NSArray *responseArray = [HTAnswerModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[responseArray enumerateObjectsUsingBlock:^(HTAnswerModel *answerModel, NSUInteger index, BOOL * _Nonnull stop) {
				HTSearchResultModel *resultModel = [[HTSearchResultModel alloc] init];
				resultModel.ID = answerModel.ID;
				resultModel.titleName = answerModel.question;
				resultModel.detailName = [[answerModel.content ht_htmlDecodeString] ht_attributedStringNeedDispatcher:nil].string;
				resultModel.image = answerModel.image;
				[modelArray addObject:resultModel];
			}];
			break;
		}
		case HTSearchTypeActivity: {
			NSArray *responseArray = [HTDiscoverActivityModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[responseArray enumerateObjectsUsingBlock:^(HTDiscoverActivityModel *activityModel, NSUInteger index, BOOL * _Nonnull stop) {
				HTSearchResultModel *resultModel = [[HTSearchResultModel alloc] init];
				resultModel.ID = activityModel.ID;
				resultModel.titleName = activityModel.name;
				resultModel.detailName = activityModel.answer;
				resultModel.image = activityModel.image;
				[modelArray addObject:resultModel];
			}];
			break;
		}
		case HTSearchTypeLibrary: {
			NSArray *responseArray = [HTLibraryApplyContentModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
			[responseArray enumerateObjectsUsingBlock:^(HTLibraryApplyContentModel *libraryModel, NSUInteger index, BOOL * _Nonnull stop) {
				HTSearchResultModel *resultModel = [[HTSearchResultModel alloc] init];
				resultModel.ID = libraryModel.ID;
				resultModel.titleName = libraryModel.name;
				resultModel.detailName = libraryModel.createTime;
				resultModel.image = libraryModel.image;
				[modelArray addObject:resultModel];
			}];
			break;
		}
	}
	[modelArray enumerateObjectsUsingBlock:^(HTSearchResultModel *model, NSUInteger index, BOOL * _Nonnull stop) {
		model.type = type;
	}];
	return modelArray;
}

@end
