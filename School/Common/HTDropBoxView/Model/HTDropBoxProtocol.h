//
//  HTDropBoxProtocol.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTDropBoxProtocol <NSObject>

@required

- (NSString *)ID;

- (NSString *)title;

- (BOOL)allowMutableSelected;

- (BOOL)isSelected;

- (void)setIsSelected:(BOOL)isSelected;

- (NSMutableArray <HTDropBoxProtocol> *)selectedModelArray;

@end
