//
//  IBTImagePreviewer.h
//  IBTImagePreviewer
//
//  Created by Xummer on 14-7-1.
//  Copyright (c) 2014年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBTImagePreviewer : UIView

- (id)initWithViewController:(UIViewController *)viewController
                   tempImage:(UIImage *)image
                         url:(NSURL *)url
                   startRect:(CGRect)rect;

- (void)show;

@end
