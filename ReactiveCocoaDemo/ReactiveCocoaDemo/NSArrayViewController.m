//
//  NSArrayViewController.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "NSArrayViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#define PATH @"/Users/WeiXiang/Desktop/ReactiveCocoaDemo/ReactiveCocoaDemo/city.json"
#import "City.h"
@interface NSArrayViewController (){
    NSMutableArray *_flags;
}

@end

@implementation NSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self subscribeArray];
//    [self dictonaryTurnToModel];
}
/**
 *  遍历数组和字典
 */
-(void)subscribeArray {
   
    
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"=====%@",x);
    }];
    
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ = %@",key,value);
        
    }];
}
/**
 *  字典转模型
 */
-(void)dictonaryTurnToModel {
    // 3.字典转模型
//    // 3.1 OC写法
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray *items = [NSMutableArray array];
//    
//    for (NSDictionary *dict in dictArr) {
//        FlagItem *item = [FlagItem flagWithDict:dict];
//        [items addObject:item];
//    }
    // 3.2 RAC写法
    
    NSString *content = [NSString stringWithContentsOfFile:PATH encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableArray *flags = [NSMutableArray array];
    
    _flags = flags;
    
    // rac_sequence注意点：调用subscribeNext，并不会马上执行nextBlock，而是会等一会。
    [dic.rac_sequence.signal subscribeNext:^(id x) {
        // 运用RAC遍历字典，x：字典
         RACTupleUnpack(NSString *key,NSArray *array) = x;
//        NSLog(@"字典转模型RAC写法:key = %@,value = %@",key,array);
        [array.rac_sequence.signal subscribeNext:^(id x) {
//            NSLog(@"=====key = %@",x);
        }];
//        FlagItem *item = [FlagItem flagWithDict:x];
        
//        [flags addObject:item];
        
    }];
    
    NSLog(@"%@",  NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    
    // 3.3 RAC高级写法:
//    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
     NSArray *arr = [dic objectForKey:@"城市代码"];
//    NSArray *dictArr1 = [NSArray arrayWithContentsOfFile:PATH];
    // map:映射的意思，目的：把原始值value映射成一个新值
    // array: 把集合转换成数组
    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
    NSArray *flags1 = [[arr.rac_sequence map:^id(id value) {
        
//        return [FlagItem flagWithDict:value];
//        NSLog(@"value === %@",value);
        NSArray *arr1 = [value objectForKey:@"市"];
        [arr1.rac_sequence.signal subscribeNext:^(id x) {

            NSLog(@"key = %@",x);
            City *cityModel = [[City alloc]init];
            cityModel.cityName = x[@"市名"];
            cityModel.number = x[@"编码"];
            [flags addObject:cityModel];
            NSLog(@"name = %@,number = %@",cityModel.cityName,cityModel.number);
        }];
        return value;
        
    }] array];
    
//    NSLog(@"flags = %lu",(unsigned long)flags.count);
//    for (City *city in flags) {
//        NSLog(@"name = %@",city.cityName);
//    }
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
