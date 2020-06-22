//
//  ThirdLabelViewController.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/6.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "ThirdLabelViewController.h"
#import "ThirdLabelCell.h"
#import "LabelModel.h"

#define screenWidths [UIScreen mainScreen].bounds.size.width
#define screenHeigths [UIScreen mainScreen].bounds.size.height

@interface ThirdLabelViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataArray2;
@property (nonatomic,strong) NSArray *typeArray;
@property (nonatomic,strong) NSArray *sectionTitleArray;
@property (nonatomic,assign) CGFloat cellH;
@property (nonatomic,strong) NSMutableArray *addData;

@end

@implementation ThirdLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"欢迎来到标签的世界";
    self.cellH = 0.0;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, screenWidths, screenHeigths-self.navBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
//    self.tableView.estimatedSectionHeaderHeight = 0.01;
//    self.tableView.estimatedSectionFooterHeight = 0.01;
    self.tableView.tableHeaderView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self getData];
}

- (void)getData {
    LabelModel *model1 = [[LabelModel alloc] init];
    model1.content = @"我是第一个";
    model1.isSelected = NO;
    
    LabelModel *model2 = [[LabelModel alloc] init];
    model2.content = @"我是第二个";
    model2.isSelected = NO;
    
    LabelModel *model3 = [[LabelModel alloc] init];
    model3.content = @"我是第三个";
    model3.isSelected = NO;
    
    LabelModel *model4 = [[LabelModel alloc] init];
    model4.content = @"我是第四个";
    model4.isSelected = NO;
    
    LabelModel *model5 = [[LabelModel alloc] init];
    model5.content = @"我是第⑤个";
    model5.isSelected = NO;
    
    self.dataArray = @[model1,model2,model3,model4,model5].mutableCopy;
    self.dataArray2 = @[model1,model2,model3,model4,model5].mutableCopy;
    self.addData = [NSMutableArray array];
    self.sectionTitleArray = @[@"纯展示",@"可删除",@"可添加",@"可单选",@"可多选"];
    self.typeArray = @[@"0",@"1",@"2",@"3",@"4"];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitleArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (self.cellH == 0) {
            return 24+10+10;
        }else {
            return self.cellH;
        }
    }else if (indexPath.section == 1) {
        if (self.cellH == 0) {
            return (24+10+10)*2;
        }else {
            return self.cellH;
        }
    }else {
        CGFloat left = 0;
        CGFloat top = 10;
        for (int i = 0; i < self.dataArray.count; i++) {
            LabelModel *model = self.dataArray[i];
            NSString *str = model.content;
            CGSize size = [str boundingRectWithSize:CGSizeMake(300, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
            left = left+10+size.width+30;
            if (left > [UIScreen mainScreen].bounds.size.width) {
                top = top + 24+10;
            }
        }
        return top;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ThirdLabelCell";
    ThirdLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ThirdLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.type = [self.typeArray[indexPath.section] intValue];

    if (indexPath.section == 2) {
        if (self.addData.count != 0) {
            cell.dataArr = self.addData;
        }else {
            cell.dataArr = @[self.dataArray.firstObject].mutableCopy;
        }
        cell.returnSelfHeight = ^(CGFloat height, NSMutableArray *arr) {
            self.cellH = height;
            self.addData = arr;
            NSIndexSet *index = [NSIndexSet indexSetWithIndex:2];
            [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
        };
    }else if (indexPath.section == 1) {
        cell.dataArr = self.dataArray2;
        cell.returnSelfHeight = ^(CGFloat height, NSMutableArray *arr) {
            self.cellH = height;
            self.dataArray2 = arr;
            NSIndexSet *index = [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
        };
    }else {
        cell.dataArr = self.dataArray;
    }
    
    return cell;
}

@end
