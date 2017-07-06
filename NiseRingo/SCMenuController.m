//
//  SCMenuController.m
//  NiseRingo
//
//  Created by apple  on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCMenuController.h"
#import "SCFoundation.h"
#import "SCPrefWindowController.h"
#import "SCGhostManager.h"
#import "SCGhostManagerWindowController.h"
#import "SCStatusWindowController.h"

@implementation SCMenuController

+(SCMenuController *)sharedMenuController{
    static SCMenuController* _sharedInstance = nil;
    @synchronized(self)  {
        if  (_sharedInstance == nil) {
            _sharedInstance=[[self alloc] init]; // assignment not done here
        }
    }
    return _sharedInstance;
}

- (IBAction)toggleShioriLog:(id)sender {
    SCStatusWindowController* scs=[[SCStatusWindowController alloc] initWithWindowNibName:@"StatusWindow"];
    [scs showWindow:nil];
    //[scs setTypeToText];
    //[scs texttypePrint:@"Test"];
}

- (IBAction)toggleShioriLocked:(id)sender {
}

- (IBAction)eventOnBoot:(id)sender {
}

- (IBAction)pseudoAI:(id)sender {
}

- (IBAction)doMailCheck:(id)sender {
}

- (IBAction)showPrefWindow:(id)sender {
    SCPrefWindowController* pwc=[SCPrefWindowController sharedPrefWindowController];
    [pwc showWindow:nil];
}

- (IBAction)showShellManager:(id)sender {
    SCGhostManager *shellm=[SCGhostManager sharedSCGhostManager];
    SCGhostManagerWindowController* gmwc=[[SCGhostManagerWindowController alloc] initWithSCGhostManager:shellm];
    [gmwc showWindow:nil];
}

- (IBAction)quit:(id)sender {
    [[SCFoundation sharedFoundation] performQuit];
}

-(BOOL)validateMenuItem:(NSMenuItem *)menuItem{
    if (menuItem==[self showPrefWindow]) {
        SCPrefWindowController* pref = [SCPrefWindowController sharedPrefWindowController];
        return ![[pref window] isVisible];
    }
    else if(menuItem==[self mailcheck]){
        //TODO:
        return YES;
    }
    else if(menuItem==[self quit]){
        //TODO:
        return YES;
    }
    return YES;
}
@end
