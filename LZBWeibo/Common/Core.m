//
//  Core.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/28.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "Core.h"
#import "AFNetworking.h"

@implementation Core

//response 返回数据
+ (void)getHomeTimeLine:(void (^)(id response))block {
    
    /**
     *  1.URL
     *  2.请求参数
     */
    
    //1.URL
    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    //2.请求参数
    NSDictionary *parameters = @{@"access_token":kAccessToken};
    
    NSLog(@"%@",kAccessToken);
    //1.获取请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.设置请求参数的格式
    /**
     *  AFHTTPRequestSerializer 将请求参数格式化为&符号拼接
     *  AFJSONRequestSerializer 将请求参数格式化为JSON数据
     */
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //3.设置返回数据的格式
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //4.发送请求
    [manager GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //成功后调用的block
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //失败时，打印原因
        NSLog(@"失败原因：%@",error);
        
    }];
    
    
}
@end
