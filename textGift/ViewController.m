//
//  ViewController.m
//  textGift
//
//  Created by tuandai on 2017/7/4.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import "ViewController.h"
#import "TDGiftView.h"
#import "TDGiftAnimationCell.h"
#import "TCCustomMessageModel.h"
#import "GiftTableView.h"


@interface ViewController ()<TDGiftViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) GiftTableView *giftTableView;

@property (nonatomic, strong) TDGiftView *giftView;

@property (nonatomic, strong) UIView *coverView;

// cell显示的数组
@property (nonatomic, strong) NSMutableArray *dataSource;

// 缓存数组
@property (nonatomic, strong) NSMutableArray *cacheDataSource;

// 上次显示的数组
@property (nonatomic, strong) NSMutableArray *lastDataSource;

// 定时器--用来检测连击和显示时间
@property (nonatomic, strong) NSTimer *checkTimer;

@end

@implementation ViewController

static NSInteger cellCount = 3;

static double deleteCacheTimer = 0.1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self giftTableView];
    self.giftView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [self.coverView addGestureRecognizer:tap];
    
//    [self.tableView registerClass:[TDGiftAnimationCell class] forCellReuseIdentifier:cellID];
//    self.tableView.bounces = NO;
    
    [self checkTimer];
    
    
}

//static NSString *cellID = @"cellID";
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.dataSource.count > cellCount) {
//        return cellCount;
//    }
//    return self.dataSource.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TDGiftAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (self.dataSource.count > 0) {
//        cell.giftModel = self.dataSource[indexPath.item];
//    }
//    
//    return cell;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}



- (IBAction)giftClick:(UIButton *)sender {
    self.giftView.hidden = NO;
    self.coverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMinY(self.giftView.frame));
    self.coverView.hidden = NO;
}

- (void)coverViewClick {
    [self.view endEditing:YES];
    self.giftView.hidden = YES;
    self.coverView.hidden = YES;
}

#pragma mark - 发送礼物
-(void)sendGift:(UIButton*)btn With:(TCCustomMessageModel*)giftModel {
    [self.giftTableView sendGift:btn With:giftModel];
    
//    NSLog(@"送出礼物ID为%@",giftModel.giftID);
//    TCCustomMessageModel *model = [self isComboed:giftModel];
//    if (model) { // 可连击
//        giftModel = model;
//    }else { // 不可连击（缓存里已经没有这个数据）
//        [self.cacheDataSource insertObject:giftModel atIndex:0];
//    }
//
//    giftModel.live = LIVE_TIME;
//    giftModel.showTime = Show_TIME;
//    [self.lastDataSource removeAllObjects];
//    [self.lastDataSource addObjectsFromArray:self.dataSource];
//    [self.dataSource insertObject:giftModel atIndex:0];
//    
//    
//    BOOL isReload = NO;
//    BOOL isShow = NO;
//    // 先判断是否能连击（不满cellCount的时候，连击需要刷新）
//    for (int i = 0; i < self.lastDataSource.count; ++i) {
//        TCCustomMessageModel *showModel = self.lastDataSource[i];
//        if (showModel == giftModel) {
//            isReload = YES;
//            isShow = YES;
//            [self.dataSource removeAllObjects];
//            [self.dataSource addObjectsFromArray:self.lastDataSource];
//            NSIndexPath *currentPath = [NSIndexPath indexPathForItem:i inSection:0];
//            [self.tableView reloadRowsAtIndexPaths:@[currentPath] withRowAnimation:UITableViewRowAnimationNone];
//            break;
//        }
//        
//    }
//    
//    // 判断是否需要刷新
//    for (; self.dataSource.count > cellCount;) {
//        [self.dataSource removeLastObject];
//        isReload = YES;
//    }
//    
//    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
//    
//    if (isReload) {
//        // 可连击不需要动画
//        if (model) {
//            // 判断这个model是否是cell中正在显示的
//            if (!isShow) {
//                for (int i = 0; i < self.lastDataSource.count; ++i) {
//                    TCCustomMessageModel *showModel = self.lastDataSource[i];
//                    if (showModel == giftModel) {
//                        NSLog(@"当前显示上有这个模型,在第%d行",i);
//                        isShow = YES;
//                        [self.dataSource removeAllObjects];
//                        [self.dataSource addObjectsFromArray:self.lastDataSource];
//                        NSIndexPath *currentPath = [NSIndexPath indexPathForItem:i inSection:0];
//                        [self.tableView reloadRowsAtIndexPaths:@[currentPath] withRowAnimation:UITableViewRowAnimationNone];
//                        break;
//                    }
//                    
//                }
//            }
//            
//            if (!isShow) {
//                NSLog(@"当前显示上没有这个模型,准备刷新第一行");
//                
//                [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];
//                
//                [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if (idx == self.dataSource.count - 1) {
//                        *stop = YES;
//                        return;
//                    }
//                    NSIndexPath *path1 = [NSIndexPath indexPathForItem:idx + 1 inSection:0];
//                    [self.tableView reloadRowsAtIndexPaths:@[path1] withRowAnimation:UITableViewRowAnimationBottom];
//                }];
//
//            }
//
//            
//        }else {
//            [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];
//            
//            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (idx == self.dataSource.count - 1) {
//                    *stop = YES;
//                    return;
//                }
//                NSIndexPath *path1 = [NSIndexPath indexPathForItem:idx + 1 inSection:0];
//                [self.tableView reloadRowsAtIndexPaths:@[path1] withRowAnimation:UITableViewRowAnimationBottom];
//            }];
//        }
//        
//        [UIView animateWithDuration:3 animations:^{
//            
//        } completion:^(BOOL finished) {
//            
//        }];
//        
//    }else {
//        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
//    }
    
    
}


#pragma mark - 判断是否可以连击
//- (TCCustomMessageModel *)isComboed:(TCCustomMessageModel*)giftModel {
//    __block BOOL isComboed = NO;
//    __block TCCustomMessageModel *model = nil;
//    [self.cacheDataSource enumerateObjectsUsingBlock:^(TCCustomMessageModel *existModel, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([existModel.imUserId isEqualToString:giftModel.imUserId] && [existModel.giftID isEqualToString:giftModel.giftID]) {
//            NSLog(@"同一个用户：%@送出 连击礼物ID---%@",giftModel.imUserId,giftModel.giftID);
//            
//            existModel.isComboed = YES;
//            existModel.combo += 1;
//            model = existModel;
//            
//            isComboed = YES;
//        }else {
//            existModel.isComboed = NO;
//        }
//    }];
//    
//    if (isComboed) {
//        giftModel = model;
//    }
//    
//    
//    return model;
//}
//
//#pragma mark - 检查缓存的item
//- (void)checkCacheItem {
//    [self.cacheDataSource enumerateObjectsUsingBlock:^(TCCustomMessageModel *showModel, NSUInteger idx, BOOL * _Nonnull stop) {
//        showModel.live -= deleteCacheTimer;
//        if (showModel.live <= 0) {
//            NSLog(@"第%zd个已经不能连击了",idx);
//            [self.cacheDataSource removeObjectAtIndex:idx];
//        }
//    }];
//    
//    [self.dataSource enumerateObjectsUsingBlock:^(TCCustomMessageModel *showModel, NSUInteger idx, BOOL * _Nonnull stop) {
//        showModel.showTime -= deleteCacheTimer;
//        if (showModel.showTime <= 0) {
//            NSLog(@"第%zd个已经不能留在显示了",idx);
//            [self.dataSource removeObjectAtIndex:idx];
//            NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
//            [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
//        }
//    }];
//}
//
//#pragma mark - 删除正在显示的item
//- (void)deleteShowItem {
//    if (self.dataSource.count > 0) {
//        NSInteger idx = self.dataSource.count - 1;
//        [self.dataSource removeObjectAtIndex:idx];
//        NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
//        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//
//#pragma mark - 判断item刷新方式
//-(void)addItemType:(TCCustomMessageModel*)giftModel {
//    
//}
//
//
//#pragma mark - 销毁所有的东西
//- (void)closeAllObject {
//    [self.dataSource removeAllObjects];
//    [self.cacheDataSource removeAllObjects];
//    [self.lastDataSource removeAllObjects];
//    [self.checkTimer invalidate];
//    
//    self.dataSource = nil;
//    self.cacheDataSource = nil;
//    self.lastDataSource = nil;
//    self.checkTimer = nil;
//}
//


#pragma mark - 懒加载
-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_coverView];
    }
    return _coverView;
}

-(TDGiftView *)giftView {
    if (!_giftView) {
        _giftView = [TDGiftView new];
        _giftView.delegate = self;
        [self.view addSubview:_giftView];
        [_giftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.height.mas_equalTo(180);
        }];
    }
    return _giftView;
}

//-(NSMutableArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [NSMutableArray array];
//    }
//    return _dataSource;
//}
//
//-(NSMutableArray *)cacheDataSource {
//    if (!_cacheDataSource) {
//        _cacheDataSource = [NSMutableArray array];
//    }
//    return _cacheDataSource;
//}
//
//-(NSMutableArray *)lastDataSource {
//    if (!_lastDataSource) {
//        _lastDataSource = [NSMutableArray array];
//    }
//    return _lastDataSource;
//}
//
//
//
//-(NSTimer *)checkTimer {
//    if (!_checkTimer) {
//        _checkTimer = [NSTimer scheduledTimerWithTimeInterval:deleteCacheTimer target:self selector:@selector(checkCacheItem) userInfo:nil repeats:YES];
//    }
//    return _checkTimer;
//}

-(GiftTableView *)giftTableView {
    if (!_giftTableView) {
        _giftTableView = [[GiftTableView alloc] init];
        _giftTableView.backgroundColor = [UIColor greenColor];        
        [self.view addSubview:_giftTableView];
        [_giftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(150);
            make.top.mas_equalTo(self.view).offset(100);
        }];
    }
    return _giftTableView;
}

@end
