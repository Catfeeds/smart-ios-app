//
//  HTExampleSectionScrollView.h
//  School
//
//  Created by hublot on 2017/9/27.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTExampleScrollController.h"

typedef void(^HTExampleSectionReloadHeightBlock)(void);

@interface HTExampleSectionScrollView : UIView

@property (nonatomic, strong) HTExampleScrollController *currentScrollController;

@property (nonatomic, copy) HTExampleSectionReloadHeightBlock reloadHeightBlock;

- (void)refreshTableFooterModelArrayComplete:(void(^)(void))complete;

@end
