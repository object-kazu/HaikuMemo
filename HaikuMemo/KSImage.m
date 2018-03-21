//
//  KSImage.m
//  LastSupper
//
//  Created by 清水 一征 on 13/02/21.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSImage.h"
#import "def.h"

@implementation KSImage

- (UIImage *)cropImageView:(UIImage *)image isSmall:(BOOL)isSmall // thumnail image get
{
    // 切り取る
    float     origin_width = image.size.width;
    float     origin_heigt = image.size.width;
    
    CGRect    cropRect;
    if ( origin_heigt <= origin_width ) {
        float    x = origin_width / 2 - origin_heigt / 2;
        float    y = 0;
        cropRect = CGRectMake(x, y, origin_heigt, origin_heigt);
    } else {
        float    x = 0;
        float    y = origin_heigt / 2 - origin_width / 2;
        cropRect = CGRectMake(x, y, origin_width, origin_width);
    }
    CGImageRef    cgimage    = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    UIImage       *cropImage = [UIImage imageWithCGImage:cgimage];
    
    // 縮小する
    CGSize        thumbSize;
    if ( isSmall ) {
        thumbSize = CGSizeMake(SMALL_THUMIMAGE_SIZE, SMALL_THUMIMAGE_SIZE);
    } else {
        thumbSize = CGSizeMake(THUMIMAGE_SIZE, THUMIMAGE_SIZE);
    }
    UIGraphicsBeginImageContextWithOptions(thumbSize, NO, 0.0);
    [cropImage drawInRect:CGRectMake(0, 0, thumbSize.width, thumbSize.height)];
    UIImage    *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgimage);
    
    return thumbImage;
}

- (BOOL)isThumbSize:(UIImage *)image {
    BOOL    is_Thumb_size = NO;
    
    if ( image.size.width > THUMIMAGE_SIZE || image.size.height > THUMIMAGE_SIZE ) {
        is_Thumb_size = NO;
        
    } else {
        is_Thumb_size = YES;
    }
    
    return is_Thumb_size;
}

- (BOOL)isSmallThumbSize:(UIImage *)image {
    BOOL    is_Thumb_size = NO;
    
    if ( image.size.width > SMALL_THUMIMAGE_SIZE || image.size.height > SMALL_THUMIMAGE_SIZE ) {
        is_Thumb_size = NO;
        
    } else {
        is_Thumb_size = YES;
    }
    
    return is_Thumb_size;
    
}

- (UIImage *)getThumbImage:(UIImage *)image {
    UIImage    *thumbImage;
    
    if ( [self isThumbSize:image] ) {
        thumbImage = image;
    } else {
        thumbImage = [self cropImageView:image isSmall:NO];
    }
    
    return thumbImage;
}


@end
