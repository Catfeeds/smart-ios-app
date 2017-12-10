//
//  HTConditionCell.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTConditionCell.h"

@implementation HTConditionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setResult:(HTCompareResult *)result{
    _result = result;
    UIColor *color;
    if (result.type == 1){
        self.conditionLabel.text = @"优势";
        color = [UIColor ht_colorString:@"7BC97A"];
    }else{
        self.conditionLabel.text = @"劣势";
        color = [UIColor ht_colorString:@"ec575a"];
    }
    self.conditionLabel.textColor = color;
    self.conditionLabel.layer.borderColor = color.CGColor;
    
    NSString *compareName = @"";
    NSString *compareScore  = @"";
    switch (result.scoreType) {
        case HTCompareResultGpa:
            compareName = @"GPA";
            compareScore = result.score;
            break;
        
        case HTCompareResultGMAT:
            compareName = @"GMAT";
            compareScore = result.score;
            break;
        case HTCompareResultToefl:
            compareName = @"toefl";
            compareScore = result.score;
            break;
        case HTCompareResultSchool:
            compareName = @"院校背景";
            compareScore = result.name;
            break;
        case HTCompareResultWork:
            compareName = @"个人经历";
            compareScore = result.name;
            break;
        default:
            break;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@:%@,打败了%@位测评者",compareName,compareScore,@(result.num)];
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [resultStr addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"969696"] range:NSMakeRange(compareName.length+1, resultStr.length - (compareName.length + 1))];
    [resultStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(compareName.length + compareScore.length + 5, @(result.num).stringValue.length)];
    
    self.descriptionLabel.attributedText = resultStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
