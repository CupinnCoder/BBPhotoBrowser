//
//  BBLibraryViewLayout.m
//  BBPhotoBrowser
//
//  Created by Gary on 12/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBLibraryViewLayout.h"

const static CGFloat kMaxSize = 122;

@implementation BBLibraryViewLayout

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    CGFloat size = (CGRectGetWidth([[UIScreen mainScreen] bounds]) - 40 ) / 4;
    size = MIN(kMaxSize, size);
    [self setItemSize:(CGSize){ size, size }];
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self setSectionInset:UIEdgeInsetsMake(6, 6, 6, 6)];
    [self setMinimumLineSpacing:6];
    [self setMinimumInteritemSpacing:6];
}


@end
