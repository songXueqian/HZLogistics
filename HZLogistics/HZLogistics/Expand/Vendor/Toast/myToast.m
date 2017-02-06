//
//  mytoast.m
//  Children365
//
//  Created by Jason on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "myToast.h"
#import "Type.h"

#import <QuartzCore/QuartzCore.h>
#import "CalculateFrame.h"


@implementation myToast

static myToast *toast = nil;

- (void)__show {
    
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:0.2f];
//    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDidStopSelector:@selector(__animationDidStop:__finished:__context:)];
    self.alpha = 1.0f;
    [UIView commitAnimations];
    
}

- (void)__hide {
    [self performSelectorOnMainThread:@selector(__hideThread) withObject:nil waitUntilDone:NO];
}

- (void)__hideThread {
    [UIView beginAnimations:@"hide" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationDidStopSelector:@selector(__animationDidStop:__finished:__context:)];
    self.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)__animationDidStop:(NSString *)animationID __finished:(NSNumber *)finished __context:(void *)context {
    
    if ([animationID isEqualToString:@"hide"]) {
        [self removeFromSuperview];
       // self = nil;
    }
    else if ([animationID isEqualToString:@"show"]) {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(__hide) userInfo:nil repeats:NO];
    }
    
}

+ (myToast *)__createWithText:(NSString *)text {
    
    float screenWidth1  = [UIScreen mainScreen].bounds.size.width;
    float screenHeight1 = [UIScreen mainScreen].bounds.size.height;
    
    float x = 10.0f;
    float width = screenWidth1 - x * 2.0f;
    
    UILabel *textLabel = [[UILabel alloc] init];
    
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont boldSystemFontOfSize:22];
    textLabel.textColor = RGB(255, 255, 255);
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize sz = [CalculateFrame getCGSize:text size:CGSizeMake(width - 20.0f, 9999.0f) font:textLabel.font];
    
    CGRect tmpRect;
    
    tmpRect.size.width = sz.width+20;
    tmpRect.size.height = MAX(sz.height + 20.0f, 38.0f);
    tmpRect.origin.x = floor((screenWidth1 - tmpRect.size.width) / 2.0f);
//    tmpRect.origin.y = floor(screenHeight1 - tmpRect.size.height - 15.0f);
    tmpRect.origin.y = floor((screenHeight1 - tmpRect.size.height) /2.0f);
    
//    if (toast == nil)
        toast = [[myToast alloc] initWithFrame:tmpRect];
    
    toast.backgroundColor = ACTIVITY_COLOR;
    CALayer *layer = toast.layer;
    
    layer.masksToBounds = YES;    
    layer.cornerRadius = 5.0f;

    textLabel.text = text;
    tmpRect.origin.x = floor((toast.frame.size.width - sz.width) / 2.0f);
//    if (tmpRect.origin.x<10)
//        tmpRect.origin.x=10;
    
    tmpRect.origin.y = floor((toast.frame.size.height - sz.height) / 2.0f);
//    if (tmpRect.origin.y<10)
//        tmpRect.origin.y=10;
    
    tmpRect.size = sz;
    
    textLabel.frame = tmpRect;
    for (UIView* view in [toast subviews]) 
    {
        if ([view isKindOfClass: [UILabel class]]) 
        {
            [view removeFromSuperview];
        }
    }
    [toast addSubview:textLabel];
   // [textLabel release];
    
    toast.alpha = 0.0f;
    
    return toast;
    
}

+ (myToast *)__createWithImage:(UIImage *)image {
    
    float screenWidth1 = [UIScreen mainScreen].bounds.size.width;
    float screenHeight1 = [UIScreen mainScreen].bounds.size.height;
    float x = 10.0f;
    float width = screenWidth1 - x * 2.0f;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGSize sz = imageView.frame.size;
    
    CGRect tmpRect;
    tmpRect.size.width = width;
    tmpRect.size.height = MAX(sz.height + 20.0f, 38.0f);
    tmpRect.origin.x = floor((screenWidth1 - width) / 2.0f);
    tmpRect.origin.y = floor(screenHeight1 - tmpRect.size.height - 15.0f);
    
//    if (toast == nil)
        toast = [[myToast alloc] initWithFrame:tmpRect];
    
    toast.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];//RGBA(0.0f, 0.0f, 0.0f, 0.8f);
    
    CALayer *layer = toast.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 5.0f;
    
    tmpRect.origin.x = floor((toast.frame.size.width - sz.width) / 2.0f);
    tmpRect.origin.y = floor((toast.frame.size.height - sz.height) / 2.0f);
    tmpRect.size = sz;
    imageView.frame = tmpRect;
    [toast addSubview:imageView];
    //[imageView release];
    
    toast.alpha = 0.0f;
    
    return toast;
    
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 */

+ (void)showWithText:(NSString *)text {
    
    myToast *toast = [myToast __createWithText:text];
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:toast];
    
    [toast __show];
    
}

+ (void)showWithText:(NSString *)text view:(UIView*)view{
    
    myToast *toast = [myToast __createWithText:text];
    
    [view addSubview:toast];
    
    [toast __show];
    
}

/**
 
 * Show toast with image in application window
 
 * @param image Image to show in toast window
 
 */

+ (void)showWithImage:(UIImage *)image {
    
    myToast *toast = [myToast __createWithImage:image];
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    [mainWindow addSubview:toast];
//    [toast release];
    [toast __show];
    
}

@end