//
//  LeftTableViewCell.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface LeftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ThemeImageView *themeIcon;

@property (weak, nonatomic) IBOutlet ThemeLabel *themeName;

@end
