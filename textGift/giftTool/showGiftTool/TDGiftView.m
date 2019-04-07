//
//  TDGiftView.m
//  liveDemo
//
//  Created by tuandai on 2017/4/20.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import "TDGiftView.h"
#import "TDGiftLayout.h"
#import "TDGiftCell.h"

#import "TCCustomMessageModel.h"

@interface TDGiftView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TDGiftLayout *layout;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) TDGiftCell *selectCell;
@end


static NSString *cellID = @"TDGiftCellID";
@implementation TDGiftView

-(instancetype)init {
    if (self = [super init]) {
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [self.collectionView registerNib:[UINib nibWithNibName:@"TDGiftCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    }
    return self;
}

-(void)sendBtnClick:(UIButton*)btn {
    if ([self.delegate respondsToSelector:@selector(sendGift:With:)]) {
        TCCustomMessageModel *data = [TCCustomMessageModel new];
        data.giftUrl = self.selectCell.giftImgStr;
        data.imUserName = @"老大";
        data.imUserIconUrl = @"http://touxiang.qqzhi.com/uploads/2012-11/1111005600464.jpg";
//        data.cmdType = AVIMCMD_Custom_Gift;
        NSString *giftType = [NSString stringWithFormat:@"%zd",self.selectCell.tag];
        data.giftType = giftType;
        data.giftID = giftType;
//        int temp = arc4random_uniform(2);
//        if (temp) {
//            data.isLeftAnimation = UITableViewRowAnimationRight;
//        }else {
//            data.isLeftAnimation = UITableViewRowAnimationLeft;
//        }
        
        [self.delegate sendGift:btn With:data];
    }
}

#pragma mark - collectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TDGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
//    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    cell.giftImgStr = [NSString stringWithFormat:@"zan_l%zd",indexPath.item + 1];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCell = [collectionView cellForItemAtIndexPath:indexPath];
    self.selectCell.selected = YES;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}



#pragma mark - 懒加载
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.alpha = 0.6;
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.sendBtn.mas_top);
        }];
    }
    return _collectionView;
}

-(TDGiftLayout *)layout {
    if (!_layout) {
        _layout = [[TDGiftLayout alloc] init];
        _layout.minimumLineSpacing = 10;
        _layout.minimumInteritemSpacing = 10;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _layout.itemSize = CGSizeMake((SCREEN_WIDTH - 10 * 5) / 4, 50);
    }
    return _layout;
}

-(UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton new];
        [_sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self);
            make.height.width.mas_equalTo(50);
        }];
    }
    return _sendBtn;
}


@end
