//
//  SCStatusBackgroundView.m
//  NiseRingo
//
//  Created by apple  on 13-7-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCStatusBackgroundView.h"

@implementation SCStatusBackgroundView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[NSColor colorWithCalibratedRed:0.3f green:0.3f blue:0.3f alpha:0.7f] set];
    [NSBezierPath fillRect:dirtyRect];
}

@end
