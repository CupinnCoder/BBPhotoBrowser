//
//  BBImageCropViewController.h
//  TimeFaceV2
//
//  Created by Melvin on 12/23/14.
//  Copyright (c) 2014 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBImageEditorFrame
@required
@property(nonatomic,assign) CGRect cropRect;
@end

typedef void(^BBImageCropDoneCallback)(UIImage *image, BOOL canceled);


@interface BBImageCropViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic,copy    ) BBImageCropDoneCallback   doneCallback;
@property (nonatomic,copy    ) UIImage                   *sourceImage;
@property (nonatomic,copy    ) UIImage                   *previewImage;
@property (nonatomic,assign  ) CGSize                    cropSize;
@property (nonatomic,assign  ) CGRect                    cropRect;
@property (nonatomic,assign  ) CGFloat                   outputWidth;
@property (nonatomic,assign  ) CGFloat                   minimumScale;
@property (nonatomic,assign  ) CGFloat                   maximumScale;

@property (nonatomic,assign  ) BOOL                      panEnabled;
@property (nonatomic,assign  ) BOOL                      rotateEnabled;
@property (nonatomic,assign  ) BOOL                      scaleEnabled;
@property (nonatomic,assign  ) BOOL                      tapToResetEnabled;
@property (nonatomic,assign  ) BOOL                      checkBounds;

@property (nonatomic,readonly) CGRect                    cropBoundsInSourceImage;

- (void)reset:(BOOL)animated;


@end
