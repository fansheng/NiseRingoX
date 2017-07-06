//
//  SCAlphaConverter.h
//  NiseRingo
//
//  Created by apple  on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCAlphaConverter : NSObject

+(NSImage *)convertImage:(NSImage *)srcImage;
+(void)attachAlpha:(NSImage *)src toImage:(NSImage *)dest;

@end
