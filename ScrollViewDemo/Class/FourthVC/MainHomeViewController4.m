//
//  MainHomeViewController4.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/27.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "MainHomeViewController4.h"
#import "CustomHandelTool.h"

@interface MainHomeViewController4 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MainHomeViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@"设置",@"隐私",@"账户",@"缓存1",@"缓存2"].mutableCopy;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    topView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = topView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = UIColor.lightGrayColor;
    if (indexPath.row == 3) {
        __block CGFloat cacheSize = 0.0;
        [CustomHandelTool getFileSize:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] completion:^(CGFloat totalSize) {
            cacheSize = totalSize;
            if (cacheSize == 0) {
                cacheSize = 0.01;
            }
//            dispatch_async(dispatch_get_main_queue(), ^{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%f",cacheSize];
//            });
        }];
    }else if (indexPath.row == 4) {
        if ([CustomHandelTool getCacheSize].intValue == 0) {
            cell.detailTextLabel.text = @"0";
        }else {
            cell.detailTextLabel.text = [CustomHandelTool getCacheSize];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [CustomHandelTool removeDirectoryPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else if (indexPath.row == 4) {
        [CustomHandelTool cleanCache];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
