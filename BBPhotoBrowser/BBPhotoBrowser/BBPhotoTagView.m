//
//  BBPhotoTagView.m
//  GaryV2
//
//  Created by Gary on 3/25/15.
//  Copyright (c) 2015 Gary. All rights reserved.
//

#import "BBPhotoTagView.h"

@interface BBPhotoTagView()

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *bgImageView;

@property (assign, getter = isCanceled) BOOL canceled;
@property (nonatomic, assign) CGRect       tagFrame;

@end

@implementation BBPhotoTagView

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithDelegate:(id<BBPhotoTagViewDelegate>)delegate frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        NSAssert([(NSObject *)delegate conformsToProtocol:@protocol(BBPhotoTagViewDelegate)],
                 @"A tag popover's delegate must conform to the BBPhotoTagViewDelegate.");
        CGFloat imageSize = MAX(frame.size.width, frame.size.height);
        _tagFrame = CGRectMake(frame.origin.x, frame.origin.y, imageSize, imageSize);
        
        [self initialize];
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithTag:(id<BBPhotoTagViewDataSource>)aTag
{
    self = [super init];
    if(self){
        NSAssert([(NSObject *)aTag conformsToProtocol:@protocol(BBPhotoTagViewDataSource)],
                 @"A tag's data source must conform to BBPhotoTagViewDataSource.");
        [self initialize];
        [self setDataSource:aTag];
        [self setText:self.dataSource.tagText];
    }
    return self;
}

- (void)initialize
{
    [self loadContentView];
    [self loadGestureRecognizers];
    
    CGSize tagInsets = CGSizeMake(-7, -6);
    CGRect tagBounds = CGRectInset(self.contentView.bounds, tagInsets.width, tagInsets.height);
    tagBounds.size.height += 10.0f;
    tagBounds.origin.x = 0;
    tagBounds.origin.y = 0;
    
    CGRect tmpFrame = CGRectMake(0, 0, MAX(tagBounds.size.width, _tagFrame.size.width), tagBounds.size.height + _tagFrame.size.height);
    
    [self setFrame:tmpFrame];
    
    [self setMinimumTextFieldSize:CGSizeMake(25, 14)];
    [self setMinimumTextFieldSizeWhileEditing:CGSizeMake(54, 14)];
    [self setMaximumTextLength:40];
    
    [self setNormalizedArrowOffset:CGPointMake(0.0, 0.02)];
    
    [self setOpaque:NO];
    [self.contentView setFrame:CGRectOffset(self.contentView.frame,
                                            -(tagInsets.width),
                                            -(tagInsets.height)+10)];
    
    [self beginObservations];
    
    self.alpha = 0;
    [self setSizeOnImage:CGSizeZero];
}

- (void)dealloc
{
    [self stopObservations];
}

#pragma mark -

- (void)loadContentView
{
    UIView *contentView = [self newContentView];
    [self addSubview:contentView];
    [self setContentView:contentView];
}

- (void)loadGestureRecognizers
{
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(didRecognizeSingleTap:)];
    [singleTapGesture setNumberOfTapsRequired:1];
    
    [self addGestureRecognizer:singleTapGesture];
    
    UILongPressGestureRecognizer *longTapGesture = [[UILongPressGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(didRecognizeLongTap:)];
    [longTapGesture setMinimumPressDuration:1.5];
    [self addGestureRecognizer:longTapGesture];
}

- (UIView *)newContentView
{
    NSString *placeholderText = @"这是?";
    UIFont *textFieldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    CGSize tagSize = [placeholderText sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold"
                                                                                               size:14]}];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, _tagFrame.size.height, tagSize.width, tagSize.height)];
    [textField setFont:textFieldFont];
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setTextColor:[UIColor whiteColor]];
    [textField setPlaceholder:placeholderText];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [textField setTextAlignment:NSTextAlignmentCenter];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField setEnablesReturnKeyAutomatically:YES];
    [textField setDelegate:self];
    [textField setUserInteractionEnabled:NO];
    
    [self setTagTextField:textField];
    return textField;
}


#pragma mark - Notifications

- (void)beginObservations
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tagtextFieldDidChangeWithNotification:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didReceiveCancelNotification:)
//                                                 name:EBPhotoPagesControllerDidCancelTaggingNotification
//                                               object:nil];
}


- (void)stopObservations
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)tagtextFieldDidChangeWithNotification:(NSNotification *)aNotification
{
    //resize, reposition
    if(aNotification.object == self.tagTextField){
        [self resizeTextField];
    }
}


- (NSString *)text
{
    return self.tagTextField.text;
}

- (void)setText:(NSString *)text
{
    _tagTextField.text = nil;
    [self.tagTextField setText:text];
    [self resizeTextField];
}

- (void)startEdit {
    [self.tagTextField setUserInteractionEnabled:YES];
    [self.tagTextField becomeFirstResponder];
}

- (void)setDelegate:(id<BBPhotoTagViewDelegate>)aDelegate
{
    NSAssert([aDelegate conformsToProtocol:@protocol(BBPhotoTagViewDelegate)],
             @"EBTagPopover delegates must conform to BBPhotoTagViewDelegate.");
    _delegate = aDelegate;
}


- (void)presentPopoverFromPoint:(CGPoint)point
                         inView:(UIView *)view
                       animated:(BOOL)animated
{
    [self presentPopoverFromPoint:point
                           inRect:view.frame
                           inView:view
         permittedArrowDirections:UIPopoverArrowDirectionUp
                         animated:animated];
}



- (void)presentPopoverFromPoint:(CGPoint)point
                         inView:(UIView *)view
       permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                       animated:(BOOL)animated
{
    [self presentPopoverFromPoint:point
                           inRect:view.frame
                           inView:view
         permittedArrowDirections:arrowDirections
                         animated:animated];
}


- (void)presentPopoverFromPoint:(CGPoint)point
                         inRect:(CGRect)rect
                         inView:(UIView *)view
       permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                       animated:(BOOL)animated;
{
    //[self setCenter:point];
    
    
    [self setTagLocation:point];
    [view addSubview:self];
    
    CGPoint difference = CGPointMake(0,//(newCenter.x - point.x)/self.frame.size.width,
                                     0.5);
    
    [self.layer setAnchorPoint:CGPointMake(0.5-difference.x,0.5-difference.y)];
    
    [self setCenter:point];
    
    CGFloat tagMaximumX = CGRectGetMaxX(self.frame);
    CGFloat tagMinimumX = CGRectGetMinX(self.frame);
    CGFloat tagMaximumY = CGRectGetMaxY(self.frame);
    CGFloat tagMinimumY = CGRectGetMinY(self.frame);
    
    CGRect tagBoundary = CGRectInset(view.bounds, 5, 5);
    CGFloat boundsMinimumX = CGRectGetMinX(tagBoundary);
    CGFloat boundsMaximumX = CGRectGetMaxX(tagBoundary);
    CGFloat boundsMinimumY = CGRectGetMinY(tagBoundary);
    CGFloat boundsMaximumY = CGRectGetMaxY(tagBoundary);
    
    CGFloat xOffset = ((MIN(0, tagMinimumX - boundsMinimumX) + MAX(0, tagMaximumX - boundsMaximumX))/1.0);
    CGFloat yOffset = ((MIN(0, tagMinimumY - boundsMinimumY) + MAX(0, tagMaximumY - boundsMaximumY))/1.0);
    
    
    CGPoint newCenter = CGPointMake(point.x - xOffset,
                                    point.y - yOffset);
    
    
    [self setCenter:newCenter];
    
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.35 animations:^{
       self.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([weakSelf.delegate respondsToSelector:@selector(tagDidAppear:)]) {
                [weakSelf.delegate tagDidAppear:weakSelf];
            }
        }
    }];
    /*
     CGRect newFrame = self.frame;
     newFrame.origin.x = point.x;
     newFrame.origin.y = point.y;
     //[self seBBrame:newFrame];
     
     [self setTransform:CGAffineTransformMakeScale(0.3, 0.3)];
     [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     [self setTransform:CGAffineTransformMakeScale(1,1)];
     }completion:nil];
     */
    
}


- (void)drawRect:(CGRect)fullRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, _tagFrame);
    
//    NSString *text = _tagtextField.text;
//    _tagtextField.text  = nil;
//    _tagtextField.text = text;
    
    CGContextSetLineWidth(context, 1.0);//线的宽度
    UIColor *aColor = [UIColor whiteColor];//blue蓝色
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
    CGContextStrokeRect(context,CGRectMake(fullRect.origin.x, fullRect.origin.y, MAX(fullRect.size.width, _tagFrame.size.width), _tagFrame.size.height));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    
    float radius = 2.0f;
    float arrowHeight =  _tagFrame.size.height + 10.0f; //this is how far the arrow extends from the rect
    float arrowWidth = 16.0;
    
    fullRect = CGRectInset(fullRect, 1, 1);
    
    CGRect containerRect = CGRectMake(fullRect.origin.x,
                                      fullRect.origin.y+arrowHeight,
                                      fullRect.size.width,
                                      fullRect.size.height-arrowHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    CGMutablePathRef tagPath = CGPathCreateMutable();
    
    //the starting point, top left corner
    CGPathMoveToPoint(tagPath, NULL, CGRectGetMinX(containerRect) + radius, CGRectGetMinY(containerRect));
    
    //draw the arrow
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMidX(containerRect)-(arrowWidth*0.5), CGRectGetMinY(containerRect));
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMidX(containerRect), CGRectGetMinY(fullRect) + _tagFrame.size.height);
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMidX(containerRect)+(arrowWidth*0.5), CGRectGetMinY(containerRect));
    
    //top right corner
    CGPathAddArc(tagPath, NULL, CGRectGetMaxX(containerRect) - radius, CGRectGetMinY(containerRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
    
    //bottom right corner
    CGPathAddArc(tagPath, NULL, CGRectGetMaxX(containerRect) - radius, CGRectGetMaxY(containerRect) - radius, radius, 0, (float)M_PI / 2, 0);
    
    //bottom left corner
    CGPathAddArc(tagPath, NULL, CGRectGetMinX(containerRect) + radius, CGRectGetMaxY(containerRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    
    //top left corner, the ending point
    CGPathAddArc(tagPath, NULL, CGRectGetMinX(containerRect) + radius, CGRectGetMinY(containerRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    
    //we are done
    CGPathCloseSubpath(tagPath);
    CGContextAddPath(context, tagPath);
    CGContextSetFillColorWithColor(context, [[[UIColor blackColor] colorWithAlphaComponent:.8] CGColor]);
    CGContextFillPath(context);
    //CGPathRelease(arrowPath);
    CGPathRelease(tagPath);
    CGColorSpaceRelease(colorSpace);
    
}

- (void)repositionInRect:(CGRect)rect
{
    [self.layer setAnchorPoint:CGPointMake(0.5,0)];
    CGPoint popoverPoint = CGPointMake(rect.origin.x, rect.origin.y);
    popoverPoint.x += rect.size.width * (self.normalizedArrowPoint.x + self.normalizedArrowOffset.x);
    popoverPoint.y += rect.size.height * (self.normalizedArrowPoint.y + self.normalizedArrowOffset.y);
    
    [self setCenter:popoverPoint];
    
    CGFloat rightX = self.frame.origin.x+self.frame.size.width;
    CGFloat leftXClip = MAX(rect.origin.x - self.frame.origin.x, 0);
    CGFloat rightXClip = MIN((rect.origin.x+rect.size.width)-rightX, 0);
    
    CGRect newFrame = self.frame;
    newFrame.origin.x += leftXClip;
    newFrame.origin.x += rightXClip;
    
    [self setFrame:newFrame];
    
    
}

#pragma mark - Event Hooks

- (void)didRecognizeSingleTap:(UITapGestureRecognizer *)tapGesture
{
    if ([_delegate respondsToSelector:@selector(tagPopover:didReceiveSingleTap:)]) {
        [_delegate tagPopover:self didReceiveSingleTap:tapGesture];
    }
}

- (void)didRecognizeLongTap:(UITapGestureRecognizer *)tapGesture
{
    if ([_delegate respondsToSelector:@selector(tagPopover:didReceiveLongTap:)]) {
        [_delegate tagPopover:self didReceiveLongTap:tapGesture];
    }
}

- (void)didReceiveCancelNotification:(NSNotification *)aNotification
{
    if(self.isFirstResponder){
        [self setCanceled:YES];
        [self resignFirstResponder];
        [self removeFromSuperview];
    }
}

#pragma mark - UItextField Delegate


- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    BOOL result = NO;
    
    if(textField == self.tagTextField){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if((!self.maximumTextLength) || (newLength <= self.maximumTextLength)){
            result = YES;
        }
    }
    
    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.tagTextField){
        [textField setTextAlignment:NSTextAlignmentLeft];
        [self resizeTextField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.tagTextField){
        [textField setTextAlignment:NSTextAlignmentCenter];
        [self resizeTextField];
//        if([self isCanceled] == NO){
//            [self.delegate tagPopoverDidEndEditing:self];
//        }
        [self resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.tagTextField){
        [self resignFirstResponder];
        if([self isCanceled] == NO){
            [self.delegate tagPopoverDidEndEditing:self];
        }
    }
    return YES;
}

- (BOOL)becomeFirstResponder
{
    [self.tagTextField setUserInteractionEnabled:YES];
    if([self.tagTextField canBecomeFirstResponder]){
        [self.tagTextField becomeFirstResponder];
        [self resizeTextField];
        return YES;
    }
    
    [self.tagTextField setUserInteractionEnabled:NO];
    return NO;
}

- (BOOL)isFirstResponder
{
    return self.tagTextField.isFirstResponder;
}

- (BOOL)resignFirstResponder
{
    [self.tagTextField setUserInteractionEnabled:NO];
    return self.tagTextField.resignFirstResponder;
}

# pragma mark -

- (void)resizeTextField
{
    CGSize newTagSize = CGSizeZero;
    if(self.tagTextField.text && ![self.tagTextField.text isEqualToString:@""]){
        newTagSize = [self.tagTextField.text sizeWithAttributes:@{NSFontAttributeName: self.tagTextField.font}];
    } else if (self.tagTextField.placeholder && ![self.tagTextField.placeholder isEqualToString:@""]){
        newTagSize = [self.tagTextField.text sizeWithAttributes:@{NSFontAttributeName: self.tagTextField.font}];
    }
    
    if(self.tagTextField.isFirstResponder){
        //This gives some extra room for the cursor.
        newTagSize.width += 3;
    }
    
    CGRect newtextFieldFrame = self.tagTextField.frame;
    CGSize minimumSize = self.tagTextField.isFirstResponder ? self.minimumTextFieldSizeWhileEditing :
    self.minimumTextFieldSize;
    
    newtextFieldFrame.size.width = MAX(_tagFrame.size.width, minimumSize.width);
    newtextFieldFrame.size.height = MAX(newTagSize.height, minimumSize.height);
    [self.tagTextField setFrame:newtextFieldFrame];
    
    
    CGSize tagInsets = CGSizeMake(-7, -6);
    CGRect tagBounds = CGRectInset(self.tagTextField.bounds, tagInsets.width, tagInsets.height);
    tagBounds.size.height += 10.0f;
    tagBounds.origin.x = 0;
    tagBounds.origin.y = 0;
    
    CGRect tmpFrame = CGRectMake(0, 0, MAX(tagBounds.size.width, _tagFrame.size.width), tagBounds.size.height + _tagFrame.size.height);
    
    CGPoint originalCenter = self.center;
    [self setFrame:tmpFrame];
    [self setCenter:originalCenter];
    
    [self setNeedsDisplay];
}

@end
