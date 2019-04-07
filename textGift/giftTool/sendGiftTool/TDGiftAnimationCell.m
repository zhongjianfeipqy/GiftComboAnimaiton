//
//  TDGiftAnimationCell.m
//  liveDemo
//
//  Created by tuandai on 2017/4/21.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import "TDGiftAnimationCell.h"
#import "TDGiftLabel.h"
#import "TCCustomMessageModel.h"

@interface TDGiftAnimationCell ()

@property (nonatomic, strong) TDGiftLabel *numLable;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UIImageView *giftImg;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UILabel *tips;

@end



@implementation TDGiftAnimationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.alpha = 0.6;
        self.bgView.layer.cornerRadius = 23.0;
        self.bgView.layer.masksToBounds = YES;
        self.userName.text = @"无敌小超人";
        self.tips.text = @"送出了某某巨头";
        self.iconView.image = [UIImage imageNamed:@"default_user"];
//        self.giftImg.image = [UIImage imageNamed:_giftModel.giftUrl];
        self.numLable.text = @"";
        
        
    }
    return self;
}


-(void)setGiftModel:(TCCustomMessageModel *)giftModel {    
    _giftModel = giftModel;

    self.giftImg.image = [UIImage imageNamed:_giftModel.giftUrl];
    
    
    if (_giftModel.isComboed) {
        [self anima:_giftModel.combo];
    }else {
        self.numLable.text = [NSString stringWithFormat:@"X%zd",_giftModel.combo];
    }
    
}

- (void)anima:(NSInteger)num {
    [self.numLable anima:num];
}

#pragma mark - 懒加载
-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _bgView;
}

-(TDGiftLabel *)numLable {
    if (!_numLable) {
        _numLable = [TDGiftLabel new];
        _numLable.font = [UIFont systemFontOfSize:22];
        [self.contentView addSubview:_numLable];
        [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.bgView.mas_right).mas_offset(15);
        }];
    }
    return _numLable;
}

-(UIImageView *)giftImg {
    if (!_giftImg) {
        _giftImg = [UIImageView new];
        [self.bgView addSubview:_giftImg];
        [_giftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(self.bgView);
            make.right.mas_equalTo(self.bgView).offset(-20);
            make.left.mas_equalTo(self.tips.mas_right).offset(10);
            make.left.mas_equalTo(self.userName.mas_right).offset(10);
        }];
        
    }
    return _giftImg;
}

-(UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        [self.bgView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(self.bgView);
            make.width.height.mas_equalTo(35);
        }];
        
    }
    return _iconView;
}


-(UILabel *)tips {
    if (!_tips) {
        _tips = [UILabel new];
        _tips.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:_tips];
        [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.iconView);
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(5);
        }];
    }
    return _tips;
}

-(UILabel *)userName {
    if (!_userName) {
        _userName = [UILabel new];
        _userName.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:_userName];
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconView);
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(5);
        }];
    }
    return _userName;
}


@end
