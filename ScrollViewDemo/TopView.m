//
//  TopView.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/15.
//  Copyright © 2019 002. All rights reserved.
//

#import "TopView.h"

#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height  [UIScreen mainScreen].bounds.size.height

@interface TopView ()

@end


@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isShow = YES;
        [self setViewUI];
    }
    return self;
}

- (void)setViewUI
{
    self.cricleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Width, 120)];
    self.cricleView.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.cricleView];
    
    
    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, K_Width, 44)];
    self.segmentView.backgroundColor = [UIColor brownColor];
    [self addSubview:self.segmentView];
}


@end
