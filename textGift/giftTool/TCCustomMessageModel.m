//
//  TCCustomMessageModel.m
//  TCLVBIMDemo
//
//  Created by tuandai on 2017/6/30.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "TCCustomMessageModel.h"

@implementation TCCustomMessageModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.live = LIVE_TIME;
        self.combo = 1;
        self.showTime = Show_TIME;
//        self.isLeftAnimation = UITableViewRowAnimationLeft;
    }
    return self;
}


- (void)resetLive {
    self.combo += 1;
    self.live = LIVE_TIME;
    if ([self.delgate respondsToSelector:@selector(anima:)]) {
        [self.delgate anima:self.combo];
    }
}
@end
