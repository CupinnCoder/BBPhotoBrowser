//
//  BBPhotoTagView.h
//  TimeFaceV2
//
//  Created by Melvin on 3/25/15.
//  Copyright (c) 2015 TimeFace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBPhotoTagViewDataSource <NSObject>
- (CGPoint)normalizedPosition;

@optional
- (NSAttributedString *)attributedTagText;
- (NSString *)tagText;
- (NSDictionary *)metaInfo;


@end

@class BBPhotoTagView;
@protocol BBPhotoTagViewDelegate <NSObject>

- (void)tagDidAppear:(BBPhotoTagView *)tagPopover;
- (void)tagPopoverDidEndEditing:(BBPhotoTagView *)tagPopover;
- (void)tagPopover:(BBPhotoTagView *)tagPopover didReceiveSingleTap:(UITapGestureRecognizer *)singleTap;
- (void)tagPopover:(BBPhotoTagView *)tagPopover didReceiveLongTap:(UITapGestureRecognizer *)longTap;


@end

typedef void(^BBPhotoTagViewVDisplayCallback)(BBPhotoTagView *tagView);


@interface BBPhotoTagView : UIView<UITextFieldDelegate>

@property (nonatomic,copy    ) BBPhotoTagViewVDisplayCallback   doneCallback;
@property (nonatomic, strong ) id <BBPhotoTagViewDataSource>    dataSource;
@property (nonatomic, weak   ) id <BBPhotoTagViewDelegate>      delegate;
@property (nonatomic, assign ) CGPoint                          normalizedArrowPoint;
@property (nonatomic, assign ) CGPoint                          tagLocation;
@property (nonatomic, assign ) CGPoint                          pointOnImage;
@property (nonatomic, assign ) CGSize                           sizeOnImage;
@property (nonatomic, assign ) CGPoint                          normalizedArrowOffset;
@property (nonatomic, assign ) CGSize                           minimumTextFieldSize;
@property (nonatomic, assign ) CGSize                           minimumTextFieldSizeWhileEditing;
@property (nonatomic, assign ) NSInteger                        maximumTextLength;
@property (nonatomic, strong)  NSString                         *tagId;
@property (nonatomic, strong) NSString                          *faceId;
@property (nonatomic, weak) UITextField *tagTextField;

- (id)initWithDelegate:(id<BBPhotoTagViewDelegate>)delegate frame:(CGRect)frame;
- (id)initWithTag:(id<BBPhotoTagViewDataSource>)aTag;

- (NSString *)text;
- (void)setText:(NSString *)text;

- (void)startEdit;

- (void)presentPopoverFromPoint:(CGPoint)point
                         inView:(UIView *)view
                       animated:(BOOL)animated;

- (void)presentPopoverFromPoint:(CGPoint)point
                         inView:(UIView *)view
       permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                       animated:(BOOL)animated;

- (void)presentPopoverFromPoint:(CGPoint)point
                         inRect:(CGRect)rect
                         inView:(UIView *)view
       permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                       animated:(BOOL)animated;

- (void)repositionInRect:(CGRect)rect;

@end
