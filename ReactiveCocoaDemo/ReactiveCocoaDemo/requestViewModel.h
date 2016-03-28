//
//  requestViewModel.h
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/28.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
#import <AFNetworking.h>
@interface requestViewModel : NSObject<UITableViewDataSource>

@property (nonatomic,strong,readonly) RACCommand *requestCommand;

@property (nonatomic,strong) NSArray *models;
@end
