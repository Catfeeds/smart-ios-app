//
//  NSObject+HTExtension.m
//  School
//
//  Created by hublot on 2017/8/17.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "NSObject+HTExtension.h"

@implementation NSObject (HTExtension)

+ (void)load {
	[self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
		return @{@"ID":@"id", @"Description":@"description"};
	}];
}


@end
