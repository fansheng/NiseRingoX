//
//  SCShellView.m
//  NiseRingo
//
//  Created by apple  on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShellView.h"

@implementation SCShellView
@synthesize base;
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
    if (base==nil) {
        [[NSColor clearColor] set];
        NSRectFill(dirtyRect);
    }
    else{
        [base drawAtPoint:NSZeroPoint fromRect:dirtyRect operation:NSCompositeCopy fraction:1.0];
        
    }
}

-(void)changeSurface:(NSImage *)img{
    base=img;
}

@end
