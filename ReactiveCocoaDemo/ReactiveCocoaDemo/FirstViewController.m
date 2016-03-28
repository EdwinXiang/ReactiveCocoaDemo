//
//  FirstViewController.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick:(UIButton *)btn {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@1];
    }
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
