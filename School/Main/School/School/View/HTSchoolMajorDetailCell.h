//
//  HTSchoolMajorDetailCell.h
//  School
//
//  Created by hublot on 2017/9/21.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSchoolModel.h"

@interface HTSchoolMajorDetailCell : UICollectionViewCell

+ (CGFloat)collectionItemHeight;

+ (CGFloat)cellFontPointSize;

- (void)setModel:(HTSchoolProfessionalSubModel *)model row:(NSInteger)row;

@end
