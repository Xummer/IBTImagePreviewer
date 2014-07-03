//
//  JTImagePreviewer.m
//  JobTalk
//
//  Created by Xummer on 14-7-1.
//  Copyright (c) 2014年 BST. All rights reserved.
//

#define PRE_IMAGE_SVAE_BTN_WIDTH    (44)

#import "JTImagePreviewer.h"
#import "UIImageView+WebCache.h"
#import "JTProgress.h"

@interface JTImagePreviewer ()
<
    UIScrollViewDelegate
>
{
    NSURL *_url;
	CGRect _startRect;
    UITapGestureRecognizer *_tapGestureRecognizer;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *saveButton;

@property (weak, nonatomic) UIImage *tempImage;

@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation JTImagePreviewer

#pragma mark - Life Cycle
- (id)initWithViewController:(UIViewController *)viewController
                   tempImage:(UIImage *)image
                         url:(NSURL *)url
                   startRect:(CGRect)rect
{
    
    CGRect frame = CGRectZero;
    if (viewController.navigationController) {
        frame = viewController.navigationController.view.bounds;
    }
    else {
        frame = viewController.view.bounds;
    }
    
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    _url = url;
    _startRect = rect;
    self.viewController = viewController;
    self.tempImage = image;
    
    [self _init];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = (CGRect){
        .origin.x = 0,
        .origin.y = 0,
        .size.width = CGRectGetWidth(_bgView.bounds),
        .size.height = CGRectGetHeight(_bgView.bounds) - PRE_IMAGE_SVAE_BTN_WIDTH
    };
    
    _scrollView.contentSize = _bgView.bounds.size;
    
    _imageView.frame = _bgView.bounds;
    
    _saveButton.frame = (CGRect){
        .origin.x = CGRectGetWidth(_bgView.bounds) - PRE_IMAGE_SVAE_BTN_WIDTH,
        .origin.y = CGRectGetMaxY(_scrollView.frame),
        .size.width = PRE_IMAGE_SVAE_BTN_WIDTH,
        .size.height = PRE_IMAGE_SVAE_BTN_WIDTH
    };
}

#pragma mark - Private Method
- (void)_init {
    self.bgView = [[UIView alloc] init];
    _bgView.frame = self.bounds;
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _bgView.backgroundColor = [UIColor colorWithW:0 a:.8];
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_bgView addGestureRecognizer:_tapGestureRecognizer];
    
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 2.6;
    _scrollView.minimumZoomScale = 1;
    _scrollView.zoomScale = 1;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    self.imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView setImageWithURL:_url placeholderImage:_tempImage];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _saveButton.showsTouchWhenHighlighted = YES;
    [_saveButton addTarget:self
                    action:@selector(save)
          forControlEvents:UIControlEventTouchUpInside];
    
    
    [_scrollView addSubview:_imageView];
    [_bgView addSubview:_scrollView];
    [_bgView addSubview:_saveButton];
    
    [self addSubview:_bgView];
    
}

- (void)dealloc {
    [self cleanup];
}

#pragma mark - Action
- (void)cleanup {
    _url = nil;
    _tapGestureRecognizer = nil;
}

- (void)save {
    if (_imageView.image) {
        [JTProgress showProgressLabel:[JTCommon localizableString:@"Saving..."]];
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)hide {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)show {
    self.userInteractionEnabled = NO;
    self.alpha = 0;
    
    if (self.viewController.navigationController) {
        [self.viewController.navigationController.view addSubview:self];
    }
    else {
        [self.viewController.view addSubview:self];
    }
    
    
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         self.userInteractionEnabled = YES;
                     }];
}

#pragma mark - Save Call Back
- (void)image:(UIImage *)image
didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    [JTProgress hideHUDWithText:[JTCommon localizableString:@"Image saved"]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    _imageView.center = (CGPoint){
//        .x = CGRectGetWidth(_scrollView.bounds) * .5f ,
//        .y = CGRectGetHeight(_scrollView.bounds) * .5f,
//    };
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

@end
