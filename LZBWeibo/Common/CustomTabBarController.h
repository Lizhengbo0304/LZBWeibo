//
//  CustomTabBarController.h
//  时光电影（修正版）
//
//  Created by LiZhengbo on 15/9/14.
//  Copyright (c) 2015年 李正博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"

@interface CustomTabBarController : UITabBarController {
    
    ThemeImageView *_customTabBar;  //自定义的标签栏
    
    ThemeImageView *_selectedImageView;
}

@end

#pragma mark - CustomTabBarItem

//父类须为UIControl 或者 UIButton，才可以添加点击事件
@interface CustomTabBarItem : UIControl

@property (nonatomic,strong)ThemeImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame tabBarItem:(UITabBarItem *)item;

@end