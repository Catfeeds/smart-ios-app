//
//  HTAnimatorCollectionFlowLayout.m
//  School
//
//  Created by hublot on 17/9/3.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnimatorCollectionFlowLayout.h"
#import <CoreMotion/CoreMotion.h>
#import "HTCollectionViewLayoutAttributes.h"

@interface HTAnimatorCollectionFlowLayout ()

@property (nonatomic, strong) UIGravityBehavior *gravity;

@property (nonatomic, strong) UICollisionBehavior *collision;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation HTAnimatorCollectionFlowLayout

+ (Class)layoutAttributesClass {
    return [HTCollectionViewLayoutAttributes class];
}

- (void)prepareLayout {
    [super prepareLayout];
    if (self.animator.behaviors.count) {
        return;
    }
    CGSize contentSize = self.collectionViewContentSize;
    NSArray <UICollectionViewLayoutAttributes *> *attributesArray = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    [attributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.gravity addItem:attributes];
        [self.collision addItem:attributes];
    }];
    if (attributesArray.count) {
        [self.animator addBehavior:self.gravity];
        [self.animator addBehavior:self.collision];
        self.motionManager = self.motionManager;
    }
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray <UICollectionViewLayoutAttributes *> *attributesArray = (NSArray <UICollectionViewLayoutAttributes *> *)[self.animator itemsInRect:rect];
    return attributesArray;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] initWithItems:@[]];
    }
    return _gravity;
}

- (UICollisionBehavior *)collision {
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] initWithItems:@[]];
        _collision.translatesReferenceBoundsIntoBoundary = true;
    }
    return _collision;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return _animator;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.1;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        __weak typeof(self) weakSelf = self;
        [_motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.gravity.gravityDirection = CGVectorMake(accelerometerData.acceleration.x, - accelerometerData.acceleration.y);
            }];
        }];
    }
    return _motionManager;
}


@end
