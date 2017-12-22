//
//  HTOpenCourseDetailModel.h
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTOpenCourseDetailModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *courseImage; //开课时间
@property (nonatomic, strong) NSString *openCourseTime; //开课时间
@property (nonatomic, strong) NSString *durationTime;   //时长
@property (nonatomic, strong) NSString *teacherName;    //老师名字
@property (nonatomic, strong) NSString *teacherImage;   //老师图片
@property (nonatomic, strong) NSString *teacherDescription; //老师简介
@property (nonatomic, strong) NSString *courseContent; //课程内容

@end
