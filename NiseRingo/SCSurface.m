//
//  SCSurface.m
//  NiseRingo
//
//  Created by apple  on 13-4-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSurface.h"
#import "SCAlphaConverter.h"

@implementation SCSurface
@synthesize rawImage;
@synthesize surfaceID;
-(instancetype)initWithFile:(NSString*)f
        surfaceID:(int)argSurfaceID
      Description:(SCBlockedDescription*)comprehensiveDefinitions{
    self = [super init];
    if (self) {
        surfaceID=argSurfaceID;
        
        // pngをロードして左上の座標で色抜き。同時にアルファチャンネルを持たせる。
        NSImage *image_original;
        image_original=[[NSImage alloc] initWithContentsOfFile:f];
        rawImage=[SCAlphaConverter convertImage:image_original];
        //rawImage=image_original;
    }
    return self;
}

@end
