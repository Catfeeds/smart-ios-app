//
//  HTSearchController.h
//  School
//
//  Created by hublot on 2017/7/25.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPageController.h"
#import "HTSearchItemModel.h"

@interface HTSearchController : HTPageController

+ (void)presentSearchControllerAnimated:(BOOL)animated defaultSelectedType:(HTSearchType)defaultSelectedType;

@end
