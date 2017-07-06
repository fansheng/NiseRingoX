//
//  SCBalloonTextView.m
//  NiseRingo
//
//  Created by apple  on 13-1-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCBalloonTextView.h"

@implementation SCBalloonTextView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        font=[NSFont systemFontOfSize:10.0f];
        fontHeight=roundf([font boundingRectForFont].size.height);
        mainColor=[NSColor blackColor];
        mainShadowColor=nil;
        x=0;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

-(void)addChar:(unichar)c{
    
	NSRect bounds = [self bounds];
    NSString *string=[NSString stringWithCharacters:&c length:1];
    
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	[attributes setObject:[NSFont userFontOfSize:10]
				   forKey:NSFontAttributeName];
	[attributes setObject:[NSColor redColor]
				   forKey:NSForegroundColorAttributeName];
	//NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
    strOrigin.x = bounds.origin.x + x;
    x=x+10;
	strOrigin.y = 30;//bounds.origin.y + (bounds.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
	// Am I the window's first responder?
	if (([[self window] firstResponder] == self) &&
		[NSGraphicsContext currentContextDrawingToScreen])
	{
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
    [self setNeedsDisplay:YES];
}

@end
