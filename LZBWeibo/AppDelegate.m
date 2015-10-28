//
//  AppDelegate.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "LeftViewController.h"
#import "CustomTabBarController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    //让窗口显示出来
    [self.window makeKeyAndVisible];
    
    //加载视图控制器
    [self loadViewControllers];
    
    //1.打开调试模式
    [WeiboSDK enableDebugMode:YES];
    
    //2.注册App
    [WeiboSDK registerApp:kAppKey];
    
    //3.判断oauth不存在的时候去加载
    if (!kAccessToken) {
        
        [self oauth];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 

- (void)loadViewControllers {

    NSArray *storyboardNames = @[@"Home",@"Message",@"Discover",@"Setting",@"More"];
    
    NSMutableArray *navis = [NSMutableArray array];
    
    for (int i = 0; i < storyboardNames.count; i ++) {
        
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:storyboardNames[i] bundle:nil];
        
        BaseNavigationController *nav = [stroyboard instantiateInitialViewController];
        
        //添加到数组中
        [navis addObject:nav];
        
        NSString *imageName = [NSString stringWithFormat:@"home_tab_icon_%d.png",i + 1];
        
        UIImage *image = [[ThemeManager singleInstance] getThemeImage:imageName];
        
        //将图片的文件名设为图片的标志属性
        image.accessibilityIdentifier = imageName;
        
        nav.tabBarItem.image = image;
        
    }
    
    //中间视图
    CustomTabBarController *centerController = [[CustomTabBarController alloc]init];
    
    centerController.viewControllers = navis;
    
    //左部视图
    LeftViewController *leftViewController = [[UIStoryboard storyboardWithName:@"Left" bundle:nil]instantiateInitialViewController];
    
    //1.创建
    MMDrawerController *mmDrawerController = [[MMDrawerController alloc]initWithCenterViewController:centerController leftDrawerViewController:leftViewController];
    
    //2.设置分栏控制器最大偏移量
    [mmDrawerController setMaximumLeftDrawerWidth:230];
    
    //3.手势响应区域
    [mmDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmDrawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //4.开关动画形式
    [[MMExampleDrawerVisualStateManager sharedManager]setLeftDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    self.window.rootViewController = mmDrawerController;
    
}

- (void)oauth {
    
    //1.初始化一个请求
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    
    //2.设置授权回调页
    request.redirectURI = kRequestURL;
    
    //3.授权范围
    request.scope = @"all";
    
    //4.用户信息
    request.userInfo = nil;
    
    //5.发送请求
    [WeiboSDK sendRequest:request];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - Weibo SDK Delegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"accessToken"];
    
    
    NSLog(@"-----%@",message);
    
}


@end
