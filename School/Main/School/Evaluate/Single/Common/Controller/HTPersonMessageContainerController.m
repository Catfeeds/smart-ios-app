//
//  HTPersonMessageContainerController.m
//  School
//
//  Created by caoguochi on 2017/12/10.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTPersonMessageContainerController.h"
#import "HTSchoolMatriculateGradeController.h"
#import "HTSchoolMatriculateSchoolBackgroundController.h"
#import "HTSchoolMatriculateExperienceController.h"

typedef NS_ENUM(NSUInteger, HTAttributeType) {
	HTSchool,
	HTMajor
	
};

@interface HTPersonMessageContainerController ()<TSchoolMatriculateDelegate>

@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;


@property (nonatomic, strong) NSMutableArray *childControllerArray;

@end

@implementation HTPersonMessageContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.childControllerArray = [NSMutableArray arrayWithArray:self.childViewControllers];
    UIViewController *currentController = self.childViewControllers.lastObject;
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((HTSchoolMatriculateController *)obj).delegate = self;
        obj.view.hidden = YES;
        if ([obj isKindOfClass:[HTSchoolMatriculateGradeController class]]) self.childControllerArray[0] = obj;
        if ([obj isKindOfClass:[HTSchoolMatriculateSchoolBackgroundController class]]) self.childControllerArray[1] = obj;
        if ([obj isKindOfClass:[HTSchoolMatriculateExperienceController class]]) self.childControllerArray[2] = obj;
    }];
    
    [self transitionController:currentController toControllerIndex:0];
}

- (void)setSelectedMajorName:(NSString *)selectedMajorName{
	_selectedMajorName = selectedMajorName;
	self.majorLabel.attributedText = [self getAttributeText:selectedMajorName type:HTMajor];
}

- (void)setSelectedSchoolName:(NSString *)selectedSchoolName{
	_selectedSchoolName = selectedSchoolName;
	self.schoolLabel.attributedText = [self getAttributeText:selectedSchoolName type:HTSchool];
}

- (NSAttributedString *)getAttributeText:(NSString *)str type:(HTAttributeType) type {
	NSString *title;
	NSTextAttachment *imageAtta = [[NSTextAttachment alloc] init];
	if (type == HTSchool) {
		imageAtta.bounds = CGRectMake(0, -3, 26, 26);
		imageAtta.image = [UIImage imageNamed:@"school"];
		title = [NSString stringWithFormat:@" 大学 : %@",str];
	}else{
		imageAtta.bounds = CGRectMake(0, -3, 26, 18);
		imageAtta.image = [UIImage imageNamed:@"mz"];
		title = [NSString stringWithFormat:@" 专业 : %@",str];
	}
	
	NSAttributedString *attach = [NSAttributedString attributedStringWithAttachment:imageAtta];
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:title];
	[attribute insertAttributedString:attach atIndex:0];
	[attribute addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"777777"] range:NSMakeRange(0, attribute.length)];
	[attribute addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"98BC36"] range:NSMakeRange(0, attribute.length - str.length)];
	
	return attribute;
}

- (void)setParameter:(HTSchoolMatriculateParameterModel *)parameter{
	[super setParameter:parameter];
	HTSchoolMatriculateController *first = (HTSchoolMatriculateController *)self.childControllerArray.firstObject;
	first.parameter = parameter;
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
    if ([controller isKindOfClass:[HTSchoolMatriculateGradeController class]]) {
        [self.delegate previous:self];
    }else{
        NSInteger index = [self.childControllerArray indexOfObject:controller];
        [self transitionController:controller toControllerIndex:index-1];
    }
}

- (void)submit{
	[self.delegate submit];
}

- (void)transitionController:(UIViewController *)currentController toControllerIndex:(NSInteger)index{
	
	HTSchoolMatriculateController *toController = (HTSchoolMatriculateController*)self.childControllerArray[index];
	toController.parameter = self.parameter;

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
