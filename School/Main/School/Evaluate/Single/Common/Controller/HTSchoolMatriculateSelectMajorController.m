//
//  HTSchoolMatriculateSelectMajorController.m
//  School
//
//  Created by Charles Cao on 2017/12/11.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTSchoolMatriculateSelectMajorController.h"
#import "HTChooseMajorCell.h"


@interface HTSchoolMatriculateSelectMajorController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HTSchoolMatriculateSelectMajorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMajorArray:(NSArray<HTSchoolProfessionalModel *> *)majorArray{
	_majorArray = majorArray;
	[self.tableView reloadData];
}

#pragma mark -UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.majorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTChooseMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTChooseMajorCell"];
	HTSchoolProfessionalModel *selectedModel = self.majorArray[indexPath.row];
	cell.textLabel.textColor = [UIColor ht_colorString:@"525252"];
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = selectedModel.name;
	cell.accessoryType = selectedModel.isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	HTSchoolProfessionalModel *selectedModel = self.majorArray[indexPath.row];
	[self.delegate selectedMajor:selectedModel];
	[self.navigationController popViewControllerAnimated:YES];
	
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
