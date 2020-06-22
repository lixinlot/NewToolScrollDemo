//
//  SingleLabelView.h
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/6.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LayoutButtonStyle) {
    LayoutButtonStyleLeftImageRightTitle,
    LayoutButtonStyleLeftTitleRightImage,
    LayoutButtonStyleUpImageDownTitle,
    LayoutButtonStyleUpTitleDownImage
};

@interface SingleLabelView : UIButton

/// 布局方式
@property (nonatomic, assign) LayoutButtonStyle layoutStyle;
/// 图片和文字的间距，默认值8
@property (nonatomic, assign) CGFloat midSpacing;

@property(nonatomic,assign)CGSize imageSize;

@property(nonatomic,assign)BOOL titleFit;
//文字居中显示,不差过最大长度
@property(nonatomic,assign)BOOL titleCenter;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
//图片居右
@property(nonatomic,assign)BOOL isImageRight;
//整体居左
@property(nonatomic,assign)BOOL isLeft;
@property(nonatomic,assign)CGFloat leftPadding;

//居上
@property(nonatomic,assign)BOOL isTop;
//整体居右
@property(nonatomic,assign)BOOL isRight;

@property(nonatomic,assign)BOOL isBottom;

@end

NS_ASSUME_NONNULL_END
