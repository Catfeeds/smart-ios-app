//
//  HTEvaluateModel.m
//  School
//
//  Created by hublot on 2017/9/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTEvaluateModel.h"

@implementation HTEvaluateModel

+ (NSArray <HTEvaluateModel *> *)packModelArray {
	NSMutableArray *modelArray = [@[] mutableCopy];
	
	NSString *titleNameKey = @"titleNameKey";
	NSString *detailNameKey = @"detailNameKey";
	NSString *imageNameKey = @"imageNameKey";
	NSString *backgroundImageKey = @"backgroundImageKey";
	NSString *evaluateTypeKey = @"evaluateTypeKey";
	NSArray *keyValueArray = @[
							   	@{evaluateTypeKey: @(HTEvaluateTypeBackground), titleNameKey:@"背景测评", detailNameKey:@"\"我该如何合理规划申请时间?\" 1分钟完成专 业测评，即可获得留学评估师提供的全面专业 留学评估报告与方案建议，为你指点迷津。", imageNameKey:@"ht_evaluate_background_head", backgroundImageKey:@"ht_evaluate_background_background"},
								@{evaluateTypeKey: @(HTEvaluateTypeSum), titleNameKey:@"选校测评", detailNameKey:@"为学生了解自身情况、寻找合适院校，“我 目前水平能申到哪些国外学校？”自动生成 选校报告+熟悉申请条件。", imageNameKey:@"ht_evaluate_sum_head", backgroundImageKey:@"ht_evaluate_sum_background"},
								@{evaluateTypeKey: @(HTEvaluateTypeSingle), titleNameKey:@"学校录取测评", detailNameKey:@"被自己的 Dream School 录取是怎样的体 验？来测评下我离名校的距离还差多少。", imageNameKey:@"ht_evaluate_single_head", backgroundImageKey:@"ht_evaluate_single_background"},
							 ];
	[keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
		HTEvaluateModel *model = [[HTEvaluateModel alloc] init];
		model.type = [dictionary[evaluateTypeKey] integerValue];
		model.titleName = dictionary[titleNameKey];
		model.detailName = dictionary[detailNameKey];
		model.imageName = dictionary[imageNameKey];
		model.backgroundImageName = dictionary[backgroundImageKey];
		[modelArray addObject:model];
	}];
	
	return modelArray;
}

@end
