//
//  Core.h
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Core : NSObject

+ (void)getHomeTimeLine:(void (^)(id response))block;

@end
