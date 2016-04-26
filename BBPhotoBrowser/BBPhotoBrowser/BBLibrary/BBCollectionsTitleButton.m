//
//  BBCollectionsTitleButton.m
//  BBPhotoBrowser
//
//  Created by Melvin on 2/16/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "BBCollectionsTitleButton.h"

@implementation BBCollectionsTitleButton

- (CGSize)sizeThaBBits:(CGSize)size {
    size = [super sizeThatFits:size];
    size.width += self.titleEdgeInsets.right + self.titleEdgeInsets.left + self.imageEdgeInsets.right + self.imageEdgeInsets.left;
    
    return size;
}

- (CGRect)imageRecBBorContentRect:(CGRect)contentRect {
    CGRect frame = [super imageRectForContentRect:contentRect];
    frame.origin.x = CGRectGetMaxX(contentRect) - CGRectGetWidth(frame) - self.imageEdgeInsets.right + self.imageEdgeInsets.left;
    return frame;
}

- (CGRect)titleRecBBorContentRect:(CGRect)contentRect {
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = CGRectGetMinX(frame) - CGRectGetWidth([self imageRecBBorContentRect:contentRect]);
    return frame;
}

@end
