//
//  UIViewController+HTAlertProfessionalDetailView.m
//  School
//
//  Created by Charles Cao on 2017/12/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "UIViewController+HTAlertProfessionalDetailView.h"
#import "HTSchoolMatriculateContainerController.h"
#import "HTWebController.h"

@implementation UIViewController (HTAlertProfessionalDetailView)

- (void)showProfessionDetailView:(NSString *)professionId{
	
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	networkModel.autoAlertString = @"项目详情";
	[HTRequestManager requestProfessionalWithNetworkModel:networkModel professionalId:professionId complete:^(id response, HTError *errorModel) {
		if (errorModel.errorString) {
			return;
		}
	
		HTProfessionalModel *detaiModel = [HTProfessionalModel mj_objectWithKeyValues:response];
	
		HTProfessionalDetailAlertView *alertView = [[NSBundle mainBundle]loadNibNamed:@"HTProfessionalDetailAlertView" owner:nil options:nil].firstObject;
		alertView.frame = self.view.bounds;
		alertView.delegate = self;
		alertView.professionalModel = detaiModel;
		[self.view addSubview:alertView];
	}];
}

#pragma mark - HTProfessionalDetailAlertViewDelegate
- (void)oddsTestAction:(HTProfessionalModel *)professionalModel{
	HTSchoolMatriculateContainerController *singleController =STORYBOARD_VIEWCONTROLLER(@"Home", @"HTSchoolMatriculateContainerController");
	singleController.schoolID = professionalModel.school.firstObject.ID;
	singleController.defaultSelectMajorId = professionalModel.data.firstObject.ID;
	[self.navigationController pushViewController:singleController animated:YES];
}

- (void)detailAction:(HTProfessionalModel *)professionalModel{
	HTProfessionalDetailModel *model = professionalModel.data.firstObject;
	if (StringNotEmpty(model.url)) {
		NSURL *url = [NSURL URLWithString:model.url];
		HTWebController *webController = [[HTWebController alloc] initWithURL:url];
		[self.navigationController pushViewController:webController animated:true];
	}else{
		[HTAlert title:@"暂时没有网址"];
	}
}

@end
