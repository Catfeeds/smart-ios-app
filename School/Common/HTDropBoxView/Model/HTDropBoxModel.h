//
//  HTDropBoxModel.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTDropBoxProtocol.h"

@interface HTDropBoxModel : NSObject <HTDropBoxProtocol>

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL allowMutableSelected;

@property (nonatomic, strong) NSMutableArray <HTDropBoxProtocol> *selectedModelArray;

@end
