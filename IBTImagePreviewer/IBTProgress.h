//
//  IBTProgress.h
//  IBTImagePreviewer
//
//  Created by Xummer on 7/3/14.
//  Copyright (c) 2014 Xummer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBTProgress : NSObject

+ (void)showTextOnly:(NSString *)text;
+ (void)showTextOnly:(NSString *)text
              inView:(UIView *)view;

+ (void)showProgressLabel:(NSString *)text;
+ (void)hideHUDWithText:(NSString *)text;
+ (void)showProgressLabel:(NSString *)text
                   inView:(UIView *)view;

+ (void)showCustomView:(UIView *)customview
                inView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view
              withText:(NSString *)text;

@end
