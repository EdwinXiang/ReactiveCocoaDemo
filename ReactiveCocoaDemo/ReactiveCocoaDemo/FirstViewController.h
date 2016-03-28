//
//  FirstViewController.h
//  ReactiveCocoaDemo
//
//  Created by Edwin on 16/3/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface FirstViewController : UIViewController
//代理
@property (nonatomic,strong) RACSubject *delegateSignal;
@end
