//
//  CalculateFrame.m
//  Children365
//
//  Created by apple on 13-4-27.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

#import "CalculateFrame.h"

@implementation CalculateFrame

+ (CGRect)getLabFrame:(UILabel *)lab font:(UIFont*)font yPonit:(CGFloat)yPonit{
    
    [lab setNumberOfLines:0];
    [lab setLineBreakMode:NSLineBreakByWordWrapping];
    
    lab.font = font;
    
    CGSize size = CGSizeMake(lab.frame.size.width, 9999);
    CGSize labSize;
    NSDictionary *dic = font.fontDescriptor.fontAttributes;
    labSize = [lab.text boundingRectWithSize:size // 用于计算文本绘制时占据的矩形块
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                attributes:dic        // 文字的属性
                                    context:nil].size;
    labSize.width = ceilf(labSize.width);
    labSize.height = ceilf(labSize.height);
    
    CGRect frame = lab.frame;
    frame.size.height = labSize.height;
    frame.origin.y = yPonit;
    
    return frame;
}

+ (CGFloat)getLabHeight:(NSString *)text width:(CGFloat)width font:(UIFont*)font {
    CGSize sizeToFit;
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    if ([text isEqualToString:@""]) {
        sizeToFit = CGSizeMake(0, 0);
    }else{
        sizeToFit = [text boundingRectWithSize:CGSizeMake(width, 9999) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        sizeToFit.width = ceilf(sizeToFit.width);
        sizeToFit.height = ceilf(sizeToFit.height);
    }

    return sizeToFit.height;
}

+ (CGRect)getPictureFrame:(UIImageView *)pic yPonit:(CGFloat)yPonit{    
   CGRect frame = pic.frame;
//    frame.size.height = labSize.height;
    frame.origin.y = yPonit;
    
    return frame;    
}


+ (CGSize)getCGSize:(NSString *)text size:(CGSize)size font:(UIFont*)font {
    CGSize sizeToFit;
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    NSString *string = [NSString stringWithFormat:@"test"];
    CGSize sizeToTest = [string boundingRectWithSize:CGSizeMake(999, 999) options:  NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    if (size.height < sizeToTest.height) {
        if ([text isEqualToString:@""]) {
            sizeToFit = CGSizeMake(0, 0);
        }else{
            sizeToFit = [text boundingRectWithSize:CGSizeMake(size.width, sizeToTest.height) options:  NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
            sizeToFit.width = ceilf(sizeToFit.width);
            sizeToFit.height = ceilf(sizeToFit.height);
        }
    }else{
        sizeToFit = [text boundingRectWithSize:CGSizeMake(size.width, size.height) options:  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        sizeToFit.width = ceilf(sizeToFit.width);
        sizeToFit.height = ceilf(sizeToFit.height);
    }
    return sizeToFit;
}

@end
