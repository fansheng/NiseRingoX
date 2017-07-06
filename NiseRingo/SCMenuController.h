//
//  SCMenuController.h
//  NiseRingo
//
//  Created by apple  on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMenuController : NSMenu

@property (assign) IBOutlet NSMenuItem *showPrefWindow;
@property (assign) IBOutlet NSMenuItem *quit;

@property (assign) IBOutlet NSMenu *mainmenu;
@property (assign) IBOutlet NSMenuItem *mailcheck;

- (IBAction)toggleShioriLog:(id)sender;
- (IBAction)toggleShioriLocked:(id)sender;
- (IBAction)eventOnBoot:(id)sender;
- (IBAction)pseudoAI:(id)sender;
- (IBAction)doMailCheck:(id)sender;
- (IBAction)showPrefWindow:(id)sender;
- (IBAction)showShellManager:(id)sender;
- (IBAction)quit:(id)sender;

+(SCMenuController*)sharedMenuController;

@end
