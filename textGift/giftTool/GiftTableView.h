//
//  GiftTableView.h
//  textGift
//
//  Created by tuandai on 2017/7/6.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCCustomMessageModel;
@interface GiftTableView : UIView
-(void)sendGift:(UIButton*)btn With:(TCCustomMessageModel*)giftModel;

- (void)closeAllObject;
@end
