//
//  BaseViewController.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeChangeNotification object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载图片，设置背景
    [self changeBackGround];
    //添加通知观察者
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(changeBackGround)
                                                name:kThemeChangeNotification
                                              object:nil];
    
}


- (void)changeBackGround {

    self.view.backgroundColor = [UIColor colorWithPatternImage:[[[ThemeManager singleInstance] getThemeImage:@"bg_home.jpg"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
