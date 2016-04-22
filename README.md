# QYInfiniteScroollView
## 基本用法 
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
这是一个图片无限轮播器
