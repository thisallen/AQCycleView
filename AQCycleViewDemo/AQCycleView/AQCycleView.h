//
//  AQCycleView.h
//  AQCycleViewDemo
//
//  Created by Allen on 16/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AQCycleView;
@protocol AQCycleViewDelegate <NSObject>

- (void)cycleView:(AQCycleView *)cycleView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AQCycleView : UIView
/**
 代理属性
 */
@property (nonatomic, weak) id<AQCycleViewDelegate> delegate;

/**
 手动添加本地图片数组
 */
@property (nonatomic, strong) NSArray *localImageArray;

/**
 手动添加网络图片数组
 */
@property (nonatomic, strong) NSArray *webImageArray;

/**
 是否无限循环，默认为YES
 */
@property (nonatomic, assign) BOOL isInfinite;

/**
 是否自动滚动，默认为YES
 */
@property (nonatomic, assign) BOOL isAutoScroll;

/**
 快捷添加本地图片轮播，默认为无限轮播

 @param frame 轮播的Frame
 @param localImageArray 本地图片的数组
 @return 返回view实例
 */
+ (instancetype)cycleViewWithFrame:(CGRect)frame localImageArray:(NSArray *)localImageArray;

/**
 快捷添加网络图片轮播，默认为无限轮播
 
 @param frame 轮播的Frame
 @param webImageArray 网络图片的数组
 @return 返回view实例
 */
+ (instancetype)cycleViewWithFrame:(CGRect)frame webImgaeArray:(NSArray *)webImageArray;
@end
