//
//  ThemeManager.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

//主题名
@property (nonatomic,copy)NSString *themeName;

//主题配置
@property (nonatomic,retain)NSDictionary *themeConfiguration;

//主题颜色配置
@property (nonatomic,retain)NSDictionary *themeColorConfiguration;

+ (instancetype)singleInstance;

//获取图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//获取颜色
- (UIColor *)getThemeColor:(NSString *)colorName;

@end
