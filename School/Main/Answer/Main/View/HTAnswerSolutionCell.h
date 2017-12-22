//
//  HTAnswerSolutionCell.h
//  School
//
//  Created by hublot on 2017/8/29.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTAnswerSolutionCell : UITableViewCell

@property (nonatomic, strong) void(^reloadHeightBlock)(void);

@property (nonatomic, copy) void(^replycommentBlock)(HTAnswerSolutionModel *solutionModel, HTAnswerReplyModel *answerReplyModel);

@end
