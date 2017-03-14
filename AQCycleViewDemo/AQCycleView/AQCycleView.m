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
@property (nonatomic, assign) NSInteger totalImageCount;

@property (nonatomic, strong) UILabel *pageNumLabel;
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
    [self addSubview:self.pageNumLabel];
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
    [self setupNewStatus];
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isAutoScroll = isAutoScroll;
    [self setupNewStatus];
}

- (void)setupNewStatus{
    if (_imageCount && _isInfinite == NO) {
        _totalImageCount = _imageCount;
    }
    if (_mainView) {
        [_mainView reloadData];
    }
}

#pragma mark -- 手动设置图片数组
- (void)setLocalImageArray:(NSArray *)localImageArray{
    _localImageArray = localImageArray;
    _isLocale = YES;
    _imageCount = _localImageArray.count;
    _totalImageCount = _isInfinite ? _imageCount * imageCountScale : _imageCount;
    if (_mainView) {
        [_mainView reloadData];
    }
}

- (void)setWebImageArray:(NSArray *)webImageArray{
    _webImageArray = webImageArray;
    _isLocale = NO;
    _imageCount = _webImageArray.count;
    _totalImageCount = _isInfinite ? _imageCount * imageCountScale : _imageCount;
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

- (UILabel *)pageNumLabel{
    if (_pageNumLabel ==nil) {
        UILabel *pageNumLabel = [[UILabel alloc] init];
        pageNumLabel.text = @"1/4";
        pageNumLabel.textColor = [UIColor whiteColor];
        _pageNumLabel = pageNumLabel;
    }
    return _pageNumLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainLayout.itemSize = self.bounds.size;
    _mainView.frame = self.bounds;
    _pageNumLabel.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30);
    if (_isInfinite && _mainView.contentOffset.x == 0 && _totalImageCount > 0) {
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalImageCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
};

#pragma mark -- 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AQCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (_isLocale) {
        cell.imageName = _localImageArray[[self itemIndex:indexPath]];
    }else{
        cell.imageURL = _webImageArray[[self itemIndex:indexPath]];
    }
    return cell;
}

#pragma mark -- 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectItemAtIndexPath:)]) {
        [self.delegate cycleView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:[self itemIndex:indexPath] inSection:indexPath.section]];
    }
}

#pragma mark -- 计算当前的itemIndex
- (NSInteger)itemIndex:(NSIndexPath *)indexPath{
    NSInteger itemIndex = _isInfinite ? indexPath.item % (_totalImageCount/imageCountScale) : indexPath.item;
    NSLog(@"%ld", itemIndex);
    return _isInfinite ? indexPath.item % (_totalImageCount/imageCountScale) : indexPath.item;
}
@end
