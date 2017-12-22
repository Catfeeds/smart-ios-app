//
//  HTOpenCourseDetailController.m
//  School
//
//  Created by Charles Cao on 2017/12/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTOpenCourseDetailController.h"
#import "HTOpenCourseDetailModel.h"

@interface HTOpenCourseDetailController ()

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
