//
//  ViewController.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "ViewController.h"
#import "refreshVC.h"
#import "PGTestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)nextPage:(id)sender {
    
    refreshVC * vc = [[refreshVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController pushViewController:vc animated:YES];

    [self.navigationController pushViewController:vc animated:YES];

    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
