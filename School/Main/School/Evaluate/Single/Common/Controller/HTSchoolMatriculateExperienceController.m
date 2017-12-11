//
//  HTSchoolMatriculateExperienceController.m
//  School
//
//  Created by caoguochi on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateExperienceController.h"
#import "HTWorkExperienceCell.h"

@interface HTSchoolMatriculateExperienceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *workExperienceArray;

@end

@implementation HTSchoolMatriculateExperienceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self loadData];
}

- (void)loadData{
	self.workExperienceArray = [NSMutableArray array];
	NSArray *tempTitleArray = @[@{@"500强/四大实习(工作)经验" : @"bigFour"},
								@{@"外企实习(工作)经验": @"foreignCompany"},
								@{@"国企实习(工作)经验": @"enterprises"},
								@{@"私企实习(工作)经验": @"privateEnterprise"},
								@{@"相关专业项目比赛经验": @"project"},
								@{@"海外游学经验": @"study"},
								@{@"公益活动": @"publicBenefit"},
								@{@"获奖奖励": @"awards"}
								];
	[tempTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSDictionary *dic = (NSDictionary *)obj;
		WorkExperienceModel *model = [WorkExperienceModel new];
		model.title = dic.allKeys.firstObject;
		model.isSelect = NO;
		model.key = dic.allValues.firstObject;
		[self.workExperienceArray addObject:model];
	}];
	
	self.tableView.tableHeaderView.frame = CGRectMake(0, 0, HTSCREENWIDTH, 65);
	self.tableView.tableFooterView.frame = CGRectMake(0, 0, HTSCREENWIDTH, 80);
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender {
	[self.workExperienceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		WorkExperienceModel *model =  (WorkExperienceModel*)obj;
		if (model.isSelect) {
			[self.parameter setValue:@"1" forKey:model.key];
		}else{
			[self.parameter setValue:@"" forKey:model.key];
		}
	}];
    [self.delegate submit];
}
- (IBAction)previousAction:(id)sender {
    [self.delegate previous:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workExperienceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	HTWorkExperienceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HTWorkExperienceCell"];
	WorkExperienceModel *model = self.workExperienceArray[indexPath.row];
	cell.selectedImageView.highlighted = model.isSelect;
	cell.experienceLabel.text = model.title;
    return cell;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	WorkExperienceModel *model = self.workExperienceArray[indexPath.row];
	model.isSelect = !model.isSelect;
	
	[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

@implementation WorkExperienceModel

@end

