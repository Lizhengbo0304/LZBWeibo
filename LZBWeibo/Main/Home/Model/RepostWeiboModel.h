//
//  RepostWeiboModel.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "BVBaseModel.h"
#import "RepostUserModel.h"

@interface RepostWeiboModel : BVBaseModel

@property (nonatomic,copy)NSString *text;

@property (nonatomic,retain)NSArray *pic_urls;

@property (nonatomic,strong)RepostUserModel *repostUserModel;

@end
