//
//  SCShellWindow.m
//  NiseRingo
//
//  Created by apple  on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShellWindow.h"

@implementation SCShellWindow
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        [self setBackgroundColor:[NSColor clearColor]];
        [self setOpaque:NO];
        [self setHasShadow:NO];
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent{
    // ウインドウ移動準備。
    NSPoint initialPt =[[theEvent window] convertRectToScreen:NSMakeRect([theEvent locationInWindow].x,[theEvent locationInWindow].y,0,0)].origin ;
    
    initial_shell_horiz_offset = (int)(initialPt.x - [[theEvent window] frame].origin.x);
    initial_shell_vert = (int)[[theEvent window] frame].origin.y;
}

-(void)mouseDragged:(NSEvent *)theEvent{
    NSWindow *window=[theEvent window];
    
    NSPoint new_loc = [window convertRectToScreen:NSMakeRect([window mouseLocationOutsideOfEventStream].x,[window mouseLocationOutsideOfEventStream].y,0,0)].origin;
    int new_x;
    new_x = (int)(new_loc.x - initial_shell_horiz_offset);
    
    //controller.absoluteSetLoc(new_x,initial_shell_vert);
}

-(void)mouseUp:(NSEvent *)theEvent{
    ;
}

@end
