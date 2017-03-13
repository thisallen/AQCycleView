//
//  AQCycleViewCell.m
//  AQCycleViewDemo
//
//  Created by Allen on 16/3/12.
//  Copyright © 2017年 Allen. All rights reserved.
//

#import "AQCycleViewCell.h"
#import "UIImageView+WebCache.h"

@interface AQCycleViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation AQCycleViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL]];
}

- (void)layoutSubviews{
    _imageView.frame = self.bounds;
}

@end
