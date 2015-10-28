//
//  WeiboView.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface WeiboView : UIView

//微博文字
@property (nonatomic,strong)RTLabel *textLabel;

//微博图片
@property (nonatomic,strong)UIImageView *imageView;

//背景视图
@property (nonatomic,strong)UIImageView *backgroundImage;

//转发文字
@property (nonatomic,strong)RTLabel *reTextLabel;

//转发图片
@property (nonatomic,strong)UIImageView *reImageView;

@property (nonatomic,strong)WeiboModel *model;

@end
