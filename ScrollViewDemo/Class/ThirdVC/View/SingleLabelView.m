//
//  SingleLabelView.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/6.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "SingleLabelView.h"
#import "UIView+Utils.h"

@interface SingleLabelView()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation SingleLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.midSpacing = 8;
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gradientLayer.frame = self.bounds;
    
    [self.imageView sizeToFit];
    if (self.titleFit == NO) {
        [self.titleLabel sizeToFit];
    }
    if (self.titleCenter == YES) {
        [self.titleLabel sizeToFit];
        self.titleLabel.width = self.bounds.size.width;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    switch (self.layoutStyle) {
        case LayoutButtonStyleLeftImageRightTitle:
            [self layoutHorizontalWithLeftView:self.imageView rightView:self.titleLabel];
            break;
        case LayoutButtonStyleLeftTitleRightImage:
            [self layoutHorizontalWithLeftView:self.titleLabel rightView:self.imageView];
            break;
        case LayoutButtonStyleUpImageDownTitle:
            [self layoutVerticalWithUpView:self.imageView downView:self.titleLabel];
            break;
        case LayoutButtonStyleUpTitleDownImage:
            [self layoutVerticalWithUpView:self.titleLabel downView:self.imageView];
            break;
        default:
            break;
    }
}

- (void)layoutHorizontalWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    CGRect leftViewFrame = leftView.frame;
    CGRect rightViewFrame = rightView.frame;
    if (self.imageSize.width != 0) {
        if (self.layoutStyle == LayoutButtonStyleLeftImageRightTitle) {
            leftViewFrame.size = self.imageSize;
        }else{
            rightViewFrame.size = self.imageSize;
        }
    }
    CGFloat totalWidth = CGRectGetWidth(leftViewFrame) + self.midSpacing + CGRectGetWidth(rightViewFrame);
    
    leftViewFrame.origin.x = (CGRectGetWidth(self.frame) - totalWidth) / 2.0;
    leftViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(leftViewFrame)) / 2.0;
    if (self.isLeft) {
        leftViewFrame.origin.x = self.leftPadding;
    }
    if (self.isTop) {
        leftViewFrame.origin.y = 0;
    }
    if (self.isRight) {
        leftViewFrame.origin.x = (CGRectGetWidth(self.frame) - totalWidth);
    }
    leftView.frame = leftViewFrame;
    
    rightViewFrame.origin.x = CGRectGetMaxX(leftViewFrame) + self.midSpacing;
    rightViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(rightViewFrame)) / 2.0;
    rightView.frame = rightViewFrame;
}

- (void)layoutVerticalWithUpView:(UIView *)upView downView:(UIView *)downView {
    CGRect upViewFrame = upView.frame;
    CGRect downViewFrame = downView.frame;
    if (self.imageSize.width != 0) {
        upViewFrame.size = self.imageSize;
    }
    CGFloat totalHeight = CGRectGetHeight(upViewFrame) + self.midSpacing + CGRectGetHeight(downViewFrame);
    upViewFrame.origin.y = (CGRectGetHeight(self.frame) - totalHeight) / 2.0;
    if (self.isTop) {
        upViewFrame.origin.y = 0;
    }
    if (self.isBottom) {
        upViewFrame.origin.y = CGRectGetHeight(self.frame) - totalHeight;
    }
    upViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(upViewFrame)) / 2.0;
    upView.frame = upViewFrame;
    
    downViewFrame.origin.y = CGRectGetMaxY(upViewFrame) + self.midSpacing;
    downViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(downViewFrame)) / 2.0;
    if (self.isImageRight) {
        downViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(downViewFrame));
    }
    downView.frame = downViewFrame;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

#pragma mark - lazy
- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    }
    return _gradientLayer;
}

- (void)setStartColor:(UIColor *)startColor {
    _startColor = startColor;
    
    UIColor *endColor = self.endColor ? self.endColor : [UIColor whiteColor];
    self.gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
}

- (void)setEndColor:(UIColor *)endColor {
    _endColor = endColor;
    
    UIColor *startColor = self.startColor ? self.startColor : [UIColor whiteColor];
    self.gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
}


@end
