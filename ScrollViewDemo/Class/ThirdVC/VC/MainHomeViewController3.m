//
//  MainHomeViewController3.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/27.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "MainHomeViewController3.h"
#import "ThirdLabelViewController.h"

@interface MainHomeViewController3 ()

@end

@implementation MainHomeViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 100, 50);
    btn.backgroundColor = UIColor.yellowColor;
    [btn setTitle:@"标签世界" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click {
    ThirdLabelViewController *vc = [[ThirdLabelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];    
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
