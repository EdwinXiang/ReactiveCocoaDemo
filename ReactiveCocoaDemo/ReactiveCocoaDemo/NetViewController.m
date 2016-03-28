//
//  NetViewController.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "NetViewController.h"
#import "requestViewModel.h"
#import "Book.h"
#import <MBProgressHUD.h>
@interface NetViewController ()

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) requestViewModel *requestViewModel;
@end

@implementation NetViewController

-(requestViewModel *)requestViewModel {
    if (!_requestViewModel) {
        _requestViewModel = [[requestViewModel alloc]init];
    }
    return _requestViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.dataSource = self.requestViewModel;
    [self.view addSubview:tableView];
    
    //
    RACSignal *requestSingal = [self.requestViewModel.requestCommand execute:nil];
    
    //获取请求数据
    [requestSingal subscribeNext:^(NSArray *x) {
        self.requestViewModel.models = x;
        [self.tableView reloadData];
    }];
    
  MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeCustomView;
    hub.labelText = @"正在加载中...";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hub hide:YES];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
