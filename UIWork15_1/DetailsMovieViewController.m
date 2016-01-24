//
//  DetailsMovieViewController.m
//  UIWork15_1
//
//  Created by lanou3g on 16/1/17.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "DetailsMovieViewController.h"
#import "MovieList.h"
#import "MovieDetails.h"
#import "UrlString.pch"
#import "UIImageView+WebCache.h"

@interface DetailsMovieViewController ()

@end

@implementation DetailsMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_share"] style:(UIBarButtonItemStyleDone) target:self action:@selector(rightButton)];
    
    
    // 该数组用于判断是否是收藏过的电影,下面会用到
    self.array = [NSMutableArray array];
    
    [self handleData];
    
}

- (void)handleData{
    // 获取电影列表每个cell里的movieId
    MovieList *movieList = [MovieList new];
    movieList = self.dataArray[self.section];
    
    
    // 请求数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMovieDetail,movieList.movieId]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dic = dict[@"result"];
        MovieDetails *movieDetails = [MovieDetails new];
        [movieDetails setValuesForKeysWithDictionary:dic];
        NSLog(@"%@",movieDetails.country);
        
        // 如果数据不显示,要把数据刷新放到主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.ratingLabel.text = [NSString stringWithFormat:@"评分: %@",movieDetails.rating];
            self.ratingCountLabel.text = [NSString stringWithFormat:@"(%@评论)",movieDetails.rating_count];
            self.dateLabel.text = movieDetails.release_date;
            self.runTimeLabel.text = [NSString stringWithFormat:@"%@min",movieDetails.runtime];
            self.genresLabel.text = movieDetails.genres;
            self.countryLabel.text = movieDetails.film_locations;
            self.actorsLabel.text = movieDetails.actors;
            self.plotSimpleLabel.text = movieDetails.plot_simple;
            
            
            NSURL *picUrl = [NSURL URLWithString:movieDetails.poster];
            
#warning 研究研究图片能不能存进文件里,下载之后从文件调取
            [self.aImageView sd_setImageWithURL:picUrl placeholderImage:nil options:(SDWebImageCacheMemoryOnly)];
            //    [self.aImageView sd_setImageWithURL:picUrl];
            
            // scrollView自适应高度
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, [self scrollViewHeight:movieDetails.plot_simple] + self.scrollView.frame.size.height/3*2);
            
            // contentLabel的自适应高度
            CGFloat plotSimpleLabelX = CGRectGetMinX(self.aImageView.frame);
            CGFloat plotSimpleLabelY = CGRectGetMaxY(self.aImageView.frame);
            CGFloat plotSimpleLabelW = self.scrollView.frame.size.width - 50;
            CGFloat plotSimpleLabelH = [self scrollViewHeight:movieDetails.plot_simple];
            self.plotSimpleLabel.frame = CGRectMake(plotSimpleLabelX, plotSimpleLabelY, plotSimpleLabelW, plotSimpleLabelH);
        });
    }];
    
    [dataTask resume];
    
    
}

// contentLabel的自适应高度方法
- (CGFloat)scrollViewHeight:(NSString *)aString
{
    CGRect temp = [aString boundingRectWithSize:CGSizeMake(self.scrollView.frame.size.width - 50, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return temp.size.height;
}

//movieName路径
- (NSString *)movieFilePath
{
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"movieName.txt"];
    return path;
}

//判断有没有数据
- (id)allMovieList
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [self movieFilePath];
    if (![manager fileExistsAtPath:path]) {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    // 创建反归档对象
    NSData *myData = [NSData dataWithContentsOfFile:path];
    
    // 创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:myData];
    id result =  [unarchiver decodeObjectForKey:@"result"];
    
    // 完成反归档
    [unarchiver finishDecoding];
    return result;
}

//收藏电影
- (void)collectMovie
{
    NSMutableArray *allMovies = [self allMovieList];
    if (allMovies == nil) {
        allMovies = [[NSMutableArray alloc]init];
    }
    [allMovies addObject:self.navigationItem.title];
    
    NSMutableData *data = [NSMutableData data];
    // 2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    // 3.开始归档
    [archiver encodeObject:allMovies forKey:@"result"];
    
    // 4.完成归档
    [archiver finishEncoding];
    
    // 5.写入文件
    NSString *path = [self movieFilePath];
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        NSLog(@"归档成功%@",[self movieFilePath]);
    }
}

- (void)showCollectedAlert:(BOOL)bCollect
{
    if (bCollect) {
        UIAlertController *bLert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已收藏过此电影" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:bLert animated:YES completion:nil];
        
        UIAlertAction *bAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        
        [bLert addAction:bAction];
    } else {
        UIAlertController *aLert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:aLert animated:YES completion:nil];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)rightButton {
    NSMutableArray *allMovies = [self allMovieList];
    
#pragma mark --- Alert提示 ---
    // 如果没有收藏过
    if (![allMovies containsObject:self.navigationItem.title]) {
        [self collectMovie];
        [self showCollectedAlert:NO];
        
        // 如果收藏过
    } else {
        [self showCollectedAlert:YES];
    }
}

@end

