//
//  ThemeLabel.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeChangeNotification object:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //添加通知观察者
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadColor)
                                                     name:kThemeChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadColor)
                                                 name:kThemeChangeNotification
                                               object:nil];
    
    [self loadColor];
}

- (void)setThemeColorName:(NSString *)themeColorName {
    
    if (_themeColorName != themeColorName) {
        _themeColorName = themeColorName;
    }
    [self loadColor];
    
}

- (void)loadColor {
    
    if (_themeColorName.length > 0) {
        
        self.textColor = [[ThemeManager singleInstance] getThemeColor:_themeColorName];
    }
}



@end
