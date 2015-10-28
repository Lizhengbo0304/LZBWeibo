//
//  WeiboTableViewCell.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
@interface WeiboTableViewCell : UITableViewCell

@property (nonatomic,strong)WeiboModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (weak, nonatomic) IBOutlet WeiboView *weiboView;

@end
