//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/3/15.
//  Copyright © 2019 002. All rights reserved.
//

#import "ViewController.h"
#import "RightTableView.h"
#import "LeftTableView.h"
#import "TopView.h"

#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) TopView * topView;
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) LeftTableView * leftView;
@property (nonatomic, strong) RightTableView * rightView;

@property(nonatomic,strong) UIButton *topBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopViewUI];
    [self setScrollViewUI];
    [self setScrollViewContentUI];
}

- (void)setTopViewUI {
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, K_Width, 120 + 44)];
    [self.view addSubview:self.topView];
}

- (void)setScrollViewUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120 + 44, K_Width, K_Height - 120 - 44)];
    self.scrollView.pagingEnabled = true;
    self.scrollView.contentSize = CGSizeMake(K_Width * 2, K_Height - 120 - 44);
    [self.view addSubview:self.scrollView];
}


- (void)setScrollViewContentUI {
    __weak typeof(self) weakSelf = self;
    self.leftView = [[LeftTableView alloc] initWithFrame:CGRectMake(0, 0, K_Width, K_Height - 120 - 44)];
    self.leftView.scrollViewOffset = ^(BOOL result) {
        [weakSelf isShowTopView:result];
    };
    self.leftView.homeScrollY = ^(CGFloat scrollY) {
        if (scrollY > 375/3) {
            weakSelf.topBtn.hidden = NO;
        }else {
            weakSelf.topBtn.hidden = YES;
        }
    };
    [self.scrollView addSubview:self.leftView];
    
    self.rightView = [[RightTableView alloc] initWithFrame:CGRectMake(K_Width, 0, K_Width, K_Height - 120 - 44)];
    self.rightView.scrollViewOffset = ^(BOOL result) {
        [weakSelf isShowTopView:result];
    };
    self.rightView.homeScrollY = ^(CGFloat scrollY) {
        if (scrollY > 375/3) {
            weakSelf.topBtn.hidden = NO;
        }else {
            weakSelf.topBtn.hidden = YES;
        }
    };
    [self.scrollView addSubview:self.rightView];
}

- (void)isShowTopView:(BOOL)result {
    if (self.topView.isShow == result) {
        return;
    }
    self.topView.isShow = result;
    
    if (result) {
        NSLog(@"折叠topVIew");
        self.leftView.tableView.frame = CGRectMake(0, 0, K_Width, K_Height - 120 - 44);
        self.rightView.tableView.frame = CGRectMake(0, 0, K_Width, K_Height - 120 - 44);
        [UIView animateWithDuration:0.15 animations:^{
            self.topView.frame = CGRectMake(0, 0, K_Width, 120 + 44);
            self.scrollView.contentSize = CGSizeMake(K_Width * 2, K_Height - 120 - 44);
            self.scrollView.frame = CGRectMake(0, 120 + 44, K_Width, K_Height - 120 - 44);
            self.leftView.frame = CGRectMake(0, 0, K_Width, K_Height - 120 - 44);
            self.rightView.frame = CGRectMake(K_Width, 0, K_Width, K_Height - 120 - 44);
        }];
    }else{
        NSLog(@"展开topVIew");
        self.leftView.tableView.frame = CGRectMake(0, 0, K_Width, K_Height - 44);
        self.rightView.tableView.frame = CGRectMake(0, 0, K_Width, K_Height - 44);
        [UIView animateWithDuration:0.15 animations:^{
            self.topView.frame = CGRectMake(0, -120, K_Width, 120 + 44);
            self.scrollView.contentSize = CGSizeMake(K_Width * 2, K_Height - 44);
            self.scrollView.frame = CGRectMake(0, 44, K_Width, K_Height - 44);
            self.leftView.frame = CGRectMake(0, 0, K_Width, K_Height - 44);
            self.rightView.frame = CGRectMake(K_Width, 0, K_Width, K_Height - 44);
        }];
    }
}

- (UIButton *)topBtn {
    if (!_topBtn) {
        _topBtn = [[UIButton alloc] initWithFrame:CGRectMake(375-40-20, 667-84-40-60, 40, 40)];
        _topBtn.backgroundColor = [UIColor redColor];
//        [_topBtn setImage:[UIImage imageNamed:@"home_back_to_top"] forState:UIControlStateNormal];
        [_topBtn setTitle:@"置顶" forState:UIControlStateNormal];
        [_topBtn addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_topBtn];
        _topBtn.hidden = YES;
    }
    return _topBtn;
}

//点击置顶
- (void)topClick {
    
    if (self.scrollView.contentOffset.x < 375) {
        
        [self.leftView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:true];
//        [self.leftView.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:true];
        [self.leftView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else {
        [self.rightView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }
//    HomeNavDataModel *tempModel = self.model.data[self.index];
//    if (self.index == 0 && [tempModel.ids isEqualToString:@"-1"]) {
//        OSNewHomeSubViewController *childVc = self.vcArray[0];
////        [self recoverViewUIWithNewHomeVC:childVc];
////        [childVc.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:true];
//        [childVc.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
//    }else {
//        if (self.index == 0 && ![tempModel.ids isEqualToString:@"-1"]) {
//            OSHomeSubViewController *childVc = self.vcArray[0];
////            [self recoverViewUIWithHomeVC:childVc];
//            [childVc.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
//        }else {
//            for (NSNumber *index in self.vcAddIndexArray) {
//                if (index.intValue == self.index) {
//                    NSInteger i = [self.vcAddIndexArray indexOfObject:@(self.index)];
//                    OSHomeSubViewController *childVc = self.vcArray[i];
////                    [self recoverViewUIWithHomeVC:childVc];
//                    [childVc.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
//                }
//            }
//        }
//    }
}

@end
