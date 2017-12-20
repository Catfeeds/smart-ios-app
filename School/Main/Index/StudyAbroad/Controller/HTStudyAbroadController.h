//
//  HTStudyAbroadController.h
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTStudyAbroadController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *serviceButton;

@property (weak, nonatomic) IBOutlet UIButton *countryButton;

//下划线水平约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterLayoutConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//综合排序按钮
@property (weak, nonatomic) IBOutlet UIButton *sortButton_all;

//服务选择 / 国家选择
@property (weak, nonatomic) IBOutlet UIView *selectorView;


@end
