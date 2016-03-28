//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import "NSArrayViewController.h"
#import "LoginViewController.h"
#import "NetViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  cell视图
 */
@property (strong, nonatomic)  UITableView *tableView;
/**
 *  数据源
 */
@property (nonatomic,strong) NSArray *dataArr;
@end

static  NSString *const cellID = @"cellIndentifier";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.title = @"Reactive Cocoa";
    self.dataArr = @[@"传值",@"数组、字典的使用",@"登录界面",@"网络请求",@"监听事件代替KVO"];
    

}

#pragma  UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
#pragma  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TwoViewController *two = [[TwoViewController alloc]init];
        [self.navigationController pushViewController:two animated:YES];
    } else if (indexPath.row == 1) {
        NSArrayViewController *array = [[NSArrayViewController alloc]init];
        [self.navigationController pushViewController:array animated:YES];
    } else if (indexPath.row == 2) {
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
    } else if (indexPath.row == 3) {
        NetViewController *netVc = [[NetViewController alloc]init];
        [self.navigationController pushViewController:netVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
