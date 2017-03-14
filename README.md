# 图片无限轮播器-最简单易用的轮播器
使用CollectionView实现View的重用，尽量使用最少代码，实现最多功能
##使用方法
1.下载文件夹，找到AQCyleView文件夹，拖入项目中
2.```
#import "AQCycleView.h"
    // 本地图片
    CGRect localImageFrame = CGRectMake(0, 64, ScreenSize.width, 200);
    NSArray *localImageArray = @[@"f1.jpg", @"f2.jpg", @"f3.jpg" , @"f4.jpg"];
    AQCycleView *localView = [AQCycleView cycleViewWithFrame:localImageFrame localImageArray:localImageArray];
    self.localView = localView;
    self.localView.isInfinite = NO;
    [self.view addSubview:self.localView];
    self.localView.delegate = self;
    
    // 网络图片
    CGRect webImageFrame = CGRectMake(0, 300, ScreenSize.width, 200);
    NSArray *webImageArray = @[@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/20/c0/16743571_1355973089354.jpg",
                               @"http://www.bz55.com/uploads/allimg/150331/140-150331153934.jpg",
                               @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1210/11/c3/14372065_1349940418555.jpg",
                               @"http://img.article.pchome.net/00/47/42/55/pic_lib/wm/01.jpg",
                               @"http://img.tupianzj.com/uploads/Bizhi/mn84_1366.jpg"];
//    AQCycleView *view2 = [AQCycleView cycleViewWithFrame:webImageFrame webImgaeArray:webImageArray];
    AQCycleView *webView = [[AQCycleView alloc] init];
    webView.frame = webImageFrame;
    self.webView = webView;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.webImageArray = webImageArray;
    
    ```
    
