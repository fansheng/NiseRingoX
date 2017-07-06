//
//  SCStatusTextView.m
//  NiseRingo
//
//  Created by apple  on 13-7-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCStatusTextView.h"

@implementation SCStatusTextView

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
    NSRect bounds = [self bounds];
	// Fill the view with green
	[[NSColor greenColor] set];
	[NSBezierPath fillRect: bounds];
    NSMutableAttributedString *s;
    s = [[NSMutableAttributedString alloc]
         initWithString:@"Big Nerd Ranch"];
    [s addAttribute:NSFontAttributeName
              value:[NSFont userFontOfSize:22]
              range:NSMakeRange(0, 14)];
    [s addAttribute:NSUnderlineStyleAttributeName
              value:[NSNumber numberWithInt:1]
              range:NSMakeRange(0,3)];
    [s addAttribute:NSForegroundColorAttributeName
              value:[NSColor greenColor]
              range:NSMakeRange(0, 8)];
    [s addAttribute:NSSuperscriptAttributeName
              value:[NSNumber numberWithInt:-1]
              range:NSMakeRange(9,5)];
    [s drawInRect:dirtyRect];
}

-(void)printstr:(NSString *)str
{
    NSMutableAttributedString *astr=[[NSMutableAttributedString alloc] initWithString:str];
    NSGraphicsContext* theContext = [NSGraphicsContext currentContext];
    [theContext saveGraphicsState];
    [astr addAttribute:NSForegroundColorAttributeName value:[NSColor greenColor] range:NSMakeRange(0, 1)];
    [astr drawAtPoint:NSMakePoint(0, 0)];
    [theContext restoreGraphicsState];
    [self setNeedsDisplay:YES];
}

@end
