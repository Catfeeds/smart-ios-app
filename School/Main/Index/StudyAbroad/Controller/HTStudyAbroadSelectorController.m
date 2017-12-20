//
//  HTStudyAbroadSelectorController.m
//  School
//
//  Created by Charles Cao on 2017/12/20.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTStudyAbroadSelectorController.h"

@interface HTStudyAbroadSelectorController ()

@end

@implementation HTStudyAbroadSelectorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadDataModels:(NSArray *)models selecetdModelId:(NSString *)selectedModelId{
	
	self.models = models;
	self.selectedModelId = selectedModelId;
	[self.tableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	HTStudyAbroadSelectorModel *selectetorModel = self.models[indexPath.row];
	cell.textLabel.text = selectetorModel.name;
	cell.textLabel.textColor = [UIColor ht_colorString:@"333333"];
	cell.textLabel.font = [UIFont systemFontOfSize:17];
	cell.accessoryType = [self.selectedModelId isEqualToString:selectetorModel.ID] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	return cell;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate selectedModel:self.models[indexPath.row]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
