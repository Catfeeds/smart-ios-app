//
//  HTChooseSchoolGradeController.m
//  School
//
//  Created by caoguochi on 2017/11/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolEvaluationController.h"
#import "HTGradeEvaluationController.h"
#import "HTSchoolBackgroundController.h"
#import "HTPersonBackgroundController.h"
#import "HTApplyBackgroundController.h"
#import "HTChooseSchoolAppraisalHeaderView.h"

#import "HTSchoolMatriculateDetailController.h"

@interface HTChooseSchoolEvaluationController ()<HTChooseSchoolEvaluationDelegate>

@property (nonatomic, strong) NSMutableArray *childControllerArray;
@property (weak, nonatomic) IBOutlet HTChooseSchoolAppraisalHeaderView *chooseSchoolProgressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightLayout;
@property (nonatomic, strong) HTChooseSchoolEvaluationModel *parameterModel;

@end

@implementation HTChooseSchoolEvaluationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.parameterModel = [HTChooseSchoolEvaluationModel new];
	self.childControllerArray = [NSMutableArray arrayWithArray:self.childViewControllers];
	UIViewController *currentController = self.childViewControllers.lastObject;
	
	[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		((HTChooseSchoolController *)obj).delegate = self;
		obj.view.hidden = YES;
		if ([obj isKindOfClass:[HTGradeEvaluationController class]]) self.childControllerArray[0] = obj;
		if ([obj isKindOfClass:[HTSchoolBackgroundController class]]) self.childControllerArray[1] = obj;
		if ([obj isKindOfClass:[HTPersonBackgroundController class]]) self.childControllerArray[2] = obj;
		if ([obj isKindOfClass:[HTApplyBackgroundController class]]) self.childControllerArray[3] = obj;
	}];
	
	[self transitionController:currentController toControllerIndex:0];
	
	UIBarButtonItem *testItem = [[UIBarButtonItem alloc]initWithTitle:@"测试的" style:UIBarButtonItemStylePlain target:self action:@selector(teset)];
	self.navigationItem.rightBarButtonItem = testItem;
}

- (void)teset{
	HTSchoolMatriculateDetailController *sumController = [[HTSchoolMatriculateDetailController alloc] init];
	[self.navigationController pushViewController:sumController animated:YES];
}

#pragma mark - HTChooseSchoolEvaluationDelegate
- (void)next:(UIViewController *) controller {
	NSInteger index = [self.childControllerArray indexOfObject:controller];
	[self transitionController:controller toControllerIndex:index+1];
	
}

- (void)previous:(UIViewController *) controller{
	NSInteger index = [self.childControllerArray indexOfObject:controller];
	[self transitionController:controller toControllerIndex:index-1];
}

- (void)submit{
	
	HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
	networkModel.autoAlertString = @"上传智能选校";
	networkModel.autoShowError = true;
	networkModel.offlineCacheStyle = HTCacheStyleNone;
	
	NSDictionary *para = [self.parameterModel mj_keyValues];
	
	[HTRequestManager requestSendSchoolMatriculateWithNetworkModel:networkModel parameter:para complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			return;
		}
//		HTSchoolMatriculateResultController *resultController = [[HTSchoolMatriculateResultController alloc] init];
//		[weakSelf.navigationController pushViewController:resultController animated:true];
	}];
}

- (void)transitionController:(UIViewController *)currentController toControllerIndex:(NSInteger)index{
    self.chooseSchoolProgressView.progress = index;
    UIViewController *toController = self.childControllerArray[index];
	[self transitionFromViewController:currentController toViewController:toController duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
		currentController.view.hidden = YES;
		toController.view.hidden = NO;
		((HTChooseSchoolController *)toController).parameter = self.parameterModel;
		self.contentHeightLayout.constant = ((HTChooseSchoolController *)toController).contentHeight + 200;
		
		
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
