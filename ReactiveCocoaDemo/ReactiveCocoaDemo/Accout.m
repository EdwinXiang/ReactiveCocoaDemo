//
//  Accout.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "Accout.h"

@implementation Accout

-(NSString *)description{
    
    return [NSString stringWithFormat:@"账号：%@,密码:%@",self.accout,self.pwd];
}
@end
