//
//  BBMediaFileModel.m
//  BBCamera
//
//  Created by Gary on 7/28/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBMediaFileModel.h"

@implementation BBMediaFileModel

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image {
    self = [self init];
    if (self) {
        self.path  = path;
        self.image = image;
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path fileType:(BBMediaFileType)fileType {
    self = [self init];
    if (self) {
        self.path     = path;
        self.fileType = fileType;
    }
    return self;
}
@end
