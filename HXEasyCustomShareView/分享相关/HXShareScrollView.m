//
//  HXShareScrollView.m
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.

#import "HXShareScrollView.h"
#import "HXEasyCustomShareView.h"
#import "UIButton+layout.h"

@implementation HXShareScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _originX = HXOriginX;
        _originY = HXOriginY;
        _icoWidth = HXIcoWidth;
        _icoAndTitleSpace = HXIcoAndTitleSpace;
        _titleSize = HXTitleSize;
        _titleColor = HXTitleColor;
        _lastlySpace = HXLastlySpace;
        _horizontalSpace = HXHorizontalSpace;

        //设置当前scrollView的高度
        if (self.frame.size.height <= 0) {
            self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), _originY+_icoWidth+_icoAndTitleSpace+_titleSize+_lastlySpace);
        } else {
            self.frame = frame;
        }
    }
    return self;
}

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate {
    //先移除之前的View
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //代理
    _myDelegate = delegate;

    //设置当前scrollView的contentSize
    if (shareAry.count > 0) {
        //单行
        self.contentSize = CGSizeMake(_originX+shareAry.count*(_icoWidth+_horizontalSpace),self.frame.size.height);
    }
    //遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (NSDictionary *shareDic in shareAry) {
        
        NSUInteger i = [shareAry indexOfObject:shareDic];
        
        CGRect frame = CGRectMake(_originX+i*(_icoWidth+_horizontalSpace), _originY, _icoWidth, _icoWidth+_icoAndTitleSpace+_titleSize);;
        UIView *view = [self ittemShareViewWithFrame:frame dic:shareDic];
        [self addSubview:view];
    }
}

- (UIView *)ittemShareViewWithFrame:(CGRect)frame dic:(NSDictionary *)dic {

    NSString *image = dic[@"image"];
    NSString *highlightedImage = dic[@"highlightedImage"];
    NSString *title = [dic[@"title"] length] > 0 ? dic[@"title"] : @"";
    id tagObject = dic[@"tag"];
    NSInteger tag = 0;
    if (tagObject && [tagObject respondsToSelector:@selector(integerValue)]) {
        tag = [tagObject integerValue];
    }
    
    UIButton *view = [[UIButton alloc] initWithFrame:frame];
    view.tag = tag;
    view.backgroundColor = [UIColor clearColor];
    
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    view.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
    
    if (image.length > 0) {
        [view setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedImage.length > 0) {
        [view setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    [view addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view setImagePosition:LXMImagePositionTop spacing:5];
    
    return view;
}

+ (float)getShareScrollViewHeight {
    float height = HXOriginY+HXIcoWidth+HXIcoAndTitleSpace+HXTitleSize+HXLastlySpace;
    return height;
}

- (void)buttonAction:(UIButton *)sender {
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(shareScrollViewButtonAction:title:tag:)]) {
        [_myDelegate shareScrollViewButtonAction:self title:sender.titleLabel.text tag:sender.tag];
    }
}

@end
