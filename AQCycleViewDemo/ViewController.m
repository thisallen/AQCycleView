//
//  ViewController.m
//  AQCycleViewDemo
//
//  Created by Allen on 17/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "ViewController.h"
#import "AQCycleView.h"

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 本地图片
    CGRect localImageFrame = CGRectMake(0, 64, ScreenSize.width, 200);
    NSArray *localImageArray = @[@"f1.jpg", @"f2.jpg", @"f3.jpg" , @"f4.jpg", @"f5.jpg"];
    AQCycleView *view = [AQCycleView cycleViewWithFrame:localImageFrame localImageArray:localImageArray];
    NSLog(@"%@", view);
    [self.view addSubview:view];
    
    // 网络图片
    CGRect webImageFrame = CGRectMake(0, 300, ScreenSize.width, 200);
    NSArray *webImageArray = @[@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/20/c0/16743571_1355973089354.jpg",
                               @"http://www.bz55.com/uploads/allimg/150331/140-150331153934.jpg",
                               @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1210/11/c3/14372065_1349940418555.jpg",
                               @"http://img.article.pchome.net/00/47/42/55/pic_lib/wm/01.jpg",
                               @"http://img.tupianzj.com/uploads/Bizhi/mn84_1366.jpg"];
    AQCycleView *view2 = [AQCycleView cycleViewWithFrame:webImageFrame webImgaeArray:webImageArray];
    NSLog(@"%@", view2);
    [self.view addSubview:view2];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
