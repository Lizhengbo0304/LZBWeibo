//
//  LeftViewController.m
//  LZBWeibo
//
//  Created by LiZhengbo on 15/10/27.
//  Copyright © 2015年 李正博. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray *_dataList;
    
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UITableView *leftTableView;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataList = [[ThemeManager singleInstance].themeConfiguration allKeys];
    
    [self loadTableView];
}

- (void)loadTableView {
    
    leftTableView.backgroundColor = [UIColor clearColor];
    
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    imageView.layer.cornerRadius = 50.0f;
    
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    imageView.layer.borderWidth = 3.0f;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:nil options:nil] lastObject];
                
    }
    
    cell.themeName.text = _dataList[indexPath.row];
    
    cell.themeIcon.image = [self getThemeIcon:_dataList[indexPath.row]];
    
    //获取当前的主题名称
    NSString *themeName = [ThemeManager singleInstance].themeName;
    
    if ([_dataList[indexPath.row] isEqualToString:themeName]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *themeName = _dataList[indexPath.row];
    
    [ThemeManager singleInstance].themeName = themeName;
    
    [leftTableView reloadData];
    
    [leftTableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (UIImage *)getThemeIcon:(NSString *)themeName {
    
    NSString *themeIcon = @"more_icon_account";
    
    //对应主题的路径
    NSString *path = [[NSBundle mainBundle]resourcePath];
    
    NSString *themePath = [path stringByAppendingPathComponent:[[ThemeManager singleInstance].themeConfiguration objectForKey:themeName]];
    
    NSString *imagePath = [themePath stringByAppendingPathComponent:themeIcon];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
    
    
    
    
}


@end
