//
//  ThemeImageView.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeChangeNotification object:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        //添加通知观察者
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(loadImage)
                                                    name:kThemeChangeNotification
                                                  object:nil];
    }
    return self;
}

-(void)awakeFromNib {
    
    self.userInteractionEnabled = YES;
    
    //添加通知观察者
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(loadImage)
                                                name:kThemeChangeNotification
                                              object:nil];
    
}

- (void)setImageName:(NSString *)imageName {
    
    if (_imageName != imageName) {
        
        _imageName = imageName;
    }
    
    [self loadImage];
    
}

- (void)loadImage {
    
    if (_imageName.length > 0) {
        
        if (_capTop && _capLeft) {
            
            self.image = [[[ThemeManager singleInstance] getThemeImage:_imageName] stretchableImageWithLeftCapWidth:_capLeft topCapHeight:_capTop];
            
            return;
            
        }
    }
    
    self.image = [[ThemeManager singleInstance] getThemeImage:_imageName];
}


@end
