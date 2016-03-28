//
//  LoginViewModel.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "LoginViewModel.h"
#import <MBProgressHUD.h>
@implementation LoginViewModel

-(Accout *)accout{
    if (!_accout) {
        _accout = [[Accout alloc]init];
    }
    return _accout;
}
-(instancetype)init{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}
/**
 *  初始化绑定
 */
-(void)initialBind{
    //监听属性值改变
    
    // 监听账号的属性值改变，把他们聚合成一个信号。
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.accout, accout),RACObserve(self.accout, pwd)] reduce:^id(NSString *account,NSString *pwd){
        NSLog(@"z账号：%@,密码:%@",account,pwd);
        return @(account.length && pwd.length);
        
    }];
    
    //处理登陆业务逻辑
    _LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"点击了登录");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"登录成功"];
                
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    //监听登陆产生的数据
    [_LoginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:@"登录成功"]) {
            NSLog(@"登录成功");
        }
    }];
    
    //监听登录状态
    [[_LoginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            //正在登陆
//            MBProgressHUD
            NSLog(@"正在登陆....");
        }else {
            NSLog(@"登陆成功");
        }
    }];
}
@end
