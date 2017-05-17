//
//  ViewController.m
//  JoinCocopodTest
//
//  Created by Apple on 2017/4/20.
//  Copyright © 2017年 YKYourks. All rights reserved.
//

#import "ViewController.h"
#import "CustomBtnView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomBtnView *contentView = [CustomBtnView new];
    [self.view addSubview:contentView];
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [contentView setupUITitleArr:@[@"141341",@"2fadfad",@"3fadf",@"4a",@"5",@"6",@"7",@"8",@"9",@"1fadfa",@"2",@"3",@"4",@"5",@"6",@"fadfa7",@"8",@"9",@"1",@"2",@"3",@"fadf4",@"5",@"6",@"fadfa7",@"8",@"9"]];
    
    [contentView layoutContentUI];
    
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView setSelectedBlock:^(NSInteger index) {
        NSLog(@"king");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
