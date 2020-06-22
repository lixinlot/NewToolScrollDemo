//
//  LeftTableView.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/15.
//  Copyright © 2019 002. All rights reserved.
//

#import "LeftTableView.h"
#import "MJRefresh.h"

#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height  [UIScreen mainScreen].bounds.size.height


@interface LeftTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat  contentOffset;
@property (nonatomic, assign) CGFloat  oldOffset;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation LeftTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [self.dataArray addObject:@(i)];
        }
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Width, K_Height - 120 - 44)];
        self.tableView.backgroundColor = [UIColor orangeColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self load];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMore];
        }];
        [self addSubview:self.tableView];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"left ---- %ld", (long)indexPath.row];
    
    return  cell;
}


//记录拖动时候的offset
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.contentOffset = scrollView.contentOffset.y;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (self.homeScrollY) {
        self.homeScrollY(newOffsetY);
    }
     if (newOffsetY > self.oldOffset && self.oldOffset > self.contentOffset){//上滑
            //写上滑代码
         NSLog(@"//写上滑代码--- %f", newOffsetY);
         
         if (newOffsetY > 0) {
             if (self.scrollViewOffset) {
                 self.scrollViewOffset(NO);
             }
         }

        }else if(newOffsetY < self.oldOffset && self.oldOffset < self.contentOffset){//下滑
            //写下滑代码
            if (newOffsetY <= 150) {
                if (self.scrollViewOffset) {
                    self.scrollViewOffset(YES);
                }
            }
//            NSLog(@"//写下滑代码 --- %f", newOffsetY);
        }
       self.oldOffset = scrollView.contentOffset.y;
}
//记录滑动结束时候的offset
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.oldOffset = scrollView.contentOffset.y;
}

- (void)load {
    [self.tableView.mj_header endRefreshing];
    for (int i = 0; i < 20; i++) {
        [self.dataArray addObject:@(i)];
    }
    [self.tableView reloadData];
}

- (void)loadMore {
    [self.tableView.mj_footer endRefreshing];
    [self.dataArray addObjectsFromArray:self.dataArray];
    [self.tableView reloadData];
}

@end
