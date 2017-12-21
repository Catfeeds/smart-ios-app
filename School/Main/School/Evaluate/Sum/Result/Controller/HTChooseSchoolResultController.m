//
//  HTChooseSchoolResultController.m
//  School
//
//  Created by Charles Cao on 2017/12/7.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTChooseSchoolResultController.h"
#import "HTConditionCell.h"
#import "HTAllSchoolCell.h"
#import "HTChooseSchoolCell.h"
#import "HTChooseSchoolEvaluationResultModel.h"
#import "HTSchoolController.h"
#import "HTChooseSchoolEvaluationController.h"
#import "RTRootNavigationController.h"
#import "HTShareView.h"

#define HEADER @"header"

@interface HTChooseSchoolResultController ()<UITableViewDelegate, UITableViewDataSource,HTAllSchoolCellDelegate>


@end


@implementation HTChooseSchoolResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    NSString *nickname = HTPlaceholderString(self.resultModel.user.nickname, self.resultModel.user.userName);
    [self layoutHeaderView:nickname score:self.resultModel.data.score];
    [self.tableView reloadData];
    
}

- (void)layoutHeaderView:(NSString *)userName score:(NSString *)score {
	self.tableHeaderView.layer.borderWidth 	 = 7;
	self.tableHeaderView.layer.borderColor 	 = [UIColor ht_colorString:@"8cb93e"].CGColor;
	self.tableHeaderView.layer.cornerRadius	 = 5;
	self.tableHeaderView.layer.masksToBounds = YES;
	
	NSMutableAttributedString *userNameAttributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@,%@",userName,@"你的得分"]];
	[userNameAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"8cb93e"] range:NSMakeRange(0, userName.length)];
	[userNameAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor ht_colorString:@"484848"] range:NSMakeRange(userName.length, userNameAttributeString.length - userName.length)];

	self.userNameLabel.attributedText = userNameAttributeString;
	[self.scoreButton setTitle:score forState:UIControlStateNormal];
    
    [self.tableView registerClass:[HTTabelSectionHeaderView class] forHeaderFooterViewReuseIdentifier:HEADER];
    
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger schoolNum = self.resultModel.data.res.count;
    return schoolNum > 0 ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.resultModel.score.allScores.count;
    }else if (section == 1){
        return 1;
    }else{
        return self.resultModel.data.res.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HTConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTConditionCell"];
        cell.result = self.resultModel.score.allScores[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        HTAllSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAllSchoolCell"];
        NSString *allSchool = [NSString stringWithFormat:@"%ld+",self.resultModel.data.res.count];
        cell.schoolNumberlabel.text = allSchool;
        cell.delegate = self;
        return cell;
    }else{
        HTChooseSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTChooseSchoolCell"];
        cell.school = self.resultModel.data.res[indexPath.row];
        return cell;
    }
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 || section == 2 ?  28 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 2) {
        HTTabelSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADER];
        
        if (!headerView) {
            headerView = [[HTTabelSectionHeaderView alloc]initWithReuseIdentifier:HEADER];
        }
        headerView.sectionTitleLabel.text = section == 0 ? @"背景条件分析" : @"以下是你的选校报告";
        return headerView;
    }else{
        return  nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        HTSchoolController *schoolDetailController = [[HTSchoolController alloc] init];
        HTResultSchool *school = self.resultModel.data.res[indexPath.row];
        schoolDetailController.schoolIdString = school.ID;
        [self.navigationController pushViewController:schoolDetailController animated:true];
    }
}

#pragma mark - HTAllSchoolCellDelegate
- (void)shareAction{
	UIImage *shotScreentImage = [UIImage ht_shotScreen];
	[HTShareView showTitle:@"选校测评" detail:@"我在雷哥留学的选校测评结果" image:shotScreentImage url:@"http://www.gmatonline.cn" type:SSDKContentTypeImage];
}

- (void)resetAction{
    HTChooseSchoolEvaluationController *gradeController = STORYBOARD_VIEWCONTROLLER(@"Home", @"HTChooseSchoolEvaluationController");
    NSArray *controllerArray = self.rt_navigationController.rt_viewControllers;
    NSMutableArray *tempVCArray =  [NSMutableArray arrayWithArray:[controllerArray subarrayWithRange:NSMakeRange(0, controllerArray.count - 2)]];
    [tempVCArray addObject:gradeController];
    [self.rt_navigationController setViewControllers:tempVCArray animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

@implementation HTTabelSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, HTSCREENWIDTH, 29);
        UIImageView *imageView =  [[UIImageView alloc]initWithFrame:self.frame];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:@"tu-2"];
        [self addSubview:imageView];
        
        self.sectionTitleLabel = [[UILabel alloc]initWithFrame:self.frame];
        self.sectionTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.sectionTitleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:self.sectionTitleLabel];
    }
    return self;
}

@end
