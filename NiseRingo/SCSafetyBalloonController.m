//
//  SCSafetyBalloonController.m
//  NiseRingo
//
//  Created by apple  on 13-4-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSafetyBalloonController.h"

@interface SCSafetyBalloonController ()

@end

@implementation SCSafetyBalloonController

-(id)init{
    self = [super initWithWindowNibName:@"SafetyBalloon"];
    if (self) {
        // Initialization code here.
        [[self window] setAcceptsMouseMovedEvents:YES];
        [[self window] setDelegate:self];
        [[self window] setAutodisplay:YES];
        [[self window] useOptimizedDrawing:NO];
        [[self textScrollView] setDrawsBackground:NO];
    }
    
    return self;
}

-(void)close{
    //NSLog(@"%@",@"close");
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)addChar:(unichar)c{
    [[self textview] addChar:c];
}

@end
