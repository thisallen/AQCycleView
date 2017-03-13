//
//  AQCycleView.h
//  AQCycleViewDemo
//
//  Created by Allen on 16/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AQCycleView : UIView
@property (nonatomic, strong) NSArray *localImageArray;
@property (nonatomic, strong) NSArray *webImageArray;

+ (instancetype)cycleViewWithFrame:(CGRect)frame localImageArray:(NSArray *)localImageArray;

+ (instancetype)cycleViewWithFrame:(CGRect)frame webImgaeArray:(NSArray *)webImageArray;
@end
