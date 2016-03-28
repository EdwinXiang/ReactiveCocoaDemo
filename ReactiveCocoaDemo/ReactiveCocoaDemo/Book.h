//
//  Book.h
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *summary;

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
