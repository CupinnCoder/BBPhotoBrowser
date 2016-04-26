//
//  BBAssetImageFile.m
//  BBCamera
//
//  Created by Gary on 7/16/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBAssetImageFile.h"

@implementation BBAssetImageFile

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image {
    self = [self init];
    
    if (self) {
        self.path = path;
        self.image = image;
    }
    return self;
}

@end
