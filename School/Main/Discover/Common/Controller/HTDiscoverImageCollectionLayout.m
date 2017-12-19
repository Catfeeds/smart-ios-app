//
//  HTDiscoverImageCollectionLayout.m
//  School
//
//  Created by Charles Cao on 2017/12/19.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTDiscoverImageCollectionLayout.h"

@implementation HTDiscoverImageCollectionLayout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
	
	NSMutableArray *attributes = [NSMutableArray array];
	for(NSInteger i=0 ; i < self.collectionView.numberOfSections; i++) {
		for (NSInteger j=0 ; j < [self.collectionView numberOfItemsInSection:i]; j++) {
			NSIndexPath* indexPath = [NSIndexPath indexPathForItem:j inSection:i];
			[attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
		}
	}
	return attributes;
}

@end
