//
//  BBLibraryCollectionOverlayView.m
//  BBPhotoBrowser
//
//  Created by Melvin on 1/4/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "BBLibraryCollectionOverlayView.h"

@interface BBLibraryCollectionOverlayView() {
    
}
@property (nonatomic, strong) UIImageView *checkmarkView;

@end

@implementation BBLibraryCollectionOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // View settings
        
        self.backgroundColor = [UIColor clearColor];
        
        // Create a checkmark view
        UIImage *image = [UIImage imageNamed:@"BBLibraryResource.bundle/images/BBLibraryCollectionUnSelected.png"];
        CGFloat imageWidth = image.size.width;
        _checkmarkView = [[UIImageView alloc] initWithImage:image];
        _checkmarkView.highlightedImage = [UIImage imageNamed:@"BBLibraryResource.bundle/images/BBLibraryCollectionSelected.png"];
        _checkmarkView.userInteractionEnabled = NO;
        _checkmarkView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 4 - imageWidth,4,  imageWidth, imageWidth);
        [self addSubview:_checkmarkView];
    }
    
    return self;
}

- (void)checkMark:(BOOL)selected {
    _checkmarkView.highlighted = selected;
}

@end
