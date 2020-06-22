//
//  OSBaseNavigationController.h
//  SiJiShows
//
//  Created by 002 on 2019/2/21.
//  Copyright © 2019 002. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSBaseNavigationController : UINavigationController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic) UIBarButtonItem *leftBarBackButton;

@property (nonatomic) dispatch_block_t leftBarBackButtonAction;

@end

NS_ASSUME_NONNULL_END
