//
//  HTCollectionViewLayoutAttributes.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTCollectionViewLayoutAttributes.h"

@implementation HTCollectionViewLayoutAttributes

#ifdef __IPHONE_9_0
- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
    return UIDynamicItemCollisionBoundsTypeEllipse;
}
#endif

@end
