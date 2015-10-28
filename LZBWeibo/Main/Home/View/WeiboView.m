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
    
    _backgroundImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    _backgroundImage.hidden = YES;
    
    _backgroundImage.backgroundColor = [UIColor grayColor];
    
    _reTextLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    
    _reImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    [_backgroundImage addSubview:_reImageView];
    
    [_backgroundImage addSubview:_reTextLabel];
    
    [self addSubview:_backgroundImage];
    
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
    
    _textLabel.frame = CGRectMake(0, 0, self.width, [_textLabel optimumSize].height);
    
    if (_model.pic_urls.count > 0) {
        
        _imageView.hidden = NO;
        
        _imageView.frame = CGRectMake(0, _textLabel.bottom, 100, 150);
        
        [_imageView setImageWithURL:[NSURL URLWithString:[[_model.pic_urls lastObject] objectForKey:@"thumbnail_pic"]]];
        
        [self repostWeibo];
        return;
    }
    _imageView.hidden = YES;
    _imageView.frame = CGRectMake(0, _textLabel.bottom, 0, 0);
    [self repostWeibo];
}

- (void)repostWeibo {
    
    if (_model.repostModel) {
        
        _backgroundImage.hidden = NO;
        
        _reTextLabel.text = [NSString stringWithFormat:@"      @%@:%@",_model.repostModel.repostUserModel.screen_name,_model.repostModel.text];
        
        _reTextLabel.width = self.width;
        
        _reTextLabel.frame = CGRectMake(0, 0, self.width, [_reTextLabel optimumSize].height);
        
        if (_model.repostModel.pic_urls.count > 0) {
            
            _reImageView.hidden = NO;
            
            _reImageView.frame = CGRectMake(0, _reTextLabel.bottom, 100, 150);
            
            [_reImageView setImageWithURL:[NSURL URLWithString:[[_model.repostModel.pic_urls lastObject] objectForKey:@"thumbnail_pic"]]];
            
            _backgroundImage.frame = CGRectMake(0, _imageView.bottom + 5, self.width, _reImageView.bottom);
            
            return;
        }
        
        _reImageView.hidden = YES;
        _reImageView.frame = CGRectMake(0, _reTextLabel.bottom, 0, 0);
        
        _backgroundImage.frame = CGRectMake(0, _imageView.bottom + 5, self.width, _reImageView.bottom);

    }
    _backgroundImage.hidden = YES;
    _backgroundImage.frame = CGRectZero;
    
    
    
}


@end
