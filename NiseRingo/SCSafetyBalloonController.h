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
@property (weak) IBOutlet NSScrollView *textScrollView;
@property (weak) IBOutlet SCBalloonTextView *textview;
@property (weak) IBOutlet SCSafetyBalloonBackgroundView *bgview;

-(void)addChar:(unichar)c;
@end
