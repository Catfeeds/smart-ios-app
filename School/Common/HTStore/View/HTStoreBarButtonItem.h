//
//  HTStoreBarButtonItem.h
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTStoreBarButtonItem : UIBarButtonItem

@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithTapHandler:(void (^)(HTStoreBarButtonItem *item))action;

@end
