//
//  OSBaseViewController.h
//  SiJiShows
//
//  Created by 002 on 2019/2/21.
//  Copyright © 2019 002. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface OSBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isInteractivePopGestureRecognizerDelegate;

/**
是否是iPhoneX
*/
@property (nonatomic, readonly) BOOL isiPhoneX;

/**
导航栏高度，包含状态栏
*/
@property (nonatomic, readonly) NSInteger navBarHeight;

/**
状态栏高度
*/
@property (nonatomic, readonly) NSInteger statusBarHeight;

/**
Tab栏的高度
*/
@property (nonatomic, readonly) NSInteger tabBarHeight;

/**
Tab底部的高度
*/
@property (nonatomic, readonly) NSInteger tabBarBottomHeight;

- (void)popToRootViewController;

- (void)popToRootViewController:(int)delay;

/** 显示HUD */
- (void)showProgressHUD;

- (void)showNullProgressHUD;

/**
 隐藏HUD
 */
- (void)hideProgressHUD;

@end


