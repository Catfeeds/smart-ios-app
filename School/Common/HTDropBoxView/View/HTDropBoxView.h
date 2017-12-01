//
//  HTDropBoxView.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDropBoxProtocol.h"

typedef void(^HTDropBoxAnimationComplete)(void);

typedef void(^HTDropBoxSureReloadBlock)(void);

@interface HTDropBoxView : UIView

@property (nonatomic, strong) NSArray <HTDropBoxProtocol> *titleModelArray;

@property (nonatomic, copy) HTDropBoxSureReloadBlock sureReloadBlock;

- (void)reloadData;

- (void)closeDetailViewAnimation:(BOOL)animation complete:(HTDropBoxAnimationComplete)complete;

@end
