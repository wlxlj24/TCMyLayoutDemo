//
//  ViewController.m
//  TCMyLayoutDemo
//
//  Created by TailC on 16/6/28.
//  Copyright © 2016年 TailC. All rights reserved.
//

#import "ViewController.h"

static NSString * const cellId = @"cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,readwrite,strong) NSArray *dataArr;
@property (nonatomic,readwrite,strong) NSArray *sectionArr;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//获取plist文件
	NSString *path  = [[NSBundle mainBundle] pathForResource:@"ChaptList" ofType:@"plist"];
	self.dataArr = [NSArray arrayWithContentsOfFile:path];
	
	self.sectionArr = self.dataArr;
	
	[self setupTableView];
	
	
}

/** 初始化tableView  */
-(void)setupTableView{
	
	self.tableView.tableFooterView=[[UITableViewHeaderFooterView alloc]initWithFrame:CGRectZero];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
	
}

#pragma mark <UITableViewDataSource><UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return self.sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSArray *row = self.sectionArr[section];
	return row.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
	NSArray *section = self.sectionArr[indexPath.section];
	NSDictionary *row = section[indexPath.row];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@",[row objectForKey:@"title"]];
	NSString *name = [row objectForKey:@"viewControllerName"];
	name = [name substringFromIndex:14];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",name];
	
	return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSArray *section = self.sectionArr[indexPath.section];
	NSDictionary *row = section[indexPath.row];
	NSString *vcName = [row objectForKey:@"viewControllerName"];
	
	Class vc = NSClassFromString(vcName);
	
	UIViewController *aVC = [vc new];
	aVC.view.backgroundColor = [UIColor whiteColor];
	
	if (vc) {
		[self.navigationController pushViewController:aVC animated:YES];
	}
	
}


@end
