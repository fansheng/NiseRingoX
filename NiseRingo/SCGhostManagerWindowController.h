//
//  SCGhostManagerWindowController.h
//  NiseRingo
//
//  Created by apple  on 13-2-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCGhostPreviewView.h"
#import "SCInstalledGhostsList.h"

@class SCGhostManager;
@interface SCGhostManagerWindowController : NSWindowController<NSWindowDelegate>{
    SCGhostManager* ghostManager;
    SCInstalledGhostsList *installedList;
}

//root
@property (assign) IBOutlet NSTableView *tableInstalled;
@property (assign) IBOutlet NSTabView *tabviewInfo;
@property (assign) IBOutlet NSTextField *findBox;
@property (assign) IBOutlet NSButton *btn_thumb_view;
@property (assign) IBOutlet NSDrawer *drawer_thumbnail;

//tab CONTROL/PREVIEW
@property (assign) IBOutlet SCGhostPreviewView *previewView;
@property (assign) IBOutlet NSTextField *scaleIndicator;
@property (assign) IBOutlet NSSlider *scaleSlider;
@property (assign) IBOutlet NSButton *btn_networkupdate;
@property (assign) IBOutlet NSButton *btn_tate_kesi;
@property (assign) IBOutlet NSButton *btn_vanish;

// tab BALLOON
@property (assign) IBOutlet NSTableView *tableBalloon;

// tab SHELL
@property (assign) IBOutlet NSTableView *table_shell;

// view DETAIL
@property (assign) IBOutlet NSTextField *fld_identification;
@property (assign) IBOutlet NSTextField *fld_mastershiori;
@property (assign) IBOutlet NSTextField *fld_n_shells;
@property (assign) IBOutlet NSTextField *fld_makoto;

// view THUMBNAIL
@property (assign) IBOutlet NSImageView *image_thumbnail;


- (id)initWithSCGhostManager:(SCGhostManager *)s;
-(void)showWindow:(id)sender;

// Actions
- (IBAction)findBoxUpdated:(id)sender;
- (IBAction)tateKesi:(id)sender;
- (IBAction)networkupdate:(id)sender;
- (IBAction)vanish:(id)sender;
- (IBAction)reloadLists:(id)sender;
- (IBAction)sliderScale:(id)sender;


@end
