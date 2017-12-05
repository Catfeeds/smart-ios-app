//
//  PrefixHeader.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import <Masonry.h>
#import <BlocksKit.h>
#import <BlocksKit+UIKit.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <MJExtension.h>


#import "HTRequestManager.h"
#import "UIColor+HTColorCategory.h"
#import <UIImage+HTImage.h>
#import "UIFont+HTFont.h"
#import <UIView+HTView.h>
#import "MTA.h"
#import "HTAlert.h"

#define HTPLACEHOLDERIMAGE [UIImage imageNamed:@"cn_placeholder"]
#define HTSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define HTADAPT568(number) (number * sqrt(MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) / 320))

#define StringNotEmpty(str)             (str && (str.length > 0))
#define ArrayNotEmpty(arr)              (arr && (arr.count > 0))

#define STORYBOARD_VIEWCONTROLLER(sb, vc) [[UIStoryboard storyboardWithName:sb bundle:nil] instantiateViewControllerWithIdentifier:vc];

#endif /* PrefixHeader_h */
