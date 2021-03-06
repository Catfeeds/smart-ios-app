//
//  HTLibraryApplyController.h
//  School
//
//  Created by hublot on 2017/8/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTReuseController.h"

@protocol HTLibraryApplyControllerDelegate

- (void)refresh;

@end

@interface HTLibraryApplyController : HTReuseController

@property (nonatomic, assign) id<HTLibraryApplyControllerDelegate>delegate;
@property (nonatomic, assign) NSInteger reuseControllerIndex;


@end
