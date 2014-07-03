//
//  IBTProgress.m
//  IBTImagePreviewer
//
//  Created by Xummer on 7/3/14.
//  Copyright (c) 2014 Xummer. All rights reserved.
//

#import "IBTProgress.h"
#import "MBProgressHUD.h"

@implementation IBTProgress

+ (MBProgressHUD *)showHUDWithText:(NSString *)text
                            inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = NSLocalizedString(text, nil);
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (void)showTextOnly:(NSString *)text inView:(UIView *)view {
    MBProgressHUD *hud = [[self class] showHUDWithText:text inView:view];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
    //	hud.yOffset = 0.f;
    [hud hide:YES afterDelay:1];
}

+ (void)showTextOnly:(NSString *)text {
    MBProgressHUD *hud = [[self class] showHUDWithText:text inView:[[self class] hudShowWindow]];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
	hud.yOffset = 60.0f;
    [hud hide:YES afterDelay:1];
}

+ (void)showProgressLabel:(NSString *)text  {
    MBProgressHUD *hud = [[self class] showHUDWithText:text inView:[[self class] hudShowWindow]];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)hideHUDWithText:(NSString *)text {
    
    [[self class] hideHUDForView:[[self class] hudShowWindow] withText:text];
}

+ (void)showProgressLabel:(NSString *)text
                   inView:(UIView *)view {
    MBProgressHUD *hud = [[self class] showHUDWithText:text inView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)showCustomView:(UIView *)customview
                inView:(UIView *)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.customView = customview;
    
    // Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
    [hud show:YES];
}

+ (void)hideHUDForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideHUDForView:(UIView *)view
              withText:(NSString *)text {
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    if (text.length > 0) {
        [[self class] showTextOnly:text];
    }
}

+ (UIWindow *)hudShowWindow {
    UIWindow *showWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if ([windows count] >= 2) {
        showWindow = [windows objectAtIndex:1];
    }
    else {
        showWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return showWindow;
}

@end
