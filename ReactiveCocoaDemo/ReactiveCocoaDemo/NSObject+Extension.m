//
//  NSObject+Extension.m
//  使用runtime实现字典转模型
//
//  Created by Edwin on 16/2/17.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    //    [obj setValuesForKeysWithDictionary:dict];
    NSArray *properties = [self properties];
    
    // 遍历属性数组
    for (NSString *key in properties) {
        // 判断字典中是否包含这个key
        if (dict[key] != nil) {
            // 使用 KVC 设置数值
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    
    return obj;
}
const char *propertiesKey1 = "propertiesKey";
+ (NSArray *)properties {
    //5 判断是否处存在关联对象，如果存在直接返回
    //参数一 关联到对象
    //参数二 关联的属性key
    //在oc 中 类的本质就是一个对象
    NSArray *plist = objc_getAssociatedObject(self, propertiesKey1);
    if(plist != nil)
    {
        return plist;
    }
    //1获取类的属性
    //参数是 类 和属性的计数指针  返回值是所有属性的数组
    unsigned int count = 0;//属性的计数指针
    objc_property_t *list = class_copyPropertyList([self class], &count);//返回值是所有属性的数组
    //4取得属性名数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    //3 遍历数组
    for(unsigned int i = 0; i < count; ++i)
    {
        //获取到属性
        objc_property_t pty = list[i];
        //获取属性的名称
        const char *cname = property_getName(pty);
        
        printf("%s	",cname);
        
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    printf("");
           
           NSLog(@"%@",arrayM);
           
           free(list);//2 用了class_copyPropertyList方法一定要释放
           
           //5 设置关联对象
           //参数1>关联的对象
           //参数2>关联对象的key
           //参数3>属性数值
           //属性的持有方式 retain copy assign
           objc_setAssociatedObject(self, propertiesKey1, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
           
           return arrayM.copy;
}
@end
