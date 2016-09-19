//
//  RootViewController.m
//  KVOByValue
//
//  Created by 张丁豪 on 16/9/19.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "RootViewController.h"
#import "SecViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.title = @"ValueBetweenTwoViews";
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 180, [UIScreen mainScreen].bounds.size.width - 100, 46)];
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.textColor = [UIColor redColor];
    [self.view addSubview:self.label];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 400, [UIScreen mainScreen].bounds.size.width - 100, 46)];
    [btn setTitle:@"KVOByValue" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    btn.layer.cornerRadius = 6;
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClicked{
    
    SecViewController *sec = [[SecViewController alloc]init];
    // 让self成为观察者, vc2成为被观察者, 观察passingText的变化 [self观察vc2中passingText属性的变化]
    [sec addObserver:self forKeyPath:@"passingText" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self presentViewController:sec animated:YES completion:nil];
}

// 必须实现这个方法, 这个是用来回调取值的!
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    SecViewController *sec = (SecViewController *)object;
    if ([keyPath isEqualToString:@"passingText"]) {
        //取出改变后的新值.
        self.label.text = change[@"new"];
    }
    NSLog(@"值改变---old:%@---new:%@",change[@"old"],change[@"new"]);
    // 注意: 一定要在使用完观察者之后要注销观察者 否则会crash!!!
    [sec removeObserver:self forKeyPath:@"passingText"];
}



@end
