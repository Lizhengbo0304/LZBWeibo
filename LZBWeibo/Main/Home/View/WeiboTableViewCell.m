//
//  WeiboTableViewCell.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "WeiboTableViewCell.h"

@implementation WeiboTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WeiboModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    [self setNeedsLayout];
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_headerImage setImageWithURL:[NSURL URLWithString:_model.user.profile_image_url]];
    
    _nameLabel.text = _model.user.screen_name;
    
    _sourceLabel.text = [Utils formatString:_model.createDate];
    
    _weiboView.model = _model;
        
}
@end
