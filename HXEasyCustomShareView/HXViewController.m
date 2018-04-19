//
//  HXViewController.m
//  HXEasyCustomShareView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXViewController.h"
#import "HXEasyCustomShareView.h"
#import <sys/utsname.h>

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简单自定义分享界面";
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(100, 100, 150, 50);
    [button1 setTitle:@"新浪分享" forState:UIControlStateNormal];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(button1.frame.origin.x, button1.frame.origin.y+button1.frame.size.height+20, button1.frame.size.width, button1.frame.size.height);
    [button2 setTitle:@"微信分享" forState:UIControlStateNormal];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake(button2.frame.origin.x, button2.frame.origin.y+button2.frame.size.height+20, button2.frame.size.width, button2.frame.size.height);
    [button3 setTitle:@"QQ分享" forState:UIControlStateNormal];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    button4.frame = CGRectMake(button3.frame.origin.x, button3.frame.origin.y+button3.frame.size.height+20, button3.frame.size.width, button3.frame.size.height);
    [button4 setTitle:@"淘宝分享" forState:UIControlStateNormal];
    button4.tag = 4;
    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    button5.frame = CGRectMake(button4.frame.origin.x, button4.frame.origin.y+button4.frame.size.height+20, button4.frame.size.width, button4.frame.size.height);
    [button5 setTitle:@"生日管家分享" forState:UIControlStateNormal];
    button5.tag = 5;
    [button5 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    NSString * plat = [self modelIdentifier];
    NSLog(@"%@",plat);
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1: {
            //微博
            [self addWeiboShareView];
        }
            break;
            
        case 2: {
            //微信
            [self addWeixinShareView];
        }
            break;
            
        case 3: {
            //QQ
            [self addQQShareView];
        }
            break;
            
        case 4: {
            //淘宝
            [self addTaobaoShareView];
        }
            break;
            
        case 5: {
            //生日管家
            [self addGuanjiaShareView];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  仿新浪微博分享界面
 */
- (void)addWeiboShareView {
    //分享媒介数据源
    NSArray *shareAry = @[@{@"image":@"more_chat",
                            @"highlightedImage":@"more_chat_highlighted",
                            @"title":@"私信和群",@"tag":@(0)},
                          @{@"image":@"more_weixin",
                            @"highlightedImage":@"more_weixin_highlighted",
                            @"title":@"微信好友",@"tag":@(0)},
                          @{@"image":@"more_circlefriends",
                            @"highlightedImage":@"more_circlefriends_highlighted",
                            @"title":@"朋友圈",@"tag":@(0)},
                          @{@"image":@"more_icon_zhifubao",
                            @"highlightedImage":@"more_icon_zhifubao_highlighted",
                            @"title":@"支付宝好友",@"tag":@(0)},
                          @{@"image":@"more_icon_zhifubao_friend",
                            @"highlightedImage":@"more_icon_zhifubao_friend_highlighted",
                            @"title":@"生活圈",@"tag":@(0)},
                          @{@"image":@"more_icon_qq",
                            @"highlightedImage":@"more_icon_qq_highlighted",
                            @"title":@"QQ",@"tag":@(0)},
                          @{@"image":@"more_icon_qzone",
                            @"highlightedImage":@"more_icon_qzone_highlighted",
                            @"title":@"QQ空间",@"tag":@(0)},
                          @{@"image":@"more_mms",
                            @"highlightedImage":@"more_mms_highlighted",
                            @"title":@"短信",@"tag":@(0)},
                          @{@"image":@"more_email",
                            @"highlightedImage":@"more_email_highlighted",
                            @"title":@"邮件分享",@"tag":@(0)},
                          @{@"image":@"more_icon_cardbackground",
                            @"highlightedImage":@"more_icon_cardbackground_highlighted",
                            @"title":@"设卡片背景",@"tag":@(0)},
                          @{@"image":@"more_icon_collection",
                            @"title":@"收藏",@"tag":@(0)},
                          @{@"image":@"more_icon_topline",
                            @"title":@"帮上头条",@"tag":@(0)},
                          @{@"image":@"more_icon_link",
                            @"title":@"复制链接",@"tag":@(0)},
                          @{@"image":@"more_icon_report",
                            @"title":@"举报",@"tag":@(0)},
                          @{@"image":@"more_icon_back",
                            @"title":@"返回首页"}];
    
    //自定义头部
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 36)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 21, headerView.frame.size.width-32, 15)];
    label.textColor = [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0 alpha:1.0];;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    //实例化
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    //设置头部View 如果不设置则不显示头部
    shareView.headerView = headerView;
    //计算高度 根据第一行显示的数量和总数,可以确定显示一行还是两行,最多显示2行
    float height = [shareView getBoderViewHeight:shareAry firstCount:9];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.firstCount = 9;
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

/**
 *  仿微信分享界面
 */
- (void)addWeixinShareView {
    NSArray *shareAry = @[@{@"image":@"Action_Share",
                            @"title":@"众说",@"tag":@(0)},
                          @{@"image":@"Action_Moments",
                            @"title":@"微信朋友圈",@"tag":@(0)},
                          @{@"image":@"Action_MyFavAdd",
                            @"title":@"微信好友",@"tag":@(0)},
                          @{@"image":@"AS_safari",
                            @"title":@"新浪微博",@"tag":@(0)},
                          @{@"image":@"AS_Email",
                            @"title":@"QQ好友",@"tag":@(0)},
                          @{@"image":@"AS_QQ",
                            @"title":@"微信收藏"}
                          ];
    NSArray * optionsAry = @[@{@"image":@"Action_Verified",
                               @"title":@"夜间模式",@"tag":@(0)},
                             @{@"image":@"Action_Copy",
                               @"title":@"复制链接",@"tag":@(0)},
                             @{@"image":@"Action_Font",
                               @"title":@"字体大小",@"tag":@(0)},
                             @{@"image":@"Action_Expose",
                               @"title":@"举报"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, headerView.frame.size.width, 11)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:99/255.0 green:98/255.0 blue:98/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:11];
    label.text = @"网页由 mp.weixin.qq.com 提供";
    [headerView addSubview:label];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:6];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    [shareView setShareAry:shareAry delegate:self];
    shareView.middleLineLabel.frame = CGRectMake(10, shareView.middleLineLabel.frame.origin.y, shareView.frame.size.width-20, shareView.middleLineLabel.frame.size.height);
    shareView.showsHorizontalScrollIndicator = NO;
    [self.navigationController.view addSubview:shareView];
}

/**
 *  仿QQ分享界面
 */
- (void)addQQShareView {
    NSArray *shareAry = @[@{@"image":@"qq_haoyou",
                            @"title":@"好友",@"tag":@(0)},
                          @{@"image":@"qq_kongjian",
                            @"title":@"QQ空间",@"tag":@(0)},
                          @{@"image":@"qq_weixin",
                            @"title":@"微信",@"tag":@(0)},
                          @{@"image":@"qq_pengyouquan",
                            @"title":@"朋友圈",@"tag":@(0)},
                          @{@"image":@"qq_safari",
                            @"title":@"Safari打开",@"tag":@(0)},
                          @{@"image":@"qq_ziliao",
                            @"title":@"查看资料",@"tag":@(0)},
                          @{@"image":@"qq_shoucang",
                            @"title":@"收藏",@"tag":@(0)},
                          @{@"image":@"qq_fuzhi",
                            @"title":@"复制链接",@"tag":@(0)},
                          @{@"image":@"qq_jubao",
                            @"title":@"举报"}];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    float height = [shareView getBoderViewHeight:shareAry firstCount:5];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

/**
 *  仿淘宝分享界面
 */
- (void)addTaobaoShareView {
    NSArray *shareAry = @[@{@"image":@"taobao_fuzhi",
                            @"title":@"复制",@"tag":@(0)},
                          @{@"image":@"taobao_erweima",
                            @"title":@"二维码",@"tag":@(0)},
                          @{@"image":@"taobao_songli",
                            @"title":@"送礼",@"tag":@(0)},
                          @{@"image":@"taobao_weixin",
                            @"title":@"微信",@"tag":@(0)},
                          @{@"image":@"taobao_qq",
                            @"title":@"QQ好友",@"tag":@(0)},
                          @{@"image":@"taobao_weibo",
                            @"title":@"微博",@"tag":@(0)},
                          @{@"image":@"taobao_guangjie",
                            @"title":@"爱逛街",@"tag":@(0)},
                          @{@"image":@"taobao_zhifu",
                            @"title":@"支付宝好友"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:51/255.0 green:68/255.0 blue:79/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享";
    [headerView addSubview:label];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 120)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, footerView.frame.size.width-20, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    [footerView addSubview:lineLabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(12, 13, headerView.frame.size.width-24, 12)];
    label.textColor = [UIColor colorWithRed:5/255.0 green:27/255.0 blue:40/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"手机联系人和淘友";
    [footerView addSubview:label];
    
    UIImageView *icoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y+label.frame.size.height+12, 57, 57)];
    icoImageView.image = [UIImage imageNamed:@"taobao_lianxiren"];
    [footerView addSubview:icoImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(icoImageView.frame.origin.x+icoImageView.frame.size.width, icoImageView.frame.origin.y, headerView.frame.size.width-24-icoImageView.frame.size.width, icoImageView.frame.size.height)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [footerView addSubview:view];
    
    NSString *content = @"分享给淘友或手机联系人,好友可在手机淘宝【消息中心】或【短信】中看到你的分享";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    //调节高度
    CGSize size = CGSizeMake(headerView.frame.size.width-24-icoImageView.frame.size.width, 500000);

    label = [[UILabel alloc] initWithFrame:CGRectMake(icoImageView.frame.origin.x+icoImageView.frame.size.width+10, icoImageView.frame.origin.y, headerView.frame.size.width-24-icoImageView.frame.size.width-10, icoImageView.frame.size.height)];
    label.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.attributedText = attributedString;
    [footerView addSubview:label];
    [label sizeThatFits:size];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:3];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    [shareView setShareAry:shareAry delegate:self];
    shareView.footerView = footerView;
    [self.navigationController.view addSubview:shareView];
}

/**
 *  仿生日管家分享界面
 */
- (void)addGuanjiaShareView {
    NSArray *shareAry = @[@{@"image":@"shareView_wx",
                            @"title":@"微信",@"tag":@(0)},
                          @{@"image":@"shareView_friend",
                            @"title":@"朋友圈",@"tag":@(0)},
                          @{@"image":@"shareView_qq",
                            @"title":@"QQ",@"tag":@(0)},
                          @{@"image":@"shareView_wb",
                            @"title":@"新浪微博",@"tag":@(0)},
                          @{@"image":@"shareView_rr",
                            @"title":@"人人网",@"tag":@(0)},
                          @{@"image":@"shareView_qzone",
                            @"title":@"QQ空间",@"tag":@(0)},
                          @{@"image":@"shareView_msg",
                            @"title":@"短信",@"tag":@(0)},
                          @{@"image":@"share_copyLink",
                            @"title":@"复制链接"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-0.5, headerView.frame.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 0.5)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:self.navigationController.view.bounds];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

#pragma mark HXEasyCustomShareViewDelegate

- (void)easyCustomShareViewButtonAction:(HXEasyCustomShareView *)shareView title:(NSString *)title tag:(NSInteger)tag {
    NSLog(@"当前点击:%@",title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)modelIdentifier{
    
//    需要导入头文件：#import <sys/utsname.h>
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}

@end
