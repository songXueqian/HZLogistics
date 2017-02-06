//
//  CalculateFrame.h
//  Children365
//
//  Created by apple on 13-4-27.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CalculateFrame : NSObject

+ (CGRect)getLabFrame:(UILabel *)lab font:(UIFont*)font yPonit:(CGFloat)yPonit;

+ (CGFloat)getLabHeight:(NSString *)text width:(CGFloat)width font:(UIFont*)font;

+ (CGRect)getPictureFrame:(UIImageView *)pic yPonit:(CGFloat)yPonit;

+ (CGSize)getCGSize:(NSString *)text size:(CGSize)size font:(UIFont*)font;
@end
