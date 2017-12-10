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

@interface HTSchoolMatriculateContainerController ()<TSchoolMatriculateDelegate>

@property (nonatomic, strong) NSMutableArray *childControllerArray;

@end

@implementation HTSchoolMatriculateContainerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.childControllerArray = [NSMutableArray arrayWithArray:self.childViewControllers];
    UIViewController *currentController = self.childViewControllers.lastObject;
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((HTSchoolMatriculateController *)obj).delegate = self;
        obj.view.hidden = YES;
        if ([obj isKindOfClass:[HTSelectSchoolController class]]) self.childControllerArray[0] = obj;
        if ([obj isKindOfClass:[HTPersonMessageContainerController class]]) self.childControllerArray[1] = obj;
    }];
    
    [self transitionController:currentController toControllerIndex:0];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"ceshi" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)test{
    HTSchoolMatriculateSingleController *singleController = [[HTSchoolMatriculateSingleController alloc] init];
    [self.navigationController pushViewController:singleController animated:YES];
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
    
}

- (void)transitionController:(UIViewController *)currentController toControllerIndex:(NSInteger)index{
    
        UIViewController *toController = self.childControllerArray[index];
      if (toController == currentController) return;
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
