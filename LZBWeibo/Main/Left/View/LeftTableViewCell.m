//
//  LeftTableViewCell.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    
    _themeName.themeColorName = @"More_Item_Text_color";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
