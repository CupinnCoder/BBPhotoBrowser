//
//  BBZoomingScrollView.h
//  BBPhotoBrowser
//
//  Created by Melvin on 9/1/15.
//  Copyright © 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPhotoProtocol.h"


@class BBPhotoBrowser,BBPhoto,BBPhotoCaptionView,BBTapDetectingImageView,BBPhotoTagView;
@interface BBZoomingScrollView : UIScrollView

@property () NSUInteger index;
@property (nonatomic) id <BBPhoto> photo;
@property (nonatomic, weak) BBPhotoCaptionView *captionView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIButton *playButton;
@property (nonatomic, strong) BBTapDetectingImageView *photoImageView;

- (id)initWithPhotoBrowser:(BBPhotoBrowser *)browser;
- (void)displayImage;
- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;
- (BOOL)displayingVideo;
- (void)setImageHidden:(BOOL)hidden;

/**
 *  图片复位
 */
- (void)imageRest;

- (void)faceFeature;

- (void)removeAllTags;

- (CGPoint)normalizedPositionForPoint:(CGPoint)point;

- (void)startNewTagPopover:(BBPhotoTagView *)popover atNormalizedPoint:(CGPoint)normalizedPoint pointOnImage:(CGPoint)pointOnImage size:(CGSize)sizeOnImage;

@end
