//
//  SCMenuController.h
//  NiseRingo
//
//  Created by apple  on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMenuController : NSMenu

@property (weak) IBOutlet NSMenuItem *showPrefWindow;
@property (weak) IBOutlet NSMenuItem *quit;

@property (weak) IBOutlet NSMenu *mainmenu;
@property (weak) IBOutlet NSMenuItem *mailcheck;

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
