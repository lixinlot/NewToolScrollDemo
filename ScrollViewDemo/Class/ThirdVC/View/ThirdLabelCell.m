//
//  ThirdLabelCell.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/6.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "ThirdLabelCell.h"
#import "SingleLabelView.h"
#import "MBProgressHUD+Extension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ThirdLabelCell()<UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *viewArr;
@property (nonatomic,strong) UIView         *bjView;
@property (nonatomic,strong) SingleLabelView *selectBtn;
@property (nonatomic,assign) NSInteger       selectIndex;

@end

@implementation ThirdLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self creatChildView];
    }
    return self;
}

- (void)creatChildView {
    self.selectIndex = -1;
    self.viewArr = [NSMutableArray array];
    self.bjView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    self.bjView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.bjView];
    
}

- (void)setType:(NSInteger)type {
    /// 0纯展示 1可删除 2可添加 3可单选 4可多选
    _type = type;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    
    if (dataArr.count == 0) {
        self.bjView.frame = CGRectMake(0, 0, kScreenWidth, 0.01);
    }else {
        for (SingleLabelView *label in self.viewArr) {
            label.hidden = YES;
        }
        CGFloat left = 0;
        CGFloat top = 10;
        for (int i = 0; i < dataArr.count; i++) {
            LabelModel *model = dataArr[i];
            NSString *str = model.content;
            CGSize size = [str boundingRectWithSize:CGSizeMake(300, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            left = left+10+size.width+30;
            if (left > [UIScreen mainScreen].bounds.size.width) {
                left = size.width+30+10;
                top = top+24+10;
            }
            if (i < self.viewArr.count) {
                SingleLabelView *bu = self.viewArr[i];
                bu.hidden = NO;
                bu.tag = 2000+i;
                bu.userInteractionEnabled = NO;
                [bu setTitle:model.content forState:UIControlStateNormal];
                bu.frame = CGRectMake(12+left-size.width-30-10, top, size.width+30, 24);
                if (self.type == 1) {
                    bu.userInteractionEnabled = YES;
                }
            }else{
                SingleLabelView *label = [[SingleLabelView alloc] initWithFrame:CGRectMake(12+left-size.width-30-10, top, size.width+30, 24)];
                label.layoutStyle = LayoutButtonStyleLeftTitleRightImage;
                label.imageSize = CGSizeMake(18, 18);
                if (self.type == 3 || self.type == 4) {
                    [label setImage:[UIImage imageNamed:@"notCheck"] forState:UIControlStateNormal];
                }
                label.tag = 2000+i;
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = 24/2;
                label.layer.borderWidth = 0.5;
                label.layer.borderColor = UIColor.lightGrayColor.CGColor;
                label.titleLabel.font = [UIFont systemFontOfSize:14];
                [label setTitle:model.content forState:UIControlStateNormal];
                [label setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                
                if (self.type == 1) {
                    [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
                }else if (self.type == 2) {
                    if (i == dataArr.count-1) {
                        [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
                    }else {
                        label.userInteractionEnabled = NO;
                    }
                }else if (self.type != 2){
                    [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
                }
                [self.bjView addSubview:label];
                [self.viewArr addObject:label];
            }
            if (i == dataArr.count-1) {
                self.bjView.frame = CGRectMake(0, 0, kScreenWidth, top+24+10);
            }
        }
    }
}

- (void)labelClick:(SingleLabelView *)sender {
    NSInteger tag = sender.tag-2000;
    if (self.type == 4) {//4可多选
        sender.selected = !sender.selected;
        if (sender.selected == YES) {
            [sender setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        }else {
            [sender setImage:[UIImage imageNamed:@"notCheck"] forState:UIControlStateNormal];
        }
    }else if (self.type == 3) {//3可单选
        self.selectBtn = sender;
        sender.selected = !sender.selected;
        for (int i = 0; i < self.viewArr.count; i++) {
            SingleLabelView *view = self.viewArr[i];
            if (tag == i) {
                view.selected = sender.selected;
            }else {
                view.selected = NO;
            }
            [view setImage:[UIImage imageNamed:@"notCheck"] forState:UIControlStateNormal];
        }
        SingleLabelView *view = self.viewArr[tag];
        if (view.selected == YES) {
            [view setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        }else {
            [view setImage:[UIImage imageNamed:@"notCheck"] forState:UIControlStateNormal];
        }
    }else if (self.type == 2) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加标签" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *txtName = [alert textFieldAtIndex:0];
        txtName.placeholder = @"请输入名称";
        txtName.delegate = self;
        alert.delegate = self;
        [alert show];
    }else if (self.type == 1) {
        CGFloat left = 0;
        CGFloat top = 10;
        NSMutableArray *mulArr = self.viewArr;
        [mulArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SingleLabelView *view = obj;
            if (view.tag == sender.tag) {
               *stop = YES;
                [view removeFromSuperview];
                if (*stop == YES) {
                    [mulArr removeObjectAtIndex:idx];
                    [self.dataArr removeObjectAtIndex:idx];
                    self.viewArr = mulArr;
                }
            }
            if (*stop) {
                NSLog(@"array is %@",mulArr);
            }
        }];
        
        if (self.viewArr.count == 1) {
            [MBProgressHUD showWithText:@"已经是最少了哦~不能再少了" toView:[UIApplication sharedApplication].keyWindow];
            return;
        }

        for (int i = 0; i < self.viewArr.count; i++) {
            LabelModel *mo = self.dataArr[i];
            CGSize size = [mo.content boundingRectWithSize:CGSizeMake(300, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            left = left+10+size.width+30;
            if (left > [UIScreen mainScreen].bounds.size.width) {
                left = size.width+30+10;
                top = top+24+10;
            }
            SingleLabelView *view = self.viewArr[i];
            [view setTitle:mo.content forState:UIControlStateNormal];
            view.frame = CGRectMake(12+left-size.width-30-10, top, size.width+30, 24);
            if (i == self.viewArr.count-1) {
                self.bjView.frame = CGRectMake(0, 0, kScreenWidth, top+24+10);
                if (self.returnSelfHeight) {
                    self.returnSelfHeight(top+24+10,self.dataArr);
                }
            }else if (self.viewArr.count == 0) {
                self.bjView.frame = CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN);
                if (self.returnSelfHeight) {
                    self.returnSelfHeight(CGFLOAT_MIN,self.dataArr);
                }
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *str = textField.text;
        LabelModel *model = [[LabelModel alloc] init];
        model.content = str;
        [self.dataArr insertObject:model atIndex:0];
        SingleLabelView *label = [[SingleLabelView alloc] initWithFrame:CGRectMake(12, 0, 30, 24)];
        label.layoutStyle = LayoutButtonStyleLeftTitleRightImage;
        label.imageSize = CGSizeMake(18, 18);
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 24/2;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = UIColor.lightGrayColor.CGColor;
        label.titleLabel.font = [UIFont systemFontOfSize:14];
        [label setTitle:str forState:UIControlStateNormal];
        [label setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.bjView addSubview:label];
        [self.viewArr insertObject:label atIndex:0];
        
        CGFloat left = 0;
        CGFloat top = 10;
//        [[self.viewArr reverseObjectEnumerator] allObjects];
        for (int i = 0; i < self.viewArr.count; i++) {
            LabelModel *mo = self.dataArr[i];
            CGSize size = [mo.content boundingRectWithSize:CGSizeMake(300, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            left = left+10+size.width+30;
            if (left > [UIScreen mainScreen].bounds.size.width) {
                left = size.width+30+10;
                top = top+24+10;
            }
            SingleLabelView *view = self.viewArr[i];
            [view setTitle:mo.content forState:UIControlStateNormal];
            view.frame = CGRectMake(12+left-size.width-30-10, top, size.width+30, 24);
            if (i == self.viewArr.count-1) {
                self.bjView.frame = CGRectMake(0, 0, kScreenWidth, top+24+10);
                if (self.returnSelfHeight) {
                    self.returnSelfHeight(top+24+10,self.dataArr);
                }
            }
        }
        
    }
}


@end
