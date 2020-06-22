//
//  LeftTableView.h
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/15.
//  Copyright © 2019 002. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftTableView : UIView

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) void(^homeScrollY)(CGFloat scrollY);
@property (nonatomic, copy) void(^scrollViewOffset)(BOOL);

@end

NS_ASSUME_NONNULL_END
