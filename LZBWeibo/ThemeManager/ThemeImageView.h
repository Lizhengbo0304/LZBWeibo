//
//  ThemeImageView.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

//图片名称
@property (nonatomic,copy)NSString *imageName;

//拉伸数据
@property (nonatomic,assign)NSInteger capTop,capLeft;

@end
