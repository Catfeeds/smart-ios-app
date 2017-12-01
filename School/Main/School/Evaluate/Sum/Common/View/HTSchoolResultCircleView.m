//
//  HTSchoolResultCircleView.m
//  School
//
//  Created by hublot on 2017/7/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolResultCircleView.h"

@interface HTSchoolResultCircleView ()

@property (nonatomic, strong) CAShapeLayer *totalCircleLayer;

@property (nonatomic, strong) CAShapeLayer *completeCircleLayer;

@end

@implementation HTSchoolResultCircleView

- (instancetype)init {
	self = [super init];
	if (self) {
		[self initializeDefaultValue];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initializeDefaultValue];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self initializeDefaultValue];
}

- (void)initializeDefaultValue {
	self.lineWidth = 2;
	self.lineForegroundColor = [UIColor redColor];
	self.lineBackgroundColor = [UIColor ht_colorString:@"a79e9e"];
}

- (void)didMoveToSuperview {
	[self.layer addSublayer:self.totalCircleLayer];
	[self.layer addSublayer:self.completeCircleLayer];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:self.bounds.size.width / 2.0 startAngle: - M_PI_2 endAngle:M_PI * 1.5 clockwise:true];
	self.totalCircleLayer.path = self.completeCircleLayer.path = bezierPath.CGPath;
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	self.completeCircleLayer.strokeEnd = progress;
}

- (void)setLineWidth:(CGFloat)lineWidth {
	_lineWidth = lineWidth;
	self.totalCircleLayer.lineWidth = self.completeCircleLayer.lineWidth = lineWidth;
}

- (void)setLineBackgroundColor:(UIColor *)lineBackgroundColor {
	_lineBackgroundColor = lineBackgroundColor;
	self.totalCircleLayer.strokeColor = lineBackgroundColor.CGColor;
}

- (void)setLineForegroundColor:(UIColor *)lineForegroundColor {
	_lineForegroundColor = lineForegroundColor;
	self.completeCircleLayer.strokeColor = lineForegroundColor.CGColor;
}

- (CAShapeLayer *)totalCircleLayer {
	if (!_totalCircleLayer) {
		_totalCircleLayer = [CAShapeLayer layer];
		_totalCircleLayer.fillColor = [UIColor clearColor].CGColor;
	}
	return _totalCircleLayer;
}

- (CAShapeLayer *)completeCircleLayer {
	if (!_completeCircleLayer) {
		_completeCircleLayer = [CAShapeLayer layer];
		_completeCircleLayer.fillColor = [UIColor clearColor].CGColor;
		_completeCircleLayer.lineCap = kCALineCapRound;
		_completeCircleLayer.lineJoin = kCALineJoinRound;
		_completeCircleLayer.strokeEnd = 0;
	}
	return _completeCircleLayer;
}

@end
