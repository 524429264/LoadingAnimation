//
//  ViewController.m
//  LoadingAnimation
//
//  Created by 田耀辉 on 2018/4/7.
//  Copyright © 2018年 田耀辉. All rights reserved.
//

#import "ViewController.h"
#import "LoadingAnimation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

//点击开始动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[LoadingAnimation shareAnimation] startAnimatingWithTitle:@"加载中。。。"];
}

//结束动画
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[LoadingAnimation shareAnimation] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
