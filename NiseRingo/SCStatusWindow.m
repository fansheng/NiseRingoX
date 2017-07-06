//
//  SCStatusWindow.m
//  NiseRingo
//
//  Created by apple  on 13-7-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCStatusWindow.h"

@implementation SCStatusWindow
-(id)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        //[self setBackgroundColor:[NSColor clearColor]];
        //[self setOpaque:NO];
        
        //NSButton* bt=[[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 90, 90)];
        //[self.contentView addSubview:bt];
         
        //[self setContentView:bt];
         
        
        [self setHasShadow:YES];
    }
    return self;
}


@end
