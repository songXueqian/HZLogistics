//
//  mytoast.h
//  Children365
//
//  Created by Jason on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myToast : UIView

+ (void)showWithText:(NSString *)text;

+ (void)showWithImage:(UIImage *)image;

+ (void)showWithText:(NSString *)text view:(UIView*)view;

@end

