//
//  ViewController.m
//  RYApp
//
//  Created by 连杰 on 2018/1/27.
//  Copyright © 2018年 连杰. All rights reserved.
//

#import "ViewController.h"
#import "RYVController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];

    UIButton *clikBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 200, 200)];
    clikBtn.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:clikBtn];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
