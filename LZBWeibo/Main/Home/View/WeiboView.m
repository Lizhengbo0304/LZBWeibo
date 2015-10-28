//
//  WeiboView.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "WeiboView.h"

@implementation WeiboView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //创建控件
    [self loadSubViews];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建控件
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    _textLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 0)];
    
    [self addSubview:_textLabel];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    _imageView.hidden = YES;
    
    [self addSubview:_imageView];
    
}

- (void)setModel:(WeiboModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    [self layoutSubviews];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _textLabel.text = [NSString stringWithFormat:@"      %@",_model.text];
    NSLog(@"text:%@",_textLabel.text);
    
    _textLabel.frame = CGRectMake(0, 0, self.width, [_textLabel optimumSize].height);
    
    NSLog(@"%f",_textLabel.bottom);
    
    if (_model.pic_urls.count > 0) {
        
        _imageView.hidden = NO;
        
        _imageView.frame = CGRectMake(0, _textLabel.bottom, 100, 150);
        
        [_imageView setImageWithURL:[NSURL URLWithString:[[_model.pic_urls lastObject] objectForKey:@"thumbnail_pic"]]];
        return;
    }
    _imageView.hidden = YES;
}




@end
