//
//  HTSomeoneModel.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSomeoneModel.h"

@implementation HTSomeoneModel

+ (NSArray <HTSomeoneModel *> *)packModelArrayWithUser:(HTUser *)user {
    NSString *someoneTypeKey = @"someoneTypeKey";
    NSString *titleNameKey = @"titleNameKey";
    NSString *imageNameKey = @"imageNameKey";
    NSString *detailCountKey = @"detailCountKey";
    NSMutableArray *modelArray = [@[] mutableCopy];
    NSArray *keyValueArray = @[
                                 @{someoneTypeKey:@(HTSomeoneTypeAnswer), titleNameKey:@"Ta 的提问", imageNameKey:@"cn_mine_header_question", detailCountKey:[NSString stringWithFormat:@"%ld", user.questionNum.integerValue]},
                                 @{someoneTypeKey:@(HTSomeoneTypeSolution), titleNameKey:@"Ta 的回答", imageNameKey:@"cn_mine_header_answer", detailCountKey:[NSString stringWithFormat:@"%ld", user.answerNum.integerValue]},
                                 @{someoneTypeKey:@(HTSomeoneTypeFans), titleNameKey:@"Ta 的粉丝", imageNameKey:@"cn_mine_header_fans", detailCountKey:[NSString stringWithFormat:@"%ld", user.fans.integerValue]},
                                 @{someoneTypeKey:@(HTSomeoneTypeLike), titleNameKey:@"Ta 的关注", imageNameKey:@"cn_mine_header_like", detailCountKey:[NSString stringWithFormat:@"%ld", user.follow.integerValue]},
                             ];
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL * _Nonnull stop) {
        HTSomeoneModel *model = [[HTSomeoneModel alloc] init];
        model.type = [dictionary[someoneTypeKey] integerValue];
        model.titleName = dictionary[titleNameKey];
        model.imageName = dictionary[imageNameKey];
        model.detailCount = dictionary[detailCountKey];
        [modelArray addObject:model];
    }];
    return modelArray;
}

@end
