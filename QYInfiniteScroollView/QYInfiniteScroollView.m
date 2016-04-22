//
//  QYInfiniteScroollView.m
//  图片轮播器(基于collectionView的封装)
//
//  Created by 赵清岩 on 16/4/21.
//  Copyright © 2016年 QingYan. All rights reserved.
//

#import "QYInfiniteScroollView.h"

#import "UIImageView+WebCache.h"



//******************cell begin*******************
@interface QYCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic)  UIImageView *imageView;

@end

@implementation QYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        [self addSubview:imageView];
        
        self.imageView = imageView;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
}

@end

//******************cell end*******************
static NSString * const collectionViewID = @"infinite";

static NSInteger QYItemCount = 100;

@interface QYInfiniteScroollView ()<UICollectionViewDataSource, UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** 定时器*/
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation QYInfiniteScroollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        //初始化流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        
        //设置滚动方向 为水平滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //设置item间距为0
        layout.minimumLineSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        //设置collectionView的数据源代理
        collectionView.dataSource = self;
        //设置collectionView代理
        collectionView.delegate = self;
        //隐藏水平垂直滚动条
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        //翻页功能
        collectionView.pagingEnabled = YES;
        //自定义cell 注册cell
        
//        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collectionViewID];
        
        [collectionView registerClass:[QYCollectionViewCell class]forCellWithReuseIdentifier:collectionViewID];
        //添加collectionView到view上
        
        [self addSubview:collectionView];
        
        self.collectionView = collectionView;
        //***********************以上是初始化设置************************************
        //默认显示中间的item
        
//        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:QYItemCount / 2 inSection:0]
//                               atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        
//        [self startTimer];
        
        self.placeholderImage = [UIImage imageNamed:@"QYInfiniteScroollView.bundle/placeholderImage"];
        
        
    }
    
    NSLog(@"%s", __func__);
    
    return self;

}

- (void)setImageArray:(NSArray *)imageArray
{
    
    _imageArray = imageArray;
    
    NSLog(@"%s", __func__);
    [self startTimer];
}
    
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.collectionView.frame = self.bounds;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    //设置item的大小
    layout.itemSize = self.bounds.size;
    
       [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(QYItemCount * self.imageArray.count / 2 )inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    NSLog(@"%s", __func__);
    //layoutSubviews 在cellForItemAtIndexPath:之前调用
}
    

    

#pragma - mark 定时器
- (void)startTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)nextPage
{
    
//    //自己的方法
//    NSInteger newItem = self.collectionView.contentOffset.x / self.bounds.size.width + 1;
//    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:newItem inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    //MJ方法
    
        CGPoint offset = self.collectionView.contentOffset;
    
        offset.x += self.collectionView.bounds.size.width;
    
    
        [self.collectionView setContentOffset:offset animated:YES];
    
    
}
#pragma - mark DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return QYItemCount * self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewID forIndexPath:indexPath];

    id data = self.imageArray[indexPath.item % self.imageArray.count];
    if ([data isKindOfClass:[NSURL class]]) {
        [cell.imageView sd_setImageWithURL:data placeholderImage:self.placeholderImage];
    }else if ([data isKindOfClass:[UIImage class]]) {
        cell.imageView.image = data;
    }

//    NSLog(@"%zd", indexPath.item);
    
    NSLog(@"%s", __func__);
    return cell;
    
}
#pragma - mark Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(infiniteScroollViewDlegate:andDidClickImageAtIndex:)]) {
        [self.delegate infiniteScroollViewDlegate:self andDidClickImageAtIndex:indexPath.item % self.imageArray.count];
    }
}

- (void)resetPosition
{
    NSInteger oldItem = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    
    NSInteger newItem = (QYItemCount * self.imageArray.count / 2) + (oldItem % self.imageArray.count);
    //只有当oldItem大于等于55 是重新置于中间 (oldItem 一开始就是 50)
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:newItem inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
//滚动完毕的时候调用(认为拖拽)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self resetPosition];
//    NSLog(@"%s", __func__);
    
}

//使用代码滚动完毕会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetPosition];
//    NSLog(@"%s", __func__);
}

#pragma - mark 定时器相关
//当人为拖拽的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
