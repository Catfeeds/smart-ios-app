//
//  HTDiscoverController.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPageController.h"
#import "HTHeadlineHeaderView.h"


@interface HTDiscoverController : HTPageController

@property (nonatomic, assign) id<HTHeadlineHeaderViewDelegate>delegate;

- (NSString *)getCurrentCatIDString;

@end
