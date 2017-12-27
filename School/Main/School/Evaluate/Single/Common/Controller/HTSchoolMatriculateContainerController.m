//
//  HTSchoolMatriculateContainerController.m
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateContainerController.h"
#import "HTSchoolMatriculateSingleController.h"
#import "HTSelectSchoolController.h"
#import "HTPersonMessageContainerController.h"
#import "HTSchoolMatriculateController.h"
#import "HTUserManager.h"
#import "HTMatriculateRecordModel.h"
#import "HTSchoolMatriculateSingleResultView.h"

@interface HTSchoolMatriculateContainerController ()<TSchoolMatriculateDelegate>

@property (nonatomic, strong) NSMutableArray *childControllerArray;
@property (nonatomic, strong) HTSchoolMatriculateParameterModel *parameter;

@end

@implementation HTSchoolMatriculateContainerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	if (StringNotEmpty(self.schoolID)) {
		[self requestSchool];
	}else{
		[self loadInterface:self.evaluationSchool];
	}
	
}

- (void)requestSchool{
	HTNetworkModel *networkModel = [HTNetworkModel modelForOnlyCacheNoInterfaceForScrollViewWithCacheStyle:HTCacheStyleAllUser];
	networkModel.autoAlertString = @"获取学校详情";
	[HTRequestManager requestSchoolDetailWithNetworkModel:networkModel schoolId:self.schoolID complete:^(id response, HTError *errorModel) {
		if (errorModel.existError) {
			[self loadInterface:self.evaluationSchool];
		}
		HTSchoolModel *schoolModel = [HTSchoolModel mj_objectWithKeyValues:response[@"data"]];
		schoolModel.major = [HTSchoolProfessionalModel mj_objectArrayWithKeyValuesArray:response[@"major"]];
		schoolModel.country = [NSString stringWithFormat:@"%@",response[@"country"]];
		[self loadInterface:schoolModel];
	}];
}

- (void)loadInterface:(HTSchoolModel *)evaluationSchool{
	
	self.parameter = [HTSchoolMatriculateParameterModel new];
	self.childControllerArray = [NSMutableArray arrayWithArray:self.childViewControllers];
	UIViewController *currentController = self.childViewControllers.lastObject;
	
	[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		((HTSchoolMatriculateController *)obj).delegate = self;
		obj.view.hidden = YES;
		if ([obj isKindOfClass:[HTSelectSchoolController class]]) {
			
			HTSelectSchoolController *vc = ((HTSelectSchoolController *)obj);
			vc.parameter = self.parameter;
			vc.selectedSchool = evaluationSchool;
			self.childControllerArray[0] = obj;
		}
		if ([obj isKindOfClass:[HTPersonMessageContainerController class]]) self.childControllerArray[1] = obj;
	}];
	
	[self transitionController:currentController toControllerIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TSchoolMatriculateDelegate

- (void)next:(UIViewController *) controller {
    NSInteger index = [self.childControllerArray indexOfObject:controller];
    [self transitionController:controller toControllerIndex:index+1];
    
}

- (void)previous:(UIViewController *) controller{
    NSInteger index = [self.childControllerArray indexOfObject:controller];
    [self transitionController:controller toControllerIndex:index-1];
}

- (void)submit{
	
	NSDictionary *parameterDic = [self.parameter mj_keyValues];
	
	[HTUserManager surePermissionHighOrEqual:HTUserPermissionExerciseAbleUser passCompareBlock:^(HTUser *user) {
		
				HTNetworkModel *networkModel = [[HTNetworkModel alloc] init];
				networkModel.autoShowError = true;
				networkModel.autoAlertString = @"获取学校录取测评中";
				networkModel.offlineCacheStyle = HTCacheStyleNone;
			
				[HTRequestManager requestSchoolSingleMatriculateResultWithNetworkModel:networkModel parameter:parameterDic complete:^(id response, HTError *errorModel) {
					if (errorModel.existError) {
						return;
					}
					[HTRequestManager requestSchoolMatriculateSingleResultListWithNetworkModel:networkModel resultIdString:nil complete:^(id response, HTError *errorModel) {
						if (errorModel.existError) {
							return;
						}
						HTMatriculateSingleSchoolModel *model = [HTMatriculateSingleSchoolModel mj_objectWithKeyValues:response[@"data"]];
						[HTSchoolMatriculateSingleResultView showResultViewWithResultModel:model];
					}];
			}];
	}];
	
}

- (void)transitionController:(UIViewController *)currentController toControllerIndex:(NSInteger)index{
	
        HTSchoolMatriculateController *toController = (HTSchoolMatriculateController*)self.childControllerArray[index];
		toController.parameter = self.parameter;
	if (toController == currentController){
		toController.view.hidden = NO;
		return;
	}
	  if ([toController isKindOfClass:[HTPersonMessageContainerController class]]) {
			HTPersonMessageContainerController *tempToController = (HTPersonMessageContainerController *)toController;
			HTSelectSchoolController *tempCurrentController = (HTSelectSchoolController *)currentController;
			tempToController.selectedSchoolName = tempCurrentController.selectedSchool.name;
			tempToController.selectedMajorName  = tempCurrentController.selectedMajor.name;
	    }
	
        [self transitionFromViewController:currentController toViewController:toController duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            currentController.view.hidden = YES;
            toController.view.hidden = NO;
    //        ((HTChooseSchoolController *)toController).parameter = self.parameterModel;
    //        self.contentHeightLayout.constant = ((HTChooseSchoolController *)toController).contentHeight + 200;
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
