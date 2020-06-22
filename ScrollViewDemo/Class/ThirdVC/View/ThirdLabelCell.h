//
//  ThirdLabelCell.h
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/6.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThirdLabelCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *dataArr;
/// 0纯展示 1可删除 2可添加 3可单选 4可多选
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) void(^returnSelfHeight)(CGFloat height,NSMutableArray *arr);

@end

NS_ASSUME_NONNULL_END
