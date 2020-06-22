//
//  OSBaseNavigationController.m
//  SiJiShows
//
//  Created by 002 on 2019/2/21.
//  Copyright © 2019 002. All rights reserved.
//

#import "OSBaseNavigationController.h"
#import "OSBaseViewController.h"

@interface OSBaseNavigationController ()

@property (assign, nonatomic) BOOL isSwitching;

@end

@implementation OSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
    [self setupBarButtonItem];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

- (void)setupBarButtonItem {
    UIBarButtonItem *button = [UIBarButtonItem appearance];
    
    [button setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateNormal];
    [button setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateHighlighted];
    [button setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:13.0]} forState:UIControlStateDisabled];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:20 weight:(UIFontWeightMedium)]}];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated) {
        if (self.isSwitching) {
            return; // 1. 如果是动画，并且正在切换，直接忽略
        }
        self.isSwitching = YES; // 2. 否则修改状态
    }

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    // 如果现在push的不是栈顶控制器，那么就隐藏tabbar工具条
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //拦截push操作，设置导航栏的左上角和右上角按钮
        UIImage *image = [[UIImage imageNamed:@"nav_back_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _leftBarBackButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(actionNavigationBack)];
        
        viewController.navigationItem.leftBarButtonItem = _leftBarBackButton;
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && !viewController.navigationItem.hidesBackButton){
        self.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    self.isSwitching = NO; // 3. 还原状态
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"willShowViewController");
    if (![viewController isKindOfClass:[OSBaseViewController class]]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)actionNavigationBack {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer ) {
        if (self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.firstObject ){
            return NO;
        }
    }
    return YES;
}

@end
