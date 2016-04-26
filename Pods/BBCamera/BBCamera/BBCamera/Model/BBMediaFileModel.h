//
//  BBMediaFileModel.h
//  BBCamera
//
//  Created by Gary on 7/28/15.
//  Copyright © 2015 Gary. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSInteger, BBMediaFileType) {
    BBMediaFileTypePhoto = 0,
    BBMediaFileTypeVideo
};

@interface BBMediaFileModel : NSObject

@property (nonatomic ,strong) NSString        *title;
@property (nonatomic ,strong) NSString        *desc;
@property (nonatomic ,strong) UIImage         *image;
@property (nonatomic ,strong) NSString        *path;
@property (nonatomic ,assign) BBMediaFileType fileType;

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image;
- (instancetype)initWithPath:(NSString *)path fileType:(BBMediaFileType)fileType;

@end
