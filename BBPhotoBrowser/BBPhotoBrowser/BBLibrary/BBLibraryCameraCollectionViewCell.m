//
//  BBLibraryCameraCollectionViewCell.m
//  BBPhotoBrowser
//
//  Created by Melvin on 1/5/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "BBLibraryCameraCollectionViewCell.h"

@implementation BBLibraryCameraCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BBLibraryResource.bundle/images/BBLibraryCollectionOpenCamera.png"]];
        imageView.center = self.contentView.center;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)startCamera {
    
}
- (void)removeCamera {
    
}
@end
