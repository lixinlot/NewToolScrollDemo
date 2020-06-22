//
//  SecondViewController.m
//  JJOptionView
//
//  Created by 俊杰  廖 on 2018/9/29.
//  Copyright © 2018年 俊杰  廖. All rights reserved.
//

#import "SecondViewController.h"
#import "TYSnapshotScroll.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *labelView;
@property (nonatomic,assign) BOOL isExpand;
@property (nonatomic,assign) CGFloat labelHeight;
@property (nonatomic,assign) NSInteger labelTag;
@property (nonatomic,strong) NSArray *colorModelArr;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger    currentPage;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"comment页";
    
    self.isExpand = NO;
    self.labelHeight = 10;
    self.labelTag = -1;
    self.colorModelArr = @[@0,@0,@0,@0,@1,@1,@1];
    self.currentPage = 1;
    self.dataArr = [NSMutableArray array];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
    self.headerView.backgroundColor = [UIColor redColor];
    self.headerView.clipsToBounds = YES;
    
    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    labelView.backgroundColor = [UIColor whiteColor];
    labelView.clipsToBounds = YES;
    [self.headerView addSubview:labelView];
    self.labelView = labelView;
    
    CGFloat left = 0;
    CGFloat top = 0;
    NSArray *arr = @[@"111",@"2222",@"33333",@"444444",@"5555555",@"才能到货款是是是",@"你加的我你成佛王嘉尔佛为分泌物你是南方科技女"];
    for (int i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        CGSize size = [str boundingRectWithSize:CGSizeMake(300, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        //        CGSize size = [arr[i] boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        left = left+10+size.width+20;
        if (left > [UIScreen mainScreen].bounds.size.width) {
            left = size.width+20+10;
            top = top + 24+10;
        }
        UIButton *label = [[UIButton alloc] initWithFrame:CGRectMake(12+left-size.width-20-10, top, size.width+20, 24)];
        [label setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
        label.layer.cornerRadius = 24/2;
        label.layer.borderWidth = 0.5;
        label.tag = 200+i;
        label.titleLabel.font = [UIFont systemFontOfSize:14];
        label.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [label setTitle:str forState:(UIControlStateNormal)];
        [label addTarget:self action:@selector(labelClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.labelView addSubview:label];
        
        if (i == 0) {
            label.layer.borderColor = UIColor.purpleColor.CGColor;
            [label setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
            //            label.backgroundColor = [UIColor purpleColor];
        }
        
        if (i <= arr.count && i >= 4) {
            label.backgroundColor = [UIColor redColor];
            label.layer.borderWidth = 0.0;
            [label setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        }
        
        if (i == arr.count-1) {
            self.labelHeight = top+24+10+10;
            self.labelView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (24+10)*2);
            self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (24+10)*2+20);
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [btn setImage:[UIImage imageNamed:@"list_icon_drfault"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2, CGRectGetMaxY(self.labelView.frame), 60, 20);
    [btn setTitle:@"展开" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAllLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0.01;
        self.tableView.estimatedSectionHeaderHeight = 0.01;
        self.tableView.estimatedSectionFooterHeight = 0.01;
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)clickAllLabel:(UIButton *)sender {
    self.isExpand = !self.isExpand;
    
    if (self.isExpand == YES) {
        [sender setTitle:@"收回" forState:UIControlStateNormal];
        sender.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2, self.labelHeight, 60, 20);
        self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.labelHeight+20);
        self.labelView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.labelHeight);
        
        [TYSnapshotScroll screenSnapshot:self.tableView finishBlock:^(UIImage *snapShotImage) {
            //doSomething
            [self saveImage:snapShotImage];
        }];
        
    }else {
        [sender setTitle:@"展开" forState:UIControlStateNormal];
        sender.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2, (24+10)*2, 60, 20);
        self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (24+10)*2+20);
        self.labelView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (24+10)*2);
    }
    self.tableView.tableHeaderView = self.headerView;
}

- (void)saveImage:(UIImage *)image {
    //save to photosAlbum
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *barItemTitle = @"保存成功";
    if (error != nil) {
        barItemTitle = @"保存失败";
    }
    
    [self.navigationItem.rightBarButtonItem setTitle:barItemTitle];
}

- (void)labelClick:(UIButton *)sender {
    NSLog(@"点击了sender：%ld",(long)sender.tag);
    
    sender.selected = !sender.selected;
//    sender.backgroundColor = [UIColor purpleColor];
    sender.layer.borderColor = UIColor.purpleColor.CGColor;
    [sender setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
    
    UIButton *label = [self.view viewWithTag:self.labelTag];
    
    if (self.labelTag == sender.tag) {
        label.layer.borderColor = UIColor.purpleColor.CGColor;
        [label setTitleColor:UIColor.purpleColor forState:UIControlStateNormal];
//        label.backgroundColor = [UIColor purpleColor];
    }else {
        if (sender.tag != 200) {
            UIButton *label0 = [self.view viewWithTag:200];
            label0.layer.borderColor = UIColor.lightGrayColor.CGColor;
            [label0 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//            label0.backgroundColor = [UIColor whiteColor];
        }
        self.labelTag = sender.tag;
        label.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [label setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//        label.backgroundColor = [UIColor whiteColor];
    }
}

@end
