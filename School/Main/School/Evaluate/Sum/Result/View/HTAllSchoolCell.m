//
//  HTAllSchoolCell.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTAllSchoolCell.h"
#import "HTShareView.h"

@implementation HTAllSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shareButton.layer.borderColor = [UIColor ht_colorString:@"598912"].CGColor;
    self.resetButton.layer.borderColor = [UIColor ht_colorString:@"598912"].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//分享
- (IBAction)shareAction:(id)sender {
//    [self.delegate shareAction];
//    [HTShareView showTitle:@"" detail:@"" image:nil url:nil type:SSDKContentTypeImage];
}

//重新评估
- (IBAction)resetAction:(id)sender {
    [self.delegate resetAction];
}

@end
