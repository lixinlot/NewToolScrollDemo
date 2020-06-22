//
//  MBProgressHUD+Extension.m
//  SiJiShows
//
//  Created by 002 on 2019/2/22.
//  Copyright © 2019 002. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)
+ (instancetype)showWithText:(NSString *)text toView:(UIView *)view {
    return [self showWithText:text toView:view afterDelay:3];
}

+ (instancetype)showWithText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.9f];
    hud.bezelView.layer.shadowColor = [UIColor blackColor].CGColor;
    hud.bezelView.layer.shadowRadius = 2;
    hud.bezelView.layer.shadowOffset = CGSizeMake(0, 0);
    hud.bezelView.layer.shadowOpacity = 0.8;
    hud.bezelView.layer.masksToBounds = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }
    
    return hud;
}

+ (instancetype)showLoadingWithText:(NSString *)text toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.9f];
    hud.bezelView.layer.shadowColor = [UIColor blackColor].CGColor;
    hud.bezelView.layer.shadowRadius = 1.5;
    hud.bezelView.layer.shadowOffset = CGSizeMake(0, 0);
    hud.bezelView.layer.shadowOpacity = 0.8;
    hud.bezelView.layer.masksToBounds = NO;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.activityIndicatorColor = [UIColor whiteColor];
    
    //[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor redColor];
    
    if (text && text.length > 0) {
        hud.label.text = text;
    }
    
    return hud;
}

+ (void)showText:(NSString *)text name:(NSString *)name
{
    // 显示加载失败
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // 显示一张图片(mode必须写在customView设置之前)
    hud.mode = MBProgressHUDModeCustomView;
    // 设置一张图片
    name = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", name];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    
    hud.labelText = text;
    
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒后自动隐藏
    [hud hide:YES afterDelay:1];
}

+ (void)showErrorWithText:(NSString *)text
{
    [self showText:text name:@"error.png"];
}

+ (void)showSuccessWithText:(NSString *)text
{
    [self showText:text name:@"success.png"];
}

@end
