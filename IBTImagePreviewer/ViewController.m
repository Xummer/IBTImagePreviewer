//
//  ViewController.m
//  IBTImagePreviewer
//
//  Created by Xummer on 7/3/14.
//  Copyright (c) 2014 Xummer. All rights reserved.
//

#import "ViewController.h"
#import "IBTImagePreviewer.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSURL *imageUrl;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 700);
    [self.view addSubview:_scrollView];
    
    self.imageUrl = [NSURL URLWithString:@"https://farm4.staticflickr.com/3833/14104036399_ee5c17b373_q.jpg"];
    
    self.imageView = [[UIImageView alloc] init];
    CGFloat w = 200;
    _imageView.frame = (CGRect){
        .origin.x = (CGRectGetWidth(self.view.bounds) - w) * .5f,
        .origin.y = 200,
        .size.width = w,
        .size.height = w
    };
    
    [_imageView setImageWithURL:_imageUrl];
    
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImagePreviewer)];
    [_imageView addGestureRecognizer:tap];
    _imageView.userInteractionEnabled = YES;
    
    [_scrollView addSubview:_imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showImagePreviewer {
    
    CGRect rect = [self.view convertRect:_imageView.frame fromView:_imageView.superview];
    
    IBTImagePreviewer *ipv =
    [[IBTImagePreviewer alloc] initWithViewController:self
                                           tempImage:_imageView.image
                                                 url:_imageUrl
                                           startRect:rect];
    [ipv show];
}

@end
