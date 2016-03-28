//
//  City.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "City.h"

@implementation City
-(NSString *)description{
    return [NSString stringWithFormat:@"\n城市名:%@\n编码:%@",self.cityName,self.number];
}
@end
