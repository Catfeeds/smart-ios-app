//
//  HTAnswerIssueTagModel.m
//  School
//
//  Created by hublot on 2017/8/16.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAnswerIssueTagModel.h"

@implementation HTAnswerIssueTagModel

- (instancetype)init {
	self = [super init];
	if (self) {
		self.tagModelArray = @[];
		self.selectedIndexArray = [@[] mutableCopy];
	}
	return self;
}

@end
