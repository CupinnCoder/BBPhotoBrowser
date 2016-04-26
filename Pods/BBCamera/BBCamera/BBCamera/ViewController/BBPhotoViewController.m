//
//  BBPhotoViewController.m
//  BBCamera
//
//  Created by Gary on 7/17/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import "BBPhotoViewController.h"

#import "BBPhotoViewController.h"
#import "BBAssetsLibrary.h"
#import "BBCameraColor.h"
#import "BBCameraFilterView.h"
#import "UIImage+CameraFilters.h"
#import "BBTintedButton.h"

static NSString* const kBBCacheSatureKey   = @"BBCacheSatureKey";
static NSString* const kBBCacheCurveKey    = @"BBCacheCurveKey";
static NSString* const kBBCacheVignetteKey = @"BBCacheVignetteKey";


@interface BBPhotoViewController ()

@property (nonatomic ,strong) IBOutlet UIImageView        *photoView;
@property (nonatomic ,strong) IBOutlet UIView             *bottomView;
@property (nonatomic ,strong) IBOutlet BBCameraFilterView *filterView;
@property (nonatomic ,strong) IBOutlet UIButton           *defaulBBilterButton;
@property (nonatomic ,strong) IBOutlet BBTintedButton     *filterWandButton;
@property (nonatomic ,strong) IBOutlet NSLayoutConstraint *topViewHeight;
@property (nonatomic ,strong) UIView             *detailFilterView;
@property (nonatomic ,strong) UIImage            *photo;
@property (nonatomic ,strong) NSCache            *cachePhoto;

@property (weak) id<BBCameraDelegate> delegate;
@property (nonatomic) BOOL albumPhoto;

- (IBAction)backTapped;
- (IBAction)confirmTapped;
- (IBAction)filtersTapped;

- (IBAction)defaulBBilterTapped:(UIButton *)button;
- (IBAction)satureFilterTapped:(UIButton *)button;
- (IBAction)curveFilterTapped:(UIButton *)button;
- (IBAction)vignetteFilterTapped:(UIButton *)button;

- (void)addDetailViewToButton:(UIButton *)button;
+ (instancetype)newController;

@end



@implementation BBPhotoViewController

+ (instancetype)newWithDelegate:(id<BBCameraDelegate>)delegate photo:(UIImage *)photo
{
    BBPhotoViewController *viewController = [BBPhotoViewController newController];
    
    if (viewController) {
        viewController.delegate = delegate;
        viewController.photo = photo;
        viewController.cachePhoto = [[NSCache alloc] init];
    }
    
    return viewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) <= 480) {
        _topViewHeight.constant = 0;
    }
    
    _photoView.clipsToBounds = YES;
    _photoView.image = _photo;
    
    if ([[BBCamera getOption:kBBCameraOptionHiddenFilterButton] boolValue] == YES) {
        _filterWandButton.hidden = YES;
    }
    
    [self addDetailViewToButton:_defaulBBilterButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc
{
    _photoView = nil;
    _bottomView = nil;
    _filterView = nil;
    _defaulBBilterButton = nil;
    _detailFilterView = nil;
    _photo = nil;
    _cachePhoto = nil;
}

#pragma mark -
#pragma mark - Controller actions

- (IBAction)backTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmTapped
{
    if ( [_delegate respondsToSelector:@selector(cameraWillTakePhoto)]) {
        [_delegate cameraWillTakePhoto];
    }
    
    if ([_delegate respondsToSelector:@selector(cameraDidTakePhoto:)]) {
        _photo = _photoView.image;
        
        if (_albumPhoto) {
            [_delegate cameraDidSelectAlbumPhoto:_photo];
        } else {
            [_delegate cameraDidTakePhoto:_photo];
        }
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        BBAssetsLibrary *library = [BBAssetsLibrary defaultAssetsLibrary];
        
        void (^saveJPGImageAtDocumentDirectory)(UIImage *) = ^(UIImage *photo) {
            [library saveJPGImageAtDocumentDirectory:_photo resultBlock:^(NSURL *assetURL) {
                [_delegate cameraDidSavePhotoAtPath:assetURL];
            } failureBlock:^(NSError *error) {
                if ([_delegate respondsToSelector:@selector(cameraDidSavePhotoWithError:)]) {
                    [_delegate cameraDidSavePhotoWithError:error];
                }
            }];
        };
        
        if ([[BBCamera getOption:kBBCameraOptionSaveImageToAlbum] boolValue] && status != ALAuthorizationStatusDenied) {
            [library saveImage:_photo resultBlock:^(NSURL *assetURL) {
                if ([_delegate respondsToSelector:@selector(cameraDidSavePhotoAtPath:)]) {
                    [_delegate cameraDidSavePhotoAtPath:assetURL];
                }
            } failureBlock:^(NSError *error) {
                saveJPGImageAtDocumentDirectory(_photo);
            }];
        } else {
            if ([_delegate respondsToSelector:@selector(cameraDidSavePhotoAtPath:)]) {
                saveJPGImageAtDocumentDirectory(_photo);
            }
        }
    }
}

- (IBAction)filtersTapped
{
    if ([_filterView isDescendantOfView:self.view]) {
        [_filterView removeFromSuperviewAnimated];
    } else {
        [_filterView addToView:self.view aboveView:_bottomView];
        [self.view sendSubviewToBack:_filterView];
        [self.view sendSubviewToBack:_photoView];
    }
}

#pragma mark -
#pragma mark - Filter view actions

- (IBAction)defaulBBilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _photoView.image = _photo;
}

- (IBAction)satureFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    
    if ([_cachePhoto objectForKey:kBBCacheSatureKey]) {
        _photoView.image = [_cachePhoto objectForKey:kBBCacheSatureKey];
    } else {
        [_cachePhoto setObject:[_photo saturateImage:1.8 withContrast:1] forKey:kBBCacheSatureKey];
        _photoView.image = [_cachePhoto objectForKey:kBBCacheSatureKey];
    }
    
}

- (IBAction)curveFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    
    if ([_cachePhoto objectForKey:kBBCacheCurveKey]) {
        _photoView.image = [_cachePhoto objectForKey:kBBCacheCurveKey];
    } else {
        [_cachePhoto setObject:[_photo curveFilter] forKey:kBBCacheCurveKey];
        _photoView.image = [_cachePhoto objectForKey:kBBCacheCurveKey];
    }
}

- (IBAction)vignetteFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    
    if ([_cachePhoto objectForKey:kBBCacheVignetteKey]) {
        _photoView.image = [_cachePhoto objectForKey:kBBCacheVignetteKey];
    } else {
        [_cachePhoto setObject:[_photo vignetteWithRadius:0 intensity:6] forKey:kBBCacheVignetteKey];
        _photoView.image = [_cachePhoto objectForKey:kBBCacheVignetteKey];
    }
}


#pragma mark -
#pragma mark - Private methods

- (void)addDetailViewToButton:(UIButton *)button
{
    [_detailFilterView removeFromSuperview];
    
    CGFloat height = 2.5;
    
    CGRect frame = button.frame;
    frame.size.height = height;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(button.frame) - height;
    
    _detailFilterView = [[UIView alloc] initWithFrame:frame];
    _detailFilterView.backgroundColor = [BBCameraColor tintColor];
    _detailFilterView.userInteractionEnabled = NO;
    
    [button addSubview:_detailFilterView];
}

+ (instancetype)newController
{
    return [super new];
}

@end
