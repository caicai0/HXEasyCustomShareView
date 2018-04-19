//
//  HXEasyCustomShareView.m
//  HXEasyCustomShareView
//
//  Created by 黄轩 on 16/1/19.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXEasyCustomShareView.h"
#import "HXShareScrollView.h"
#import <sys/utsname.h>

#define LEFT_SPACE (44)
#define RIGHT_SPACE (34)

@interface HXEasyCustomShareView()

@property (nonatomic, strong)UIView *zhezhaoView;
@property (nonatomic, strong)NSArray *scrollViews;

@end

@implementation HXEasyCustomShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    CGRect frame = self.frame;
    _zhezhaoView = [[UIView alloc] initWithFrame:frame];
    _zhezhaoView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    _zhezhaoView.tag = 100;
    _zhezhaoView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    [_zhezhaoView addGestureRecognizer:myTap];
    [self addSubview:_zhezhaoView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 107)];
    _backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    _backView.userInteractionEnabled = YES;
    [self addSubview:_backView];
    
    _boderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, _backView.frame.size.height)];
    _boderView.backgroundColor = [UIColor clearColor];
    _boderView.userInteractionEnabled = YES;
    [_backView addSubview:_boderView];
    
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.frame = CGRectMake(0, 0, frame.size.width, 50);
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateNormal];
    [_cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0] size:CGSizeMake(1.0, 1.0)] forState:UIControlStateHighlighted];
    [_cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_cancleButton];
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_bottomView];
    
    NSLog(@"%d",isiPhoneX());
}

-(void)setHeaderView:(UIView *)headerView {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [_backView addSubview:_headerView];
}

-(void)setFooterView:(UIView *)footerView {
    [_footerView removeFromSuperview];
    _footerView = footerView;
    [_backView addSubview:_footerView];
}

- (void)setShareAry:(NSArray *)shareAry delegate:(id)delegate {
    _delegate = delegate;
    
    if (_firstCount > shareAry.count || _firstCount == 0) {
        _firstCount = shareAry.count;
    }

    NSArray *ary1 = [shareAry subarrayWithRange:NSMakeRange(0,_firstCount)];
    NSArray *ary2 = [shareAry subarrayWithRange:NSMakeRange(_firstCount,shareAry.count-_firstCount)];

    NSMutableArray *scrolls = [NSMutableArray array];
    
    HXShareScrollView *shareScrollView = [[HXShareScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [HXShareScrollView getShareScrollViewHeight])];
    [shareScrollView setShareAry:ary1 delegate:self];
    shareScrollView.showsHorizontalScrollIndicator = _showsHorizontalScrollIndicator;
    [_boderView addSubview:shareScrollView];
    [scrolls addObject:shareScrollView];
    
    if (_firstCount < shareAry.count) {
        //分割线
        self.middleLineLabel.frame = CGRectMake(0, shareScrollView.frame.origin.y+shareScrollView.frame.size.height, self.frame.size.width, 0.5);
        
        shareScrollView = [[HXShareScrollView alloc] initWithFrame:CGRectMake(0, _middleLineLabel.frame.origin.y+_middleLineLabel.frame.size.height, self.frame.size.width, [HXShareScrollView getShareScrollViewHeight])];
        [shareScrollView setShareAry:ary2 delegate:self];
        shareScrollView.showsHorizontalScrollIndicator = _showsHorizontalScrollIndicator;
        [_boderView addSubview:shareScrollView];
        [scrolls addObject:shareScrollView];
    }
    self.scrollViews = [NSArray arrayWithArray:scrolls];
}

- (UILabel *)middleLineLabel {
    if (!_middleLineLabel) {
        _middleLineLabel = [UILabel new];
        _middleLineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
        [_boderView addSubview:_middleLineLabel];
    }
    return _middleLineLabel;
}

- (float)getBoderViewHeight:(NSArray *)shareAry firstCount:(NSInteger)count {
    _firstCount = count;
    float height = [HXShareScrollView getShareScrollViewHeight];
    
    if (_firstCount > shareAry.count || _firstCount == 0) {
        return height;
    }
    
    if (_firstCount < shareAry.count) {
        return height*2+1;
    }
    return 0;
}

#pragma mark HXShareScrollViewDelegate

- (void)shareScrollViewButtonAction:(HXShareScrollView *)shareScrollView title:(NSString *)title {
    if (_delegate && [_delegate respondsToSelector:@selector(easyCustomShareViewButtonAction:title:)]) {
        [_delegate easyCustomShareViewButtonAction:self title:title];
    }
}

- (void)cancleButtonAction:(UIButton *)sender {
    [self tappedCancel];
}

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    [self tappedCancel];
}

- (void)tappedCancel {
    [UIView animateWithDuration:0.4 animations:^{
        UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
        zhezhaoView.alpha = 0;
        if (self->_backView) {
            self->_backView.frame = CGRectMake(0, self.frame.size.height, self->_backView.frame.size.width, self->_backView.frame.size.height);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    float height = 0;//从上到下布局
    
    if (self.superview) {
        self.frame = self.superview.bounds;
    }
    
    BOOL landscape = (self.frame.size.width>self.frame.size.height);
    CGFloat leftSpace = ((landscape && isiPhoneX())?LEFT_SPACE:0);
    CGFloat rightSpace = ((landscape && isiPhoneX())?RIGHT_SPACE:0);
    
    CGFloat width = self.bounds.size.width;
    _zhezhaoView.frame = self.bounds;
    
    CGFloat contentWidth = width - leftSpace - rightSpace;
    
    if (_headerView) {
        _headerView.frame = CGRectMake(leftSpace,0, contentWidth, _headerView.frame.size.height);
        _headerView.hidden = NO;
        height += _headerView.frame.size.height;
    }
    
    if (_boderView) {
        for (NSInteger i=0; i<self.scrollViews.count; i++) {
            UIView * view = self.scrollViews[i];
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, view.frame.size.height);
        }
        
        if (self.middleLineLabel) {
            CGRect frame = self.middleLineLabel.frame;
            frame.size.width = width;
            self.middleLineLabel.frame = frame;
        }
        
        _boderView.frame = CGRectMake(leftSpace, height, contentWidth, _boderView.frame.size.height);
        height += _boderView.frame.size.height;
    }
    
    if (_footerView) {
        _footerView.frame = CGRectMake(leftSpace, height, contentWidth, _footerView.frame.size.height);
        height += _footerView.frame.size.height;
    }
    
    if (_cancleButton) {
        _cancleButton.frame = CGRectMake(0, height, width, _cancleButton.frame.size.height);
        height += _cancleButton.frame.size.height;
    }
    
    if (_bottomView) {
        CGFloat bottomHeigth = 0;
        if (isiPhoneX()) {
            bottomHeigth = 34;
        }
        _bottomView.frame = CGRectMake(0, height, width, bottomHeigth);
        height += _bottomView.frame.size.height;
    }

    if (_backView) {
        _backView.frame = CGRectMake(0, self.frame.size.height, self.bounds.size.width, height);
        _backView.hidden = NO;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        if (self->_backView) {
            self->_backView.frame = CGRectMake(0, self.frame.size.height - self->_backView.frame.size.height, self->_backView.frame.size.width, self->_backView.frame.size.height);
        }
        
        UIView *zhezhaoView = (UIView *)[self viewWithTag:100];
        zhezhaoView.alpha = 0.9;
        
    } completion:^(BOOL finished) {
        
    }];
}
         
//颜色生成图片方法
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
     CGRect rect = CGRectMake(0, 0, size.width, size.height);
     
     UIGraphicsBeginImageContext(rect.size);
     
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     CGContextSetFillColorWithColor(context,
                                    
                                    color.CGColor);
     CGContextFillRect(context, rect);
     UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return img;
}

bool isiPhoneX(){
    struct utsname systemInfo;
    uname(&systemInfo);
    return strcmp(systemInfo.machine, "iPhone10,3")||strcmp(systemInfo.machine, "iPhone10,6");
}

@end
