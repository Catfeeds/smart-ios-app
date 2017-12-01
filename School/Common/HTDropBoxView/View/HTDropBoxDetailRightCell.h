//
//  HTDropBoxDetailRightCell.h
//  HTDropBox
//
//  Created by hublot on 2017/9/22.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDropBoxCellProtocol.h"

@interface HTDropBoxDetailRightCell : UICollectionViewCell <HTDropBoxCellProtocol>

@property (nonatomic, strong) id <HTDropBoxProtocol> model;

+ (CGFloat)collectionItemHeight;

+ (CGFloat)cellFontPointSize;

@end
