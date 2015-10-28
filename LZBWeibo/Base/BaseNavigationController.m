//
//  BaseNavigationController.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeChangeNotification object:nil];
    
}

-(void)awakeFromNib {
    
    //添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeNavigationBar)
                                                 name:kThemeChangeNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self changeNavigationBar];
    
}

- (void)changeNavigationBar {
    
    //获取当前系统版本
    NSString *device = [[UIDevice currentDevice] systemVersion];
    
    //根据系统不同版本，设置不同图片
    NSString *imageName = @"mask_titlebar";
    
    if ([device floatValue] >= 7.0) {
        
        imageName = @"mask_titlebar64";
        
    }
    
    //设置导航栏背景图片
    [self.navigationBar setBackgroundImage:[[ThemeManager singleInstance] getThemeImage:imageName] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏标题颜色
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[[ThemeManager singleInstance] getThemeColor:@"Background_Compose_color"],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18],NSFontAttributeName, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
