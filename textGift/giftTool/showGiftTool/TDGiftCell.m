//
//  TDGiftCell.m
//  liveDemo
//
//  Created by tuandai on 2017/4/20.
//  Copyright © 2017年 tuandai. All rights reserved.
//

#import "TDGiftCell.h"

@interface TDGiftCell ()
@property (weak, nonatomic) IBOutlet UIImageView *giftImg;

@end

@implementation TDGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setGiftImgStr:(NSString *)giftImgStr {
    _giftImgStr = giftImgStr;
    self.giftImg.image = [UIImage imageNamed:_giftImgStr];
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 5;
    }else {
        self.layer.borderWidth = 0;
    }
}

@end
