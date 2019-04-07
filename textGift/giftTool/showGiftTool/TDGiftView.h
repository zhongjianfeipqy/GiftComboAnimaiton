//
//  TDGiftView.h
//  liveDemo
//
//  Created by tuandai on 2017/4/20.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCCustomMessageModel;

@protocol TDGiftViewDelegate <NSObject>

-(void)sendGift:(UIButton*)btn With:(TCCustomMessageModel*)giftModel;

@end

@interface TDGiftView : UIView
@property (nonatomic, weak) id<TDGiftViewDelegate> delegate;

@end
