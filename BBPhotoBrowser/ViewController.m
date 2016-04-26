//
//  ViewController.m
//  BBPhotoBrowser
//
//  Created by Gary on 4/26/16.
//  Copyright © 2016 Gary. All rights reserved.
//

#import "ViewController.h"
#import "BBPhotoBrowser.h"
#import "BBLibraryViewController.h"
#import "BBImagePickerController.h"

@interface ViewController ()<BBPhotoBrowserDelegate,BBLibraryViewControllerDelegate,BBImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *selections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试相册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(100, 100, 60, 40)];
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
    
    _photos     = [NSMutableArray array];
    _thumbs     = [NSMutableArray array];
    _selections = [NSMutableArray array];
    @autoreleasepool {
        BBPhoto *photo,*thumb;
        for (NSInteger i=1;i<=9 ; i++) {
            photo = [BBPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"photo%@",@(i)] ofType:@"jpg"]]];
            photo.caption = @"这是一段对于这个图片的文字描述，我们需要进行展示，默认展示2行，提供手势操作展开的功能,默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能默认展示2行，提供手势操作展开的功能";
            [_photos addObject:photo];
            
            thumb = [BBPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"photo%@t",@(i)] ofType:@"jpg"]]];
            [_thumbs addObject:thumb];
        }
    }
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试相册2" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onViewClick2:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(100, 200, 60, 40)];
    button.layer.borderWidth = 1;
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onViewClick:(id)sender {
    // Create browser
    
}


- (void)onViewClick2:(id)sender {
    //        TFLibraryViewController *viewController = [[TFLibraryViewController alloc] init];
    BBImagePickerController *viewController = [[BBImagePickerController alloc] initWithScanButton];
    //    TFImagePickerController *viewController = [[TFImagePickerController alloc] init];
    
    viewController.mediaTypes = @[ (id)kUTTypeImage ];
    viewController.delegate = self;
    viewController.allowsMultipleSelection = YES;
    viewController.maxSelectedCount = 9;
    viewController.showAllSelectButton = YES;
    //    viewController.showScanButton = YES;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nc.toolbarHidden = NO;
    [self presentViewController:nc animated:YES completion:nil];
}


#pragma mark - TFPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(BBPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <BBPhoto>)photoBrowser:(BBPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <BBPhoto>)photoBrowser:(BBPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(BBPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index section:(NSInteger)section {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(BBPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index section:(NSInteger)section selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(BBPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - BBLibraryViewControllerDelegate
- (void)didSelectPHAssets:(NSArray<BBAsset *> *)assets
               removeList:(NSArray<BBAsset *> *)removeList
                    infos:(NSMutableArray *)infos {
    NSLog(@"selected assets:%@",assets);
    for (BBAsset *tfAsset in assets) {
        NSLog(@"selected tfAsset:%@",tfAsset.fullResolutionImage);
    }
    
}

- (void)didSelectImage:(UIImage *)image {
    
}


- (void)imagePickerController:(BBImagePickerController *)picker
       didFinishPickingAssets:(NSArray<PHAsset *> *)assets {
    [self dismissViewControllerAnimated:YES completion:nil];
    for (PHAsset *asset in assets) {
        NSLog(@"asset :%@",asset.fileExtension);
    }
}

@end
