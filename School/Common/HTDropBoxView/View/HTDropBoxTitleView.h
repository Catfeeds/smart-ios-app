//
//  HTDropBoxTitleView.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDropBoxProtocol.h"

typedef void(^HTDropBoxTitleDidSelectedBlock)(id <HTDropBoxProtocol> titleModel);

@interface HTDropBoxTitleView : UIView

@property (nonatomic, strong) NSArray <HTDropBoxProtocol> *modelArray;

@property (nonatomic, copy) HTDropBoxTitleDidSelectedBlock didSelectedBlock;

- (void)reloadData;

@end
