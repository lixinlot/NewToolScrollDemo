//
//  RightTableView.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/15.
//  Copyright © 2019 002. All rights reserved.
//

#import "RightTableView.h"

#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height  [UIScreen mainScreen].bounds.size.height

@interface RightTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat  contentOffset;
@property (nonatomic, assign) CGFloat  oldOffset;

@end

@implementation RightTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, K_Height - 120 - 44)];
        self.tableView.backgroundColor = [UIColor blueColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"right ---- %ld", (long)indexPath.row];
   
    
    return  cell;
}


//记录拖动时候的offset
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.contentOffset = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (self.homeScrollY) {
        self.homeScrollY(newOffsetY);
    }
     if (newOffsetY > self.oldOffset && self.oldOffset > self.contentOffset){//上滑
            //写上滑代码
//         NSLog(@"//写上滑代码");
         
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.oldOffset = scrollView.contentOffset.y;
}

@end
