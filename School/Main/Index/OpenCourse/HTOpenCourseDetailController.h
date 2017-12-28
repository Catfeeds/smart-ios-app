//
//  HTOpenCourseDetailController.h
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTOpenCourseDetailController : UIViewController

@property (nonatomic, strong) NSString *courseId;
//课程图片
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;

//课程标题
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;

//开课时间
@property (weak, nonatomic) IBOutlet UILabel *openCourseTimeLabel;

//课程时长
@property (weak, nonatomic) IBOutlet UILabel *courseTimeLabel;
//顶部老师名字
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
//课程内容
@property (weak, nonatomic) IBOutlet UITextView *courseContentTextView;
//选择老师按钮
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
//选择课程按钮
@property (weak, nonatomic) IBOutlet UIButton *contentButton;

//详情滚动条
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;

//老师图片
@property (weak, nonatomic) IBOutlet UIImageView *teacherImageView;

//老师简介名字
@property (weak, nonatomic) IBOutlet UILabel *teacherDescriptionNameLabel;

//老师简介
@property (weak, nonatomic) IBOutlet UILabel *teacherDescriptionLabel;

//滑动高度区域
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentHeightLayoutConstraint;

//外层 scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//按钮底部横向相对于"课程内容"按钮水平对齐约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterXLayoutConstraint;

//选择 ‘课程内容’，‘授课老师’ 父view
@property (weak, nonatomic) IBOutlet UIView *selectorView;

@end
