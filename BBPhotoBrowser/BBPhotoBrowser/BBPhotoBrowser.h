//
//  BBPhotoBrowser.h
//  BBPhotoBrowser
//
//  Created by Gary on 8/28/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPhotoProtocol.h"
#import "BBPhoto.h"

#define kNoticeCustomBack           @"kNoticeCustomBack"

// Delgate
@protocol BBPhotoBrowserDelegate;

@class BBPhotoBrowser;
@class BBPhotoCaptionView;

@protocol BBPhotoBrowserDelegate <NSObject>
@optional
- (NSUInteger)numberOfPhotosInPhotoBrowser:(BBPhotoBrowser *)photoBrowser;
- (id <BBPhoto>)photoBrowser:(BBPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
- (id <BBPhoto>)photoBrowser:(BBPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (BBPhotoCaptionView *)photoBrowser:(BBPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(BBPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
- (BOOL)photoBrowser:(BBPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index section:(NSInteger)section;
- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index section:(NSInteger)section selectedChanged:(BOOL)selected;
- (void)photoBrowserDidFinishModalPresentation:(BBPhotoBrowser *)photoBrowser;
- (UIView *)photoBrowser:(BBPhotoBrowser *)photoBrowser toolBarViewForPhotoAtIndex:(NSUInteger)index;
- (NSDictionary*)photoBrowserSelecteNum;
//tag
- (NSMutableArray *)photoBrowser:(BBPhotoBrowser *)photoBrowser tagInfosAtIndex:(NSUInteger)index;
- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser updateTagInfo:(NSDictionary *)info index:(NSUInteger)index;
- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser infos:(NSMutableArray *)infos;
- (void)updatePhotoInfos:(NSMutableArray *)array photoAtIndex:(NSUInteger)index;
- (UINavigationController*)photoBrowser:(BBPhotoBrowser *)photoBrowser didSelectTagAtIndex:(NSInteger)index tagId:(NSString*)tagId;
@end


@interface BBPhotoBrowser : UIViewController<UIScrollViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) id<BBPhotoBrowserDelegate> delegate;
@property (nonatomic) BOOL zoomPhotosToFill;
@property (nonatomic) BOOL displayNavArrows;
@property (nonatomic) BOOL displayActionButton;
@property (nonatomic) BOOL displaySelectionButtons;
@property (nonatomic) BOOL alwaysShowControls;
@property (nonatomic) BOOL enableSwipeToDismiss;
@property (nonatomic) BOOL autoPlayOnAppear;
@property (nonatomic) NSUInteger delayToHideElements;
@property (nonatomic, readonly) NSUInteger currentIndex;

@property (nonatomic ,strong) NSIndexPath* indexPath;

// Customise image selection icons as they are the only icons with a colour tint
// Icon should be located in the app's main bundle
@property (nonatomic, strong) NSString *customImageSelectedIconName;
@property (nonatomic, strong) NSString *customImageSelectedSmallIconName;
@property (nonatomic, strong) UIView *customToolBarView;

//Animation
@property (nonatomic, weak) UIImage *scaleImage;
@property (nonatomic) BOOL usePopAnimation;
@property (nonatomic) float animationDuration;

//tag
@property (nonatomic, strong  ) NSMutableArray *tagInfos;
@property (nonatomic, strong  ) NSDictionary   *expandData;


// Init
- (id)initWithPhotos:(NSArray *)photosArray;
- (id)initWithDelegate:(id <BBPhotoBrowserDelegate>)delegate;


- (id)initWithPhotos:(NSArray *)photosArray animatedFromView:(UIView*)view;
- (id)initWithDelegate:(id <BBPhotoBrowserDelegate>)delegate animatedFromView:(UIView*)view;

/**
 *  配置当前page tag view
 *
 *  @param index
 */
- (void)configurePageTag:(NSUInteger)index;

// Reloads the photo browser and refetches data
- (void)reloadData;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;

// Navigation
- (void)showNextPhotoAnimated:(BOOL)animated;
- (void)showPreviousPhotoAnimated:(BOOL)animated;

@end

