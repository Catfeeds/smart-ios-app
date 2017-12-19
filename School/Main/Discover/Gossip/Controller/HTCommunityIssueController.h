//
//  HTCommunityIssueController.h
//  GMat
//
//  Created by hublot on 2016/10/26.
//  Copyright © 2016年 thinku. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTCommunityIssueControllerDelete <NSObject>

//发帖成功
- (void)sendPostSuccess;

@end

@interface HTCommunityIssueController : UIViewController

@property (nonatomic, assign) id<HTCommunityIssueControllerDelete> delegate;

@end
