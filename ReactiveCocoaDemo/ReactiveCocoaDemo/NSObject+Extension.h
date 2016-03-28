//
//  NSObject+Extension.h
//  使用runtime实现字典转模型
//
//  Created by Edwin on 16/2/17.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
/**
 *  获取模型类的属性
 *
 *  @return 返回属性数组
 */
+ (NSArray *)properties;
/**
 *  字典转模型赋值
 *
 *  @param dict 传入的字典
 *
 *  @return 返回结果
 */
+ (instancetype)newsWithDict:(NSDictionary *)dict;
@end
