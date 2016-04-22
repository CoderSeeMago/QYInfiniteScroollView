//
//  QYInfiniteScroollView.h
//  图片轮播器(基于collectionView的封装)
//
//  Created by 赵清岩 on 16/4/21.
//  Copyright © 2016年 QingYan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYInfiniteScroollView;

@protocol QYInfiniteScroollViewDlegate <NSObject>
@optional
- (void)infiniteScroollViewDlegate:(QYInfiniteScroollView *)QYInfiniteScroollView andDidClickImageAtIndex:(NSInteger)index;

@end


@interface QYInfiniteScroollView : UIView

/** 提供图片数据 接口 */
@property (nonatomic, strong) NSArray *imageArray;


/** 占位图片*/
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, weak) id delegate;
@end
