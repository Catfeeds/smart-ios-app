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
	
//	@property (nonatomic, strong) NSString *title;
//	@property (nonatomic, strong) NSString *courseImage; //开课时间
//	@property (nonatomic, strong) NSString *openCourseTime; //开课时间
//	@property (nonatomic, strong) NSString *durationTime;   //时长
//	@property (nonatomic, strong) NSString *teacherName;    //老师名字
//	@property (nonatomic, strong) NSString *teacherImage;   //老师图片
//	@property (nonatomic, strong) NSString *teacherDescribe; //老师简介
//	@property (nonatomic, strong) NSString *courseContent; //课程内容
}

@end
