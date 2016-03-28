//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "Accout.h"
@interface LoginViewModel : NSObject

@property (nonatomic,strong)Accout *accout;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;
@end
