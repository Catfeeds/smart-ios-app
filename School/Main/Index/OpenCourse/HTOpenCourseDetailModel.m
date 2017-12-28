//
//  HTOpenCourseDetailModel.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseDetailModel.h"

@implementation HTOpenCourseDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	
	return @{
			 @"title"	          :@"data.name",
			 @"courseImage"       :@"data.image",
			 @"openCourseTime"    :@"parent.cnName",
			 @"durationTime"      :@"parent.problemComplement",
			 @"teacherName"       :@"parent.listeningFile",
			 @"teacherImage"      :@"parent.article",
			 @"teacherDescription":@"parent.answer",
			 @"courseContent"	  :@"parent.sentenceNumber"
			 };
	
}

@end
