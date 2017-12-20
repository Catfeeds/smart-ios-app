//
//  HTCommunityController.h
//  GMat
//
//  Created by hublot on 2016/10/26.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommunityRingHeaderView.h"
#import "HTCommunityIssueController.h"

@interface HTCommunityController : UIViewController  <HTCommunityIssueControllerDelete>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTCommunityRingHeaderView *communityHeaderView;

@end
