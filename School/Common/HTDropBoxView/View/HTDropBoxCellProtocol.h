//
//  HTDropBoxCellProtocol.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTDropBoxProtocol.h"

@protocol HTDropBoxCellProtocol <NSObject>

- (void)setModel:(id <HTDropBoxProtocol> )model;

@end
