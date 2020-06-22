//
//  OSBaseViewController.m
//  SiJiShows
//
//  Created by 002 on 2019/2/21.
//  Copyright © 2019 002. All rights reserved.
//

#import "OSBaseViewController.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

static NSNumber *_iPhoneX;
static NSNumber *_navBarHeight;
static NSNumber *_statusBarHeight;
static NSNumber *_tabBarHeight;
static NSNumber *_tabBarBottomHeight;

#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define MAINAFTER(delay, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

@interface OSBaseViewController ()

@end

@implementation OSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setTranslucent:YES];
    [navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (BOOL)isiPhoneX {
    if (_iPhoneX) {
        return [_iPhoneX boolValue];
    }
    return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
            CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375))) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896));
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    
    _iPhoneX = [NSNumber numberWithBool:isIPhoneX];
    return isIPhoneX;
}


- (NSInteger)navBarHeight {
    if (_navBarHeight) {
        return [_navBarHeight integerValue];
    }
    
    NSInteger height;
    if ([self isiPhoneX]) {
        height = 88;
    } else {
        height = 64;
    }
    
    _navBarHeight = [NSNumber numberWithInteger:height];
    return height;
}

- (NSInteger)tabBarHeight {
    if (_tabBarHeight) {
        return [_tabBarHeight integerValue];
    }
    
    NSInteger height;
    if ([self isiPhoneX]) {
        height = 83;
    } else {
        height = 49;
    }
    
    _tabBarHeight = [NSNumber numberWithInteger:height];
    return height;
}

- (NSInteger)statusBarHeight {
    if (_statusBarHeight) {
        return [_statusBarHeight integerValue];
    }
    
    NSInteger height;
    if ([self isiPhoneX]) {
        height = 44;
    } else {
        height = 20;
    }
    
    _statusBarHeight = [NSNumber numberWithInteger:height];
    return height;
}

- (NSInteger)tabBarBottomHeight {
    if (_tabBarBottomHeight) {
        return [_tabBarBottomHeight integerValue];
    }
    
    NSInteger height;
    if ([self isiPhoneX]) {
        height = 34;
    } else {
        height = 0;
    }
    
    _tabBarBottomHeight = [NSNumber numberWithInteger:height];
    return height;
}

- (void)popToRootViewController {
    UIViewController *viewController = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:viewController animated:YES];
}

- (void)popToRootViewController:(int)delay {
    WeakSelf(self);
    
    MAINAFTER(delay, ^{
        [weakself popToRootViewController];
    });
}

#pragma mark -  颜色转图片
- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
