//
//  GoodDetailViewController.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/27.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "CustomHandelTool.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeigth [UIScreen mainScreen].bounds.size.height

@interface GoodDetailViewController ()

@property (nonatomic,strong) UIView *commentView;

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"commentPop";
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, screenWidth, 150)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
    NSString *str = [CustomHandelTool pricePoint:@"11.39"];
    NSString *str1 = [CustomHandelTool pricePoint:@"11.00"];
    NSString *str2 = [CustomHandelTool pricePoint:@"11.390"];
    NSString *newStr = [CustomHandelTool newPricePoint:@"11.39"];
    NSString *newStr1 = [CustomHandelTool newPricePoint:@"11.00"];
    NSString *newStr2 = [CustomHandelTool newPricePoint:@"11.390"];
    NSMutableAttributedString *mulStr = [CustomHandelTool priceShowPointWithString:@"¥12.20" moneyFontSize:12 pointFontSize:12];
    NSMutableAttributedString *mulStr1 = [CustomHandelTool priceShowPointWithString:@"¥99.00" moneyFontSize:12 pointFontSize:12];
    NSArray *arr = @[str,str1,str2,newStr,newStr1,newStr2,mulStr,mulStr1];
    for (int i = 0; i < arr.count; i++) {
        NSInteger row = i/4;
        NSInteger los = i%4;
        NSInteger space = 10;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(space+los*((screenWidth-50)/4+space), row*(20+space), (screenWidth-50)/4, 20)];
        label.font = [UIFont systemFontOfSize:16];
        if (i <= 5) {
            label.text = arr[i];
        }else {
            label.attributedText = arr[i];
        }
        label.textColor = UIColor.blackColor;
        label.layer.borderColor = UIColor.greenColor.CGColor;
        label.layer.borderWidth = 1;
        [view1 addSubview:label];
    }
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBarHeight+150, screenWidth, 150)];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBarHeight+150+150, screenWidth, 150)];
    view3.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view3];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((screenWidth-100)/2, 50, 100, 50);
    btn.backgroundColor = UIColor.systemPinkColor;
    [btn setTitle:@"commentPopView" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeigth-50, screenWidth, 50)];
    view4.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view4];
}

- (void)click {
    self.commentView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.commentView.frame = CGRectMake(0, self.navBarHeight, screenWidth, 150*3);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)edgClick:(UIScreenEdgePanGestureRecognizer *)ges {
    
    // 让view跟着手指去移动
    // 取到手势在当前控制器视图中识别的位置
    CGPoint p = [ges locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(p));
    CGRect frame = self.commentView.frame;
    // 更改View的x值. 手指的位置 - 屏幕宽度
    frame.origin.x = p.x ;//- [UIScreen mainScreen].bounds.size.width;
    // 重新设置上去
    self.commentView.frame = frame;
    
    if (ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateCancelled) {
        // 判断当前广告视图在屏幕上显示是否超过一半
        if (CGRectContainsPoint(self.view.frame, self.commentView.center)) {
            // 如果超过,那么完全展示出来
            frame.origin.x = 0;
        }else{
            // 如果没有,隐藏
            frame.origin.x = screenWidth;
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.commentView.frame = frame;
        }];
    }
    
}

- (void)popClick {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.commentView.frame = CGRectMake(screenWidth, self.navBarHeight, screenWidth, 150*3);
    } completion:^(BOOL finished) {
        self.commentView.hidden = YES;
    }];
    
}

- (UIView *)commentView {
    if (!_commentView) {
        _commentView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, self.navBarHeight, screenWidth, 150*3)];
        _commentView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_commentView];
        _commentView.hidden = YES;
        
        UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgClick:)];
        ges.edges = UIRectEdgeLeft;
        // 指定左边缘滑动
//        UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(edgClick:)];
//        ges.direction = UISwipeGestureRecognizerDirectionLeft;
//        [_commentView addGestureRecognizer:ges];
        
        [_commentView addGestureRecognizer:ges];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 20, 20, 20);
        [btn setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
        [_commentView addSubview:btn];
    }
    return _commentView;
}

@end
