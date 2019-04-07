
//
//  TDGiftLabel.m
//  liveDemo
//
//  Created by tuandai on 2017/4/24.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import "TDGiftLabel.h"

@interface TDGiftLabel ()

@end

@implementation TDGiftLabel

-(instancetype)init {
    if (self = [super init]) {
//        self.current = 1;
    }
    return self;
}

- (void)anima:(NSInteger)num {
//    _current += 1;
//    if (!self.animing) {
        [self setText:[NSString stringWithFormat:@"X%zd",num]];
        [self animaWithTime:0.7 completion:nil];
//    }
}

- (void)animaWithTime:(NSTimeInterval)time completion:(void (^ __nullable)(BOOL finished))completion {
    self.transform = CGAffineTransformMakeScale(3.0, 3.0);
    self.alpha = 0;
    [UIView animateKeyframesWithDuration:time delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
            self.alpha = 0.8;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            self.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        }];
    } completion:completion];
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor whiteColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}
@end
