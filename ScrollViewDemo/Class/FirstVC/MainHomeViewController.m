//
//  MainHomeViewController.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/27.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "MainHomeViewController.h"
#import "GoodDetailViewController.h"
#import "MBProgressHUD+Extension.h"
#import "ProgressSliderView.h"

@interface MainHomeViewController ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIButton *coverBtn;

@end

@implementation MainHomeViewController

#pragma pack(1)
struct StructOne {
    char a;         //1字节
    double b;       //8字节
    int c;          //4字节
    short d;        //2字节
} MyStruct1;

struct StructTwo {
    double b;       //8字节
    char a;         //1字节
    short d;        //2字节
    int c;         //4字节
} MyStruct2;
#pragma pack()


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 100, 50);
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"commentPop" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"MyStruct1:%ld",sizeof(MyStruct1));
    NSLog(@"MyStruct2:%ld",sizeof(MyStruct2));
    
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100+100+50, 100, 100)];
    self.imageV.backgroundColor = UIColor.yellowColor;
    self.imageV.userInteractionEnabled = YES;
    [self.view addSubview:self.imageV];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageV addGestureRecognizer:longTap];
    
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.frame = CGRectMake(0, 0, 80, 80);
    self.coverBtn.layer.cornerRadius = 40;
    self.coverBtn.backgroundColor = UIColor.clearColor;
    self.coverBtn.userInteractionEnabled = NO;
    [self.coverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imageV addSubview:self.coverBtn];
    
    
    ProgressSliderView *slider = [[ProgressSliderView alloc] initWithFrame:CGRectMake(20, 250+100+30, [UIScreen mainScreen].bounds.size.width-80, 75)];
    slider.score = 5;
    [self.view addSubview:slider];
    
}

- (void)longPress:(UILongPressGestureRecognizer *)tap {
    
//    [MBProgressHUD showWithText:@"长按了" toView:self.view];
    self.coverBtn.userInteractionEnabled = YES;
    self.coverBtn.backgroundColor = UIColor.lightGrayColor;
    [UIView animateWithDuration:0.1 animations:^{
        self.coverBtn.frame = CGRectMake(0, 0, 100, 100);
        self.coverBtn.layer.cornerRadius = 50;
//        self.coverBtn.backgroundColor = UIColor.grayColor;
    } completion:^(BOOL finished) {
        [self.coverBtn setTitle:@"收藏" forState:UIControlStateNormal];
    }];
}

- (void)coverClick {
    self.coverBtn.frame = CGRectMake(0, 0, 80, 80);
    self.coverBtn.layer.cornerRadius = 40;
    self.coverBtn.backgroundColor = UIColor.clearColor;
    self.coverBtn.userInteractionEnabled = NO;
    [self.coverBtn setTitle:@"" forState:UIControlStateNormal];
}

- (void)click {
    GoodDetailViewController *vc = [[GoodDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
