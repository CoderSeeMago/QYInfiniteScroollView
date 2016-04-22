//
//  ViewController.m
//  图片轮播器(基于collectionView的封装)
//
//  Created by 赵清岩 on 16/4/21.
//  Copyright © 2016年 QingYan. All rights reserved.
//

#import "ViewController.h"
#import "QYInfiniteScroollView.h"

@interface ViewController ()<QYInfiniteScroollViewDlegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QYInfiniteScroollView *infiniteScrollView = [[QYInfiniteScroollView alloc]init];
    
    infiniteScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);

    infiniteScrollView.imageArray = @[
                                      [UIImage imageNamed:@"img_00"],
                                      [UIImage imageNamed:@"img_01"],
                                      [NSURL URLWithString:@"http://tupian.enterdesk.com/2013/mxy/12/10/15/3.jpg"],
                                      [UIImage imageNamed:@"img_03"],
                                      [NSURL URLWithString:@"http://pic4.nipic.com/20091215/2396136_140959028451_2.jpg"]
                                      ];
    infiniteScrollView.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:infiniteScrollView];
    
    
    infiniteScrollView.delegate = self;
}

- (void)infiniteScroollViewDlegate:(QYInfiniteScroollView *)QYInfiniteScroollView andDidClickImageAtIndex:(NSInteger)index
{
    NSLog(@"test");
    NSLog(@"%zd", index);
}
/*
 2016-04-21 20:14:50.339 图片轮播器(基于collectionView的封装)[10360:2308953] -[QYInfiniteScroollView initWithFrame:]
 2016-04-21 20:14:50.375 图片轮播器(基于collectionView的封装)[10360:2308953] -[QYInfiniteScroollView setImageArray:]
 2016-04-21 20:14:50.378 图片轮播器(基于collectionView的封装)[10360:2308953] -[QYInfiniteScroollView layoutSubviews]
 2016-04-21 20:14:50.379 图片轮播器(基于collectionView的封装)[10360:2308953] -[QYInfiniteScroollView collectionView:cellForItemAtIndexPath:]
 
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
