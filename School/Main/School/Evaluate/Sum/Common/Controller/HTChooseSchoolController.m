//
//  HTChooseSchoolController.m
//  School
//
//  Created by Charles Cao on 2017/11/29.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolController.h"

@interface HTChooseSchoolController ()

@end

@implementation HTChooseSchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
	[super viewDidLayoutSubviews];
	if (self.contentHeight > 0) {
		CGRect frame = self.view.frame;
		frame.size.height = self.contentHeight;
		self.view.frame = frame;
	}
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
