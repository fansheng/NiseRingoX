//
//  SCSafetyBalloonBackgroundView.h
//  NiseRingo
//
//  Created by apple  on 14-3-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCSafetyBalloonBackgroundView : NSView{
    NSImage *buffer;
    BOOL bufIsDirty;
}
@property  NSImage *buffer;

@end
