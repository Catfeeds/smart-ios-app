//
//  HTIndexAdvisorDetailModel.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTIndexAdvisorDetailModel.h"

@implementation HTIndexAdvisorDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"answer" : [HTIndexAdvisorDetailAnswerModel class], @"data" : [HTIndexAdvisorModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    NSMutableArray *modelArray = [@[] mutableCopy];
    [self.caseList enumerateObjectsUsingBlock:^(NSArray *caseArray, NSUInteger idx, BOOL * _Nonnull stop) {
        HTIndexAdvisorDetailStudentModel *model = [HTIndexAdvisorDetailStudentModel mj_objectWithKeyValues:caseArray.firstObject];
        if (model) {
            [modelArray addObject:model];
        }
    }];
    self.studentList = modelArray;
    
    HTIndexAdvisorModel *advisorModel = self.data.firstObject;
    NSMutableArray *circieModelArray = [@[] mutableCopy];
    NSString *titleNameKey = @"titleNameKey";
    NSString *detailNameKey = @"detailNameKey";
    NSString *backgroundColorKey = @"backgroundColorKey";
    NSArray *keyValueArray = @[
                                 @{titleNameKey:@"获取录取通知书", detailNameKey:[NSString stringWithFormat:@"%@份", advisorModel.listeningFile], backgroundColorKey:@"93cbf4"},
                                 @{titleNameKey:@"留学申请成功率", detailNameKey:[NSString stringWithFormat:@"%@%%", advisorModel.cnName], backgroundColorKey:@"7bddce"},
                                 @{titleNameKey:@"学生印象评分", detailNameKey:[NSString stringWithFormat:@"%@分", advisorModel.numbering], backgroundColorKey:@"ffc37f"}
                             ];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        HTIndexAdvisorDetailCircelModel *model = [[HTIndexAdvisorDetailCircelModel alloc] init];
        model.titleName = dictionary[titleNameKey];
        model.detailName = dictionary[detailNameKey];
        model.backgroundColor = [UIColor ht_colorString:dictionary[backgroundColorKey]];
        [circieModelArray addObject:model];
    }];
    self.circelModelArray = circieModelArray;
}

@end


@implementation HTIndexAdvisorDetailAnswerModel

@end


@implementation HTIndexAdvisorDetailStudentModel

@end

@implementation HTIndexAdvisorDetailCircelModel

@end
