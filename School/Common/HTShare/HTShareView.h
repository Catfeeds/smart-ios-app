//
//  HTShareView.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@interface HTShareView : UIView

+ (void)showTitle:(NSString *)title detail:(NSString *)detail image:(id)image url:(NSString *)url type:(SSDKContentType)type;

@end
