//
//  HTOpenCourseDetailController.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseDetailController.h"
#import "HTOpenCourseDetailModel.h"

@interface HTOpenCourseDetailController () <UIScrollViewDelegate>

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
//    [self.courseContentTextView setAttributedText:self];
	CGFloat contentHeight = self.teacherDescriptionLabel.frame.size.height + 875;//375 : 简介以上高度
	self.scrollContentHeightLayoutConstraint.constant = contentHeight > CGRectGetHeight(self.scrollView.frame)  ? contentHeight : CGRectGetHeight(self.scrollView.frame);
	
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	if (scrollView.contentOffset.x > 0) {
		self.teacherButton.selected = YES;
		self.contentButton.selected = NO;
		self.lineCenterXLayoutConstraint.constant = CGRectGetWidth(self.contentButton.frame);
	}else{
		self.teacherButton.selected = NO;
		self.contentButton.selected = YES;
		self.lineCenterXLayoutConstraint.constant = 0;
	}
	
	[UIView animateWithDuration:0.2  animations:^{
		[self.view layoutIfNeeded];
	}];
	
}

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

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    NSLog(@"huadong");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"。。。。%@",view);
    return view;
}

@end

@implementation HTOpenCourseDetailScroll

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
  //  NSLog(@"%@",view);
    return view;
}

@end
