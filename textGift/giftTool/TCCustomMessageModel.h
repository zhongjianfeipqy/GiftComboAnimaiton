//
//  TCCustomMessageModel.h
//  TCLVBIMDemo
//
//  Created by tuandai on 2017/6/30.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GiftDataDelgate <NSObject>

// label动画
- (void)anima:(NSInteger)num;

@end

@interface TCCustomMessageModel : NSObject
// 连击时间
#define LIVE_TIME 10

// 显示时间
#define Show_TIME 5

// 两个用户是否相同，可通过比较imUserId来判断
// 用户IMSDK的identigier
@property (nonatomic, copy) NSString *imUserId;

// 用户昵称
@property (nonatomic, copy) NSString *imUserName;

// 用户头像地址
@property (nonatomic, copy) NSString *imUserIconUrl;

// 用户发出的消息
@property (nonatomic, copy) NSString *msg;

// 礼物图片url
@property (nonatomic, copy) NSString *giftUrl;

@property (nonatomic, copy) NSString *giftID;

@property (nonatomic, copy) NSString *giftType;

@property (nullable,weak) id <GiftDataDelgate> delgate;

@property (nonatomic, assign) BOOL isComboed;

// 显示在界面的时间
@property (nonatomic, assign) float showTime;

// 动画可连击时间
@property (nonatomic,assign) float live;
// 连击数
@property (nonatomic,assign) NSUInteger combo;
// 礼物连击
-(void)resetLive;

@end
