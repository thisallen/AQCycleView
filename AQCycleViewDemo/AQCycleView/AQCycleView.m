//
//  AQCycleView.m
//  AQCycleViewDemo
//
//  Created by Allen on 16/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "AQCycleView.h"
#import "AQCycleViewCell.h"

static NSString * const cellID = @"AQCycleViewCell";

@interface AQCycleView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UICollectionViewFlowLayout *mainLayout;
@property (nonatomic, assign) BOOL isLocale;
@end

@implementation AQCycleView

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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView{
    [self addSubview:self.mainView];
}

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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_isLocale) {
        return _localImageArray.count;
    }else{
        return _webImageArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AQCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (_isLocale) {
        cell.imageName = _localImageArray[indexPath.item];
    }else{
        cell.imageURL = _webImageArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", indexPath.item);
}
@end
