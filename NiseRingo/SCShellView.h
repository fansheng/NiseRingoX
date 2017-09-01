//
//  SCShellView.h
//  NiseRingo
//
//  Created by apple  on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCShellView : NSView{
    NSImage *__weak base;
    NSPoint p;
}
@property (weak) NSImage *base;

-(void)changeSurface:(NSImage *)img;

@end
