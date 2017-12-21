//
//  HTAnswerTagCollectionViewLayout.m
//  School
//
//  Created by Charles Cao on 2017/12/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerTagCollectionViewLayout.h"

@implementation HTAnswerTagCollectionViewLayout

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
