//
//  BBLibraryViewController.h
//  BBPhotoBrowser
//
//  Created by Gary on 12/15/15.
//  Copyright © 2015 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBAsset.h"

@protocol BBLibraryViewControllerDelegate;

@interface BBLibraryViewController : UIViewController


@property (nonatomic, weak  ) id<BBLibraryViewControllerDelegate  > libraryControllerDelegate;
/**
 *  多选
 */
@property (nonatomic, assign) BOOL                              allowsMultipleSelection;
/**
 *  单选模式下打开图片裁剪
 */
@property (nonatomic, assign) BOOL                              allowsImageCrop;
@property (nonatomic, assign) NSUInteger                        minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger                        maximumNumberOfSelection;
@property (nonatomic, assign) CGSize                            imageCropSize;
@property (nonatomic, strong) UIColor                           *barButtonColor;
/**
 *  已选择的图片数组
 */
@property (nonatomic, strong) NSMutableArray                    *selectedAssets;
/**
 *  最多可选图片数量
 */
@property (nonatomic, assign) NSInteger                         maxSelectedCount;

@end



/**
 *  照片选择回调
 */
@protocol BBLibraryViewControllerDelegate <NSObject>

@optional
- (void)didSelectPHAssets:(NSArray<BBAsset *> *)assets
               removeList:(NSArray<BBAsset *> *)removeList
                    infos:(NSMutableArray *)infos;
- (void)didSelectImage:(UIImage *)image;

/**
 *  图片检测尺寸
 *
 *  @return
 */
- (CGSize)sizeOfImageCrop;



@end
