//
//  SCSafetyBalloonController.h
//  NiseRingo
//
//  Created by apple  on 13-4-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCBalloonTextView.h"
#import "SCSafetyBalloonBackgroundView.h"

@interface SCSafetyBalloonController : NSWindowController<NSWindowDelegate>
@property (assign) IBOutlet NSScrollView *textScrollView;
@property (assign) IBOutlet SCBalloonTextView *textview;
@property (assign) IBOutlet SCSafetyBalloonBackgroundView *bgview;

-(void)addChar:(unichar)c;
@end
