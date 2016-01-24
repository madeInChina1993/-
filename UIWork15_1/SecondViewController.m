//
//  SecondViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailsMovieViewController.h"
#import "CollectionViewController.h"
#import "MovieList.h"
#import "SecondCell.h"
#import "UrlString.pch"
#import "ImageDownload.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电影";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.357 green:0.529 blue:0.624 alpha:1.000];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_list"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButton)];
    
    
    [self handleData];
    [self initLayout];
}


- (void)rightButton
{
    CollectionViewController *collect = [[CollectionViewController alloc]init];
    
    [self.navigationController pushViewController:collect animated:YES];
}


- (void)initLayout
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}


- (void)handleData
{
    self.dataArray = [NSMutableArray array];
    // 请求数据
    NSURL *url = [NSURL URLWithString:kMovie];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        // 遍历字典
        for (NSDictionary *dict in dic[@"result"]) {
            MovieList *movie = [MovieList new];
            [movie setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:movie];
        }
        
        
#warning 如果数据不显示,要把数据刷新放到主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [dataTask resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 1.拿到新值
    UIImage *newImage = change[NSKeyValueChangeNewKey];
    // 2.将取出的新值添加到cell上对应的下标
    NSArray *indexArray = [self.tableView indexPathsForVisibleRows];
    // 3.获取当前cell上的下标
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    // 4.判断是否包含在当前的数组中
    if ([indexArray containsObject:indexPath]) {
        SecondCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        // 如果包含,那么就将新的图片给image
        cell.aImageView.image = newImage;
        
    }
    // 观察者观察完毕,需要将观察者移除
    [object removeObserver:self forKeyPath:@"loadImage" context:(__bridge void * _Nullable)(indexPath)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SecondCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    
    MovieList *movieList = [MovieList new];
    movieList = self.dataArray[indexPath.section];
    
    cell.aLabel.text = movieList.movieName;
    
    
    [cell.movieIndicatorView startAnimating];
    // 异步加载图片
    
    if (movieList.loadImage == nil && movieList.isLoading == NO) { // 如果没有图片可以显示
        [cell.movieIndicatorView startAnimating];
        // 加载图片
        [movieList imageLoading];
        // 添加观察者
        [movieList addObserver:self forKeyPath:@"loadImage" options:NSKeyValueObservingOptionNew context:(__bridge void *_Nullable)(indexPath)];
        
    }else if(movieList.loadImage == nil){
        // 如果光是没有图片,表明正在加载,就让菊花一直转
        [cell.movieIndicatorView startAnimating];
    }else{
        // 最后一种情况是加载完成,将loadImage中的数据给cell
        cell.aImageView.image = movieList.loadImage;
    }
    
    [[ImageDownload shareImageDownload] imageDownloadWithString:movieList.pic_url returnImageBlock:^(NSData *data) {
        cell.aImageView.image = [UIImage imageWithData:data];
        [cell.movieIndicatorView stopAnimating];
        cell.movieIndicatorView.hidden = YES;
    }];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsMovieViewController *detailsMovie = [[DetailsMovieViewController alloc]init];
    
    MovieList *movie = [MovieList new];
    
    // 此 dataArray 传到 details 的 dataArray
    detailsMovie.dataArray = [NSMutableArray array];
    movie = self.dataArray[indexPath.section];
    [detailsMovie.dataArray addObjectsFromArray:self.dataArray];
    
    // 把每行内容传到DetailsMovieViewController
    detailsMovie.section = indexPath.section;
    
    detailsMovie.navigationItem.title = movie.movieName;
    
    [self.navigationController pushViewController:detailsMovie animated:YES];
    
}



@end
