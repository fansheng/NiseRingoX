//
//  SCBalloonSkin.m
//  NiseRingo
//
//  Created by apple  on 13-4-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCBalloonSkin.h"
#import "SCAlphaConverter.h"

@implementation SCBalloonSkin
-(instancetype)initWithDescription:(SCDescription*)parentDesc
                    path:(NSString*)dir
                    name:(NSString*)bskinname
                      id:(int)argBalloonID
                   scope:(int)argScope{
    self = [super init];
    if (self) {
        balloonID=argBalloonID;
        scope=argScope;
        NSString *pngfile=[dir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",bskinname]];
        NSFileManager *sharedFM = [NSFileManager defaultManager];
        if ([sharedFM fileExistsAtPath:pngfile])
        {
            image = [SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:pngfile]];
            frame.origin=NSZeroPoint;
            frame.size=image.size;
        }
    }
    return self;
}

@end
