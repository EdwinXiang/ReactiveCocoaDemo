//
//  requestViewModel.m
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "requestViewModel.h"
#import "Book.h"
@implementation requestViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

-(void)initialBind {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            
            // 发送请求
            [[AFHTTPSessionManager manager]GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //请求成功
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error = %@",[error localizedDescription]);
            }];
            return nil;
        }];
        
        
        
        
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                
                Book *book =[Book newsWithDict:value];
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:book];
                NSLog(@"title = %@,subtitle = %@,summary = %@",book.title,book.subtitle,book.summary);
                return array;
            }] array];
            
            return modelArr;
        }];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    Book *book = self.models[indexPath.row];
    NSLog(@"subtitle = %@,title = %@",book.subtitle,book.title);
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    return cell;
}
@end
