//
//  CustomTabBarController.m
//  时光电影（修正版）
//
//  Created by LiZhengbo on 15/9/14.
//  Copyright (c) 2015年 李正博. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自定义tabBar
    _customTabBar = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    
    _customTabBar.capLeft = 1;
    
    _customTabBar.capTop =20;
    
    _customTabBar.imageName = @"mask_detailbar";
    
    [self.tabBar addSubview:_customTabBar];
}

#pragma mark - 创建自定义的tabbar  button
//1.覆写set方法，获取viewControllers的个数
- (void)setViewControllers:(NSArray *)viewControllers {
    
    [super setViewControllers:viewControllers];
    
    [self createTabBarButton];
}
//2.创建并添加自定义的tabbar button
- (void)createTabBarButton {
    
    //根据视图控制器的个数获取按钮个数
    int itemCount              = (int) self.viewControllers.count;
    
    //选中按钮时的背景图
    _selectedImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth/itemCount,45)];
    
    _selectedImageView.imageName = @"home_bottom_tab_arrow";
    
    [_customTabBar addSubview:_selectedImageView];

    //对应每个试图控制器创建按钮
    int i = 0;
    for (UIViewController *viewController in self.viewControllers) {
        
        //创建自定义的tabBarItem，根据对应的视图控制器确定其位置
        CustomTabBarItem *item = [[CustomTabBarItem alloc]initWithFrame:CGRectMake((kScreenWidth / itemCount) * i, 0, kScreenWidth / itemCount, 49) tabBarItem:viewController.tabBarItem];
        
        item.imageView.imageName = viewController.tabBarItem.image.accessibilityIdentifier;
        
        item.tag = 100 + i;
        //添加点击事件
        [item addTarget:self
                 action:@selector(btnAction:)
       forControlEvents:UIControlEventTouchDown];
        
        [_customTabBar addSubview:item];
        
        i ++;
    }
}

//标签按钮点击事件
- (void)btnAction:(CustomTabBarItem *)btn {

    //根据点击的按钮，切换相应的试图控制器
    self.selectedIndex = btn.tag - 100;
    //移动选中按钮
    [UIView animateWithDuration:0.3 animations:^{
        
        _selectedImageView.transform = CGAffineTransformMakeTranslation((kScreenWidth / self.viewControllers.count) * self.selectedIndex, 0);
    }];
    
}

#pragma mark - 移除原生的tabbar button

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self removeTabBarButton];
}
//取出原生的tabBarItem
- (void)removeTabBarButton {
    
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

@end

#pragma mark - CustomTabBarItem
@implementation CustomTabBarItem
//自定义tabBarItem，设置大小以及要代替哪个item
- (instancetype)initWithFrame:(CGRect)frame tabBarItem:(UITabBarItem *)item {
    
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[ThemeImageView alloc]initWithFrame: CGRectMake((frame.size.width - 19)/2, 5, 19, 20)];

        _imageView.userInteractionEnabled = NO;

        //防止图片被拉伸
        _imageView.contentMode = UIViewContentModeCenter;
        
        _imageView.image = item.image;
        
        _imageView.imageName = item.image.accessibilityIdentifier;

        [self addSubview:_imageView];
    }
    return self;
}

@end