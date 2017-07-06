//
//  SCBalloonTextView.h
//  NiseRingo
//
//  Created by apple  on 13-1-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCBalloonTextView : NSView{
    NSFont *font;
    float fontHeight;
    NSColor *mainColor, *mainShadowColor;
    CGFloat x;
}
-(void)addChar:(unichar)c;

@end
