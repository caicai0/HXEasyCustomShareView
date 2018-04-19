//
//  UIButton+layout.h
//  JianKangJie3
//
//  Created by liyufeng on 16/6/15.
//  Copyright © 2016年 liyufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LXMImagePosition) {
    LXMImagePositionLeft = 0,              //图片在左，文字在右，默认
    LXMImagePositionRight = 1,             //图片在右，文字在左
    LXMImagePositionTop = 2,               //图片在上，文字在下
    LXMImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (layout)

- (void)setImagePosition:(LXMImagePosition)postion spacing:(CGFloat)spacing;

@end
