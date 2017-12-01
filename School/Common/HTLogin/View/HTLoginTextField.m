//
//  HTLoginTextField.m
//  School
//
//  Created by hublot on 2017/6/15.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTLoginTextField.h"

@interface HTLoginTextField ()

@property (nonatomic, strong) CAShapeLayer *lineLayer;

@end

@implementation HTLoginTextField

- (void)didMoveToSuperview {
	self.font = [UIFont systemFontOfSize:14];
	self.textColor = [UIColor whiteColor];
	self.leftViewMode = UITextFieldViewModeAlways;
	self.textAlignment = NSTextAlignmentCenter;
	self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5]}];
	
	[self.layer addSublayer:self.lineLayer];
}

- (CAShapeLayer *)lineLayer {
	if (!_lineLayer) {
		_lineLayer = [CAShapeLayer layer];
		_lineLayer.strokeColor = [UIColor whiteColor].CGColor;
		_lineLayer.lineCap = kCALineCapRound;
		_lineLayer.lineJoin = kCALineJoinRound;
		_lineLayer.lineWidth = 1 / [UIScreen mainScreen].scale;
//		_lineLayer.lineDashPattern = @[@(1), @(1)];
	}
	return _lineLayer;
}

- (void)setBounds:(CGRect)bounds {
	[super setBounds:bounds];
	CGFloat height = 1 / [UIScreen mainScreen].scale;
	bounds.origin.y = bounds.size.height + height;
	bounds.size.height = height;
	self.lineLayer.frame = bounds;
	
	UIBezierPath *bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint:CGPointMake(0, 0)];
	[bezierPath addLineToPoint:CGPointMake(bounds.size.width, 0)];
	self.lineLayer.path = bezierPath.CGPath;
}

@end
