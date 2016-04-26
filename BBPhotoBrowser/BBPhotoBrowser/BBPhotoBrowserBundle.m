//
//  BBPhotoBrowserBundle.m
//  BBPhotoBrowser
//
//  Created by Melvin on 2/16/16.
//  Copyright © 2016 TimeFace. All rights reserved.
//

#import "BBPhotoBrowserBundle.h"
#import "BBPhotoBrowser.h"

NSBundle *BBPhotoBrowserBundle() {
    return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[BBPhotoBrowser class]] URLForResource:@"BBLibraryResource" withExtension:@"bundle"]];
}

UIImage *BBPhotoBrowserImageNamed(NSString *imageName) {
    //    @"BBLibraryResource.bundle/images/"
    return [UIImage imageNamed:[@"BBLibraryResource.bundle/images/" stringByAppendingString:imageName]];
//    return [UIImage imageNamed:imageName inBundle:BBPhotoBrowserBundle() compatibleWithTraitCollection:nil];
}

