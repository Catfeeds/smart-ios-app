//
//  HTSchoolMatriculateSelectedController.h
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTSchoolMatriculateSelectedController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) void(^endSelectedBlock)(void);

@end
