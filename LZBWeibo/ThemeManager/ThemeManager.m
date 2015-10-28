//
//  ThemeManager.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "ThemeManager.h"

#define kCurrentThemeName @"currentThemeName"

@implementation ThemeManager

+ (instancetype)singleInstance {
    
    static ThemeManager *themeManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        themeManager = [[ThemeManager alloc]init];
        
    });
    
    return themeManager;
}

//重写init方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //设置主题名
            //1.获取本地词典
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
            //2.从字典中取出保存的ThemeName
        NSString *currentThemeName = [userDefaults valueForKey:kCurrentThemeName];
        
            //判断保存的主题名是否为空，为空时设置一个默认主题
        if (currentThemeName == nil) {
            
            currentThemeName = @"猫爷";
            
            [userDefaults setValue:@"猫爷" forKey:kCurrentThemeName];
            
        }
        
        _themeName = currentThemeName;
        
        //设置主题配置
            //获取文件路径
        NSString *path = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        
            //获取字典并赋值
        _themeConfiguration = [NSDictionary dictionaryWithContentsOfFile:path];
        
        //设置主题颜色配置
        [self reloadColorConfiguration];
    }
    return self;
}

//获取图片
- (UIImage *)getThemeImage:(NSString *)imageName {
    
    if (imageName.length == 0) {
        
        return nil;
    }
    
    //获取主题包文件夹路径
    NSString *path = [self themePath];
    
    //拼接图片路径
    NSString *imagePath = [path stringByAppendingPathComponent:imageName];
    
    return [UIImage imageWithContentsOfFile:imagePath];
    
}

//获取颜色
- (UIColor *)getThemeColor:(NSString *)colorName {
    
    if (colorName.length == 0) {
        
        return nil;
    }
    
    //通过颜色Key值，获取颜色字典
    NSDictionary *rgbColorDic = [_themeColorConfiguration objectForKey:colorName];
    
    NSNumber *red = [rgbColorDic objectForKey:@"R"];
    NSNumber *green = [rgbColorDic objectForKey:@"G"];
    NSNumber *blue = [rgbColorDic objectForKey:@"B"];
    
    NSNumber *alpha = @1;
    
    if ([rgbColorDic objectForKey:@"alpha"]) {
        
        alpha = [rgbColorDic objectForKey:@"alpha"];
        
    }
    
    return [UIColor colorWithRed:[red floatValue] / 255.0
                           green:[green floatValue] / 255.0
                            blue:[blue floatValue] / 255.0
                           alpha:[alpha floatValue]];
}

//获取主题颜色配置
- (void)reloadColorConfiguration {
    
    //获取主题路径
    NSString *themePath = [self themePath];
    
    //获取配置文件路径
    NSString *path = [themePath stringByAppendingPathComponent:@"config.plist"];
    
    _themeColorConfiguration = [NSDictionary dictionaryWithContentsOfFile:path];
}

//获取主题包文件夹路径
- (NSString *)themePath {
    
    //1.获取bundle路径
    NSString *path = [[NSBundle mainBundle]resourcePath];
    
    //2.主题包文件夹路径
    NSString *filePath = [_themeConfiguration objectForKey:_themeName];
    
    //将路径拼接后返回
    return [path stringByAppendingPathComponent:filePath];
}

//重写set方法
- (void)setThemeName:(NSString *)themeName {
    
    if (_themeName != themeName) {
        
        _themeName = themeName;
       
        //将更改后的主题名保存到本地文件中
        [[NSUserDefaults standardUserDefaults] setValue:_themeName forKey:kCurrentThemeName];
        
        //重新获取颜色配置
        [self reloadColorConfiguration];
        
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeChangeNotification object:nil];
    
    
    
    }
}

@end
