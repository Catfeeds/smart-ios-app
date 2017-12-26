//
//  HTOpenCourseDetailController.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseDetailController.h"
#import "HTOpenCourseDetailModel.h"
#import <NSString+HTString.h>
#import "HTSignUpOpenCourseView.h"


typedef NS_ENUM(NSUInteger, HTShowContent) {
	HTCourseContent,
	HTTeacherDescription
};

@interface HTOpenCourseDetailController () <UIScrollViewDelegate, UITextViewDelegate, HTSignUpOpenCourseViewDelegate>

@property (nonatomic, strong) HTOpenCourseDetailModel *model;
@property (nonatomic, strong) HTSignUpOpenCourseView  *singupView;

@end

@implementation HTOpenCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self loadData];
}

- (void)loadData{
	
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoShowError = true;
	networkModel.autoAlertString = @"获取公开课详情";
	networkModel.offlineCacheStyle = HTCacheStyleNone;
	
	[HTRequestManager requestOpenCourseDetailWithNetworkModel:networkModel courseID:self.courseId complete:^(id response, HTError *errorModel) {
		HTOpenCourseDetailModel *detailModel = [HTOpenCourseDetailModel mj_objectWithKeyValues:response];
		[self loadInterfaceWithModel:detailModel];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInterfaceWithModel:(HTOpenCourseDetailModel *)model{
	self.model = model;
	self.title = model.title;
	NSString *urlStr = [NSString stringWithFormat:@"http://open.viplgw.cn%@",model.courseImage];
	[self.courseImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:HTPLACEHOLDERIMAGE];
	
	self.courseTitleLabel.text = model.title;
	self.openCourseTimeLabel.text = [NSString stringWithFormat:@"开课时间:%@",model.openCourseTime];
	self.courseTimeLabel.text = [NSString stringWithFormat:@"课程时长:%@",model.durationTime];
	self.teacherLabel.text = [NSString stringWithFormat:@"授课老师:%@",model.teacherName];
	NSString * teacherHeader = [NSString stringWithFormat:@"http://open.viplgw.cn%@",model.teacherImage];
	[self.teacherImageView sd_setImageWithURL:[NSURL URLWithString:teacherHeader]  placeholderImage:HTPLACEHOLDERIMAGE];
	self.teacherDescriptionNameLabel.text = model.teacherName;
	self.teacherDescriptionLabel.text = model.teacherDescription;
	[self.teacherDescriptionLabel sizeToFit];
	//[self.courseContentTextView setAttributedText:[model.courseContent htmlToAttributeStringContent:@"http://open.viplgw.cn" width:CGRectGetWidth(self.courseContentTextView.frame)]];
	CGFloat contentHeight = self.teacherDescriptionLabel.frame.size.height + 375;//375 : 简介以上高度
	self.scrollContentHeightLayoutConstraint.constant = contentHeight > CGRectGetHeight(self.scrollView.frame)  ? contentHeight : CGRectGetHeight(self.scrollView.frame);
	
}



- (void)changeContent:(HTShowContent) showContent{
	if (showContent == HTTeacherDescription) {
		self.teacherButton.selected = YES;
		self.contentButton.selected = NO;
		[self.detailScrollView setContentOffset:CGPointMake(HTSCREENWIDTH, 0) animated:YES];
		self.lineCenterXLayoutConstraint.constant = CGRectGetWidth(self.contentButton.frame);
	}else{
		self.teacherButton.selected = NO;
		self.contentButton.selected = YES;
		self.lineCenterXLayoutConstraint.constant = 0;
		[self.detailScrollView setContentOffset:CGPointZero animated:YES];
	}
	
	[UIView animateWithDuration:0.2  animations:^{
		[self.view layoutIfNeeded];
	}];
}

- (IBAction)signUpAction:(id)sender {
	self.singupView = [[NSBundle mainBundle] loadNibNamed:@"HTSignUpOpenCourseView" owner:nil options:nil].firstObject;
	self.singupView.frame = self.view.frame;
	self.singupView.delegate = self;
	[self.view addSubview:self.singupView];
}

#pragma mark - HTSignUpOpenCourseViewDelegate

- (void)submit:(NSString *)name phone:(NSString *)phone {
	
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoShowError = true;
	networkModel.autoAlertString = @"报名公开课";
	networkModel.offlineCacheStyle = HTCacheStyleNone;
	
	[HTRequestManager requestSignupOpenCourseWithNetworkModel:networkModel courseID:self.courseId usernameString:name phoneNumberString:phone courseTitleString:self.model.title complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
		[HTAlert title:@"报名成功"];
		[self.singupView removeFromSuperview];
	}];
}


//课程内容  授课老师action tag-100(课程内容) tag-101授课老师
- (IBAction)detailChangeAction:(UIButton *)sender {
	[self changeContent:sender.tag == 100 ? HTCourseContent : HTTeacherDescription];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	if (scrollView == self.detailScrollView) {
		[self changeContent:scrollView.contentOffset.x > 0 ? HTTeacherDescription : HTCourseContent ];
	}
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//	if (scrollView == self.courseContentTextView) {
//		if (self.courseContentTextView.contentOffset.y > self.courseContentTextView.contentSize.height) {
//
//			[self.scrollView setContentOffset:scrollView.contentOffset];
//		}
//	}
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation HTOpenCourseDetailTextView



@end

@implementation HTOpenCourseDetailScroll

@end
