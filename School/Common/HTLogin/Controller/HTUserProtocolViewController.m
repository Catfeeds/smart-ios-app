//
//  HTUserProtocolViewController.m
//  School
//
//  Created by Charles Cao on 2017/12/28.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserProtocolViewController.h"

@interface HTUserProtocolViewController ()

@end

@implementation HTUserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
	[self.textView setContentOffset:CGPointZero];
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
