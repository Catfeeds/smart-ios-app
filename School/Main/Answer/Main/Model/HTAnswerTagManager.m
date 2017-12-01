//
//  HTAnswerTagManager.m
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerTagManager.h"
#import "HTAnswerTagModel.h"

@implementation HTAnswerTagManager

static NSInteger kHTTagListShouldRequest = true;

NSString *const kHTSelectedTagArrayDidChangeNotifacation = @"kHTSelectedTagArrayDidChangeNotifacation";

static NSString *kHTAnswerTagSaveIdentifier = @"kHTAnswerTagSaveIdentifier";

+ (void)saveSelectedAnswerTagArray:(NSArray *)selectedAnswerTagArray {
	NSArray *currentSelectedArray = [self localAnswerTagArray];
	if (![self compareTagFirstModelArray:selectedAnswerTagArray secondModelArray:currentSelectedArray]) {
		[self saveLocalAnswerTagArray:selectedAnswerTagArray];
		[[NSNotificationCenter defaultCenter] postNotificationName:kHTSelectedTagArrayDidChangeNotifacation object:nil];
	}
}

+ (void)requestCurrentAnswerTagArrayBlock:(void(^)(NSMutableArray *answerTagArray))answerTagArrayBlock {
	if (!answerTagArrayBlock) {
		return;
	}
	
	__block NSMutableArray *localTagArray = [self localAnswerTagArray];
	
	if (kHTTagListShouldRequest) {
		HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
		[HTRequestManager requestAnswerTagListWithNetworkModel:networkModel complete:^(id response, HTError *errorModel) {
			if (errorModel.existError) {
				answerTagArrayBlock(localTagArray);
				return;
			}
			kHTTagListShouldRequest = false;
			__block NSMutableArray *networkTagArray = [HTAnswerTagModel mj_objectArrayWithKeyValuesArray:response];
			if (!localTagArray) {
				[networkTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *networkAnswerTagModel, NSUInteger idx, BOOL * _Nonnull stop) {
					networkAnswerTagModel.isEnable = true;
				}];
			} else {
				NSMutableArray *compareTagModelArray = [@[] mutableCopy];
				[localTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *localAnswerTagModel, NSUInteger index, BOOL * _Nonnull stop) {
					[networkTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *networkAnswerTagModel, NSUInteger index, BOOL * _Nonnull stop) {
						if (networkAnswerTagModel.ID.integerValue == localAnswerTagModel.ID.integerValue) {
							networkAnswerTagModel.isEnable = localAnswerTagModel.isEnable;
							[compareTagModelArray addObject:networkAnswerTagModel];
						}
					}];
				}];
				[networkTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *networkAnswerTagModel, NSUInteger idx, BOOL * _Nonnull stop) {
					if (![self findTagModelWithTagIdString:networkAnswerTagModel.ID fromModelArray:localTagArray]) {
						[compareTagModelArray addObject:networkAnswerTagModel];
					}
				}];
				networkTagArray = compareTagModelArray;
			}
			localTagArray = networkTagArray;
			[self saveSelectedAnswerTagArray:localTagArray];
			answerTagArrayBlock(localTagArray);
		}];
	} else {
		[self saveSelectedAnswerTagArray:localTagArray];
		answerTagArrayBlock(localTagArray);
	}
	
}

+ (HTAnswerTagModel *)findTagModelWithTagIdString:(NSString *)tagIdString fromModelArray:(NSArray *)fromModelArray {
	__block HTAnswerTagModel *tagModel = nil;
	NSInteger tagId = tagIdString.integerValue;
	[fromModelArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
		if (model.ID.integerValue == tagId) {
			tagModel = model;
			*stop = true;
		}
	}];
	return tagModel;
}

+ (BOOL)compareTagFirstModelArray:(NSArray *)fisrtModelArray secondModelArray:(NSArray *)secondModelArray {
	__block BOOL isEqualModel = true;
	if (fisrtModelArray.count != secondModelArray.count) {
		return false;
	}
	[fisrtModelArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *firstTagModel, NSUInteger index, BOOL * _Nonnull stop) {
		if (secondModelArray.count > index) {
			HTAnswerTagModel *secondTagModel = secondModelArray[index];
			if (![firstTagModel.ID isEqualToString:secondTagModel.ID]) {
				isEqualModel = false;
				*stop = true;
			} else if (firstTagModel.isEnable != secondTagModel.isEnable) {
				isEqualModel = false;
				*stop = true;
			} else if (![firstTagModel.name isEqualToString:secondTagModel.name]) {
				isEqualModel = false;
				*stop = true;
			}
		} else {
			isEqualModel = false;
		}
	}];
	return isEqualModel;
}

+ (void)saveLocalAnswerTagArray:(NSArray *)answerTagArray {
	NSMutableArray *keyValueArray = [@[] mutableCopy];
	[answerTagArray enumerateObjectsUsingBlock:^(HTAnswerTagModel *answerTagModel, NSUInteger index, BOOL * _Nonnull stop) {
		NSDictionary *dictionary = answerTagModel.mj_keyValues;
		[keyValueArray addObject:dictionary];
	}];
	[[NSUserDefaults standardUserDefaults] setValue:keyValueArray forKey:kHTAnswerTagSaveIdentifier];
}

+ (NSMutableArray *)localAnswerTagArray {
	NSMutableArray *keyValueArray = [[NSUserDefaults standardUserDefaults] valueForKey:kHTAnswerTagSaveIdentifier];
	if (!keyValueArray) {
		return nil;
	}
	NSMutableArray *answerTagArray = [@[] mutableCopy];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTAnswerTagModel *answerTagModel = [HTAnswerTagModel mj_objectWithKeyValues:dictionary];
		[answerTagArray addObject:answerTagModel];
	}];
	return answerTagArray;
}

@end
