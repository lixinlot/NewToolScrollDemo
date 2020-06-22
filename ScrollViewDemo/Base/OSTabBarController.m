//
//  OSTabBarController.m
//  SiJiShows
//
//  Created by 002 on 2019/2/21.
//  Copyright © 2019 002. All rights reserved.
//

#import "OSTabBarController.h"
#import "MainHomeViewController.h"
#import "MainHomeViewController2.h"
#import "MainHomeViewController3.h"
#import "MainHomeViewController4.h"
#import "OSBaseNavigationController.h"

@interface OSTabBarController ()<UITabBarDelegate>

@end

@implementation OSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    MainHomeViewController *firstVc = [[MainHomeViewController alloc] init];
    [self addChildVc:firstVc title:@"首页" image:@"tab_shouye_unsecect" selectedImage:@"tab_shouye_secect"];

    MainHomeViewController2 *secondVc = [[MainHomeViewController2 alloc] init];
    [self addChildVc:secondVc title:@"视频" image:@"tab_faxian_unselect" selectedImage:@"tab_faxian_select"];

    MainHomeViewController3 *thirdVc = [[MainHomeViewController3 alloc] init];
    [self addChildVc:thirdVc title:@"购物车" image:@"tab_gouwuche_unselect" selectedImage:@"tab_gouwuche_select"];

    MainHomeViewController4 *fourthVc = [[MainHomeViewController4 alloc] init];
    [self addChildVc:fourthVc title:@"我的" image:@"tab_wode_unselect" selectedImage:@"tab_wode_select"];

    [UITabBar appearance].translucent = NO;

}

- (void)addChildVc:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    childVC.title = title;//同时设置tabBar和navgationBar的文字
    //设置控制器的图片

    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    //设置导航控制器
    OSBaseNavigationController *nav = [[OSBaseNavigationController alloc] initWithRootViewController:childVC];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor} forState:UIControlStateSelected];
    self.tabBar.tintColor = UIColor.purpleColor;
    
    //添加为子控制器
    [self addChildViewController:nav];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)currentNavigationController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}


+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [(UITabBarController *)rootVC selectedViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = rootVC;
        //        return rootVC;
    } else {
        // 根视图为非导航类
        currentVC = rootVC.navigationController;
    }
    
    return currentVC;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    for (int i = 0; i < tabBar.items.count; i++) {
        UITabBarItem *subItem = tabBar.items[i];
        if (![item.title isEqualToString:@"VIP"]) {
            if ([subItem.title isEqualToString:item.title]) {

            }
        }
    }
}

@end
