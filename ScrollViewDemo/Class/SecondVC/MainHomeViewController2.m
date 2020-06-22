//
//  MainHomeViewController2.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/27.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "MainHomeViewController2.h"
#import "JJOptionView.h"
#import "SecondViewController.h"
#import "JJSearchOptionView.h"

@interface MainHomeViewController2 ()<JJOptionViewDelegate>

@end

@implementation MainHomeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 70, 150, 30);
    [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"进入comment页" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    JJOptionView *view1 = [[JJOptionView alloc] initWithFrame:CGRectMake(50, 130, 130, 40)];
    view1.dataSource = @[@"1",@"2",@"3",@"4",@"5"];
    view1.delegate = self;
    view1.titleColor = [UIColor blackColor];
    view1.titleFontSize = 12;
    view1.titleBjColor = [UIColor purpleColor];
    view1.subTitleBjColor = [UIColor blueColor];
    view1.subTitleTextColor = [UIColor blackColor];
    view1.subTitleFont = 12;
    [self.view addSubview:view1];
    
    JJOptionView *view = [[JJOptionView alloc] initWithFrame:CGRectMake(50+10+130, 130, 130, 40)];
    view.dataSource = @[@"111",@"222",@"333",@"444",@"555"];
    view.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
        NSLog(@"%@",optionView);
        NSLog(@"%ld",selectedIndex);
    };
    [self.view addSubview:view];
    
    JJSearchOptionView *view2 = [[JJSearchOptionView alloc] initWithFrame:CGRectMake(50, 130+40+10, 200, 40)];
    view2.dataSource = @[@"1",@"22",@"213",@"432",@"462",@"872",@"298",@"245",@"20",@"20567"];
    view2.selectedBlock = ^(JJSearchOptionView * _Nonnull optionView, NSString * _Nonnull selctedString, NSInteger selectedIndex) {
        
    };
    [self.view addSubview:view2];
    
    JJSearchOptionView *view3 = [[JJSearchOptionView alloc] initWithFrame:CGRectMake(50, 130+40+10+40+10, 200, 40)];
    view3.dataSource = @[@"1",@"22",@"213",@"432",@"462",@"872",@"298",@"245",@"20",@"20567"];
    view3.selectedBlock = ^(JJSearchOptionView * _Nonnull optionView, NSString * _Nonnull selctedString, NSInteger selectedIndex) {
        
    };
    [self.view addSubview:view3];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

}

- (void)next {
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex {
    NSLog(@"%@",optionView);
    NSLog(@"%ld",selectedIndex);
}



@end
