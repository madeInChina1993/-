//
//  CollectionViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "CollectionViewController.h"
#import "SecondViewController.h"
#import "CollectionCell.h"
#import "MovieList.h"
#import "UIImageView+WebCache.h"
#import "DetailsMovieViewController.h"
#import "MovieDetails.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_collection"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButton)];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    // 设置分区的上下左右距离
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 10, 20, 10);
    
    // 初始化集合视图
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    // 设置集合视图的背景颜色
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.76 blue:0.6 alpha:1];
    [self.view addSubview:self.collectionView];
    
    // 设置数据源对象及代理对象
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // 注册
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.dataArray = [NSMutableArray array];
}

- (void)rightButton
{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}


// 懒加载
- (NSMutableArray *)dataArray
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MovieList.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *dict in dictionary[@"result"]) {
        MovieList *movie = [MovieList new];
        [movie setValuesForKeysWithDictionary:dict];
        [_dataArray addObject:movie];
    }
    return _dataArray;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self. dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    MovieList *movie = self.dataArray[indexPath.item];
    
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url]];
    
    cell.nameLabel.text = movie.movieName;
    
    return cell;
}

// 设置集合分区中有几个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark --- delegate方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 200);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsMovieViewController *detailsVC = [[DetailsMovieViewController alloc]init];
    MovieList *movie =[MovieList new];
    movie = self.dataArray[indexPath.item];
    detailsVC.dataArray = [NSMutableArray array];
    
//    detailsVC.movieid = movie.movieId;
//    NSLog(@"%@",detailsVC.movieid);
    
    [detailsVC.dataArray addObjectsFromArray:self.dataArray];
    detailsVC.section = indexPath.item;
    
    
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}



@end
