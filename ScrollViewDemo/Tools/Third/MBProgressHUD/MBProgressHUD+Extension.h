//
//  MBProgressHUD+Extension.h
//  SiJiShows
//
//  Created by 002 on 2019/2/22.
//  Copyright © 2019 002. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Extension)
+ (instancetype)showWithText:(NSString *)text toView:(UIView *)view;

+ (instancetype)showWithText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay;

+ (instancetype)showLoadingWithText:(NSString *)text toView:(UIView *)view;

+ (void)showErrorWithText:(NSString *)text;
+ (void)showSuccessWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
