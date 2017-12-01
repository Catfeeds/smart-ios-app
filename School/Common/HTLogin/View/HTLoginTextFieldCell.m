//
//  HTLoginTextFieldCell.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginTextFieldCell.h"

@implementation HTLoginTextFieldCell

- (void)didMoveToSuperview {
	self.backgroundColor = [UIColor clearColor];
}

- (void)setFrame:(CGRect)frame {
	frame.origin.x += HTADAPT568(30);
	frame.origin.y += 10;
	frame.size.width -= HTADAPT568(60);
	frame.size.height -= 10;
	[super setFrame:frame];
}

@end
