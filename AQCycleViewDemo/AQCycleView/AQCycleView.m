//
//  AQCycleView.m
//  AQCycleViewDemo
//
//  Created by Allen on 16/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "AQCycleView.h"
#import "AQCycleViewCell.h"

#define imageCountScale 100

static NSString * const cellID = @"AQCycleViewCell";

@interface AQCycleView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *mainLayout;
@property (nonatomic, assign) BOOL isLocale;
@property (nonatomic, assign) NSInteger imageCount;

@end

@implementation AQCycleView

#pragma mark -- 快捷创建方法
+ (instancetype)cycleViewWithFrame:(CGRect)frame localImageArray:(NSArray *)localImageArray{
    AQCycleView *view = [[AQCycleView alloc] initWithFrame:frame];
    view.localImageArray = localImageArray;
    
    return view;
};

+ (instancetype)cycleViewWithFrame:(CGRect)frame webImgaeArray:(NSArray *)webImageArray{
    AQCycleView *view = [[AQCycleView alloc] initWithFrame:frame];
    view.webImageArray = webImageArray;
    
    return view;
}

#pragma mark -- INIT
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView{
    [self setupDefaultConfig];

    [self addSubview:self.mainView];
}

#pragma mark -- 设置无限轮播和自动滚动
- (void)setupDefaultConfig{
    _isInfinite = YES;
    _isAutoScroll = YES;
    _imageCount = 0;
    if (_mainView) {
        [_mainView reloadData];
    }
}

- (void)setIsInfinite:(BOOL)isInfinite{
    _isInfinite = isInfinite;
    if (_mainView) {
        [_mainView reloadData];
    }
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isAutoScroll = isAutoScroll;
    if (_mainView) {
        [_mainView reloadData];
    }
}

#pragma mark -- 手动设置图片数组
- (void)setLocalImageArray:(NSArray *)localImageArray{
    _localImageArray = localImageArray;
    _isLocale = YES;
    if (_mainView) {
        [_mainView reloadData];
    }
}

- (void)setWebImageArray:(NSArray *)webImageArray{
    _webImageArray = webImageArray;
    _isLocale = NO;
    if (_mainView) {
        [_mainView reloadData];
    }
}

#pragma mark -- 主界面相关
- (UICollectionView *)mainView{
    if (_mainView == nil) {
        
        _mainLayout = [[UICollectionViewFlowLayout alloc] init];
        _mainLayout.minimumLineSpacing = 0.f;
        _mainLayout.minimumInteritemSpacing = 0.f;
        _mainLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_mainLayout];
        _mainView.pagingEnabled = YES;
        _mainView.delegate = self;
        _mainView.dataSource = self;
        [_mainView registerClass:[AQCycleViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _mainView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainLayout.itemSize = self.bounds.size;
    _mainView.frame = self.bounds;
};

#pragma mark -- 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_isLocale) {
        _imageCount = _localImageArray.count;
    }else{
        _imageCount = _webImageArray.count;
    }
    if (_isInfinite) {
        _imageCount = _imageCount * imageCountScale;
    }
    return _imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AQCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item % (_imageCount/imageCountScale);
    if (_isLocale) {
        cell.imageName = _localImageArray[itemIndex];
    }else{
        cell.imageURL = _webImageArray[itemIndex];
    }
    return cell;
}

#pragma mark -- 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", indexPath.item);
}

#pragma mark -- 计算当前的itemIndex
- (NSInteger)itemIndex:(NSIndexPath *)indexPath{
    NSInteger itemIndex;
    
    return itemIndex;
}
@end
