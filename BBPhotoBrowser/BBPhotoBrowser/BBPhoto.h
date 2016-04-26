//
//  BBPhoto.h
//  BBPhotoBrowser
//  图片模型
//  Created by Melvin on 8/28/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "BBPhotoProtocol.h"

@interface BBPhotoTag : NSObject

@property (nonatomic, assign) CGRect     tagRect;

@property (nonatomic, strong) NSString   *tagName;

@property (nonatomic, strong) NSString   *tagId;

@property (nonatomic, strong) NSString   *faceId;

@property (nonatomic, assign) BOOL       selected;

@property (nonatomic, assign) NSInteger  imageOption;

+(BBPhotoTag *)photoTagWithRect:(CGRect)rect tagId:(NSString*)tagId tagName:(NSString*)tagName;

@end

@protocol BBPhotoTag;

@interface BBPhoto : NSObject <BBPhoto>

typedef void (^BBProgressUpdateBlock)(CGFloat progress);


@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic) BOOL emptyImage;
@property (nonatomic) BOOL isVideo;
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) NSMutableArray<BBPhotoTag>  *tagArray;


+ (BBPhoto *)photoWithImage:(UIImage *)image;
+ (BBPhoto *)photoWithURL:(NSURL *)url;
+ (BBPhoto *)photoWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
+ (BBPhoto *)videoWithURL:(NSURL *)url; // Initialise video with no poster image

- (id)init;
- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;
- (id)initWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
- (id)initWithVideoURL:(NSURL *)url;

@end
