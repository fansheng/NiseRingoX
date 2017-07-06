//
//  SCBalloonSkin.h
//  NiseRingo
//
//  Created by apple  on 13-4-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDescription.h"

@interface SCBalloonSkin : NSObject{
    NSImage *image;
    NSRect frame;
    int scope;
    int balloonID;
    SCDescription *desc;
}

-(id)initWithDescription:(SCDescription*)parentDesc
                    path:(NSString*)dir
                    name:(NSString*)bskinname
                      id:(int)argBalloonID
                   scope:(int)argScope;

@end
