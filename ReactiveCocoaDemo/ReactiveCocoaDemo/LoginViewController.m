//
//  LoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
@interface LoginViewController ()

@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController

-(LoginViewModel *)loginViewModel {
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self bindModel];
}


// 视图模型绑定
- (void)bindModel
{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.accout, accout) = _userName.rac_textSignal;
    RAC(self.loginViewModel.accout, pwd) = _password.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
    }];
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
