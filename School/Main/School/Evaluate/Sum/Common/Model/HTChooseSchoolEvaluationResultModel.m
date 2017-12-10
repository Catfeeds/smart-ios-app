//
//  HTChooseSchoolEvaluationResultModel.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolEvaluationResultModel.h"

@implementation HTChooseSchoolEvaluationResultModel

@end

@implementation HTResultSchool

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

@end


@implementation HTResultData

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"res" : @"HTResultSchool"
			 };
}

@end

@implementation HTCompareResult

@end


@implementation HTScore

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.allScores = [NSMutableArray array];
    if (self.gpa) {
        self.gpa.scoreType = HTCompareResultGpa;
        [self.allScores addObject:self.gpa];
    }
    if (self.gmat){
        self.gmat.scoreType = HTCompareResultGMAT;
        [self.allScores addObject:self.gmat];
    }
    if (self.toefl) {
        self.toefl.scoreType = HTCompareResultToefl;
        [self.allScores addObject:self.toefl];
    }
    if (self.school) {
        self.school.scoreType = HTCompareResultSchool;
        [self.allScores addObject:self.school];
    }
    if (self.work) {
        self.work.scoreType = HTCompareResultWork;
        [self.allScores addObject:self.work];
    }
    
}

@end


@implementation HTResultUser

@end

