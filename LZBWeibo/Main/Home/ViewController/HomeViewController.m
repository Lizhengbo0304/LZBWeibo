//
//  HomeViewController.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "WeiboTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    
    NSMutableArray *_dataList;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataList = [NSMutableArray array];

    //加载数据
    [self loadData];
    
    //加载表视图
    [self loadTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    
    [Core getHomeTimeLine:^(id response) {
       
        for (NSDictionary *dic in [response objectForKey:@"statuses"]) {
            
            WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dic];
            
            UserModel *userModel = [[UserModel alloc]initWithDataDic:[dic objectForKey:@"user"]];
            
            RepostWeiboModel *repostModel = nil;
            
            if ([dic objectForKey:@"retweeted_status"]) {
                
                 repostModel = [[RepostWeiboModel alloc]initWithDataDic:[dic objectForKey:@"retweeted_status"]];
                
                RepostUserModel *repostUserModel = [[RepostUserModel alloc]initWithDataDic:[[dic objectForKey:@"retweeted_status"] objectForKey:@"user"]];
                
                repostModel.repostUserModel = repostUserModel;
            }
            
            model.user = userModel;
            
            model.repostModel = repostModel;
            
            [_dataList addObject:model];
        }
        
        [_tableView reloadData];
        
    }];
}

- (void)loadTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiboView *weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(0, 0, 304, 0)];
    
    weiboView.model = _dataList[indexPath.row];
    
    if (weiboView.model.repostModel) {
        
        return 71 + weiboView.reImageView.bottom + weiboView.imageView.bottom;
    }

    return 71 + weiboView.imageView.bottom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"HomeCell";
    
    WeiboTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WeiboTableViewCell" owner:nil options:nil]lastObject];
    }
    
    cell.model = _dataList[indexPath.row];
    
    return cell;
}
@end
