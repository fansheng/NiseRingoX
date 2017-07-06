//
//  SCSafetyBalloonBackgroundView.m
//  NiseRingo
//
//  Created by apple  on 14-3-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SCSafetyBalloonBackgroundView.h"

@implementation SCSafetyBalloonBackgroundView
@synthesize buffer;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        bufIsDirty=YES;
        buffer=[[NSImage alloc] initWithSize:frame.size];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if (bufIsDirty) {
        [buffer lockFocus];
        [[NSColor clearColor] set];
        [[NSColor redColor] set];
        [NSBezierPath fillRect:[self frame]];
        [buffer unlockFocus];
        bufIsDirty=NO;
    }
}

@end
