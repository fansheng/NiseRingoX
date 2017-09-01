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
@property (weak) IBOutlet NSTableView *tableInstalled;
@property (weak) IBOutlet NSTabView *tabviewInfo;
@property (weak) IBOutlet NSTextField *findBox;
@property (weak) IBOutlet NSButton *btn_thumb_view;
@property (weak) IBOutlet NSDrawer *drawer_thumbnail;

//tab CONTROL/PREVIEW
@property (weak) IBOutlet SCGhostPreviewView *previewView;
@property (weak) IBOutlet NSTextField *scaleIndicator;
@property (weak) IBOutlet NSSlider *scaleSlider;
@property (weak) IBOutlet NSButton *btn_networkupdate;
@property (weak) IBOutlet NSButton *btn_tate_kesi;
@property (weak) IBOutlet NSButton *btn_vanish;

// tab BALLOON
@property (weak) IBOutlet NSTableView *tableBalloon;

// tab SHELL
@property (weak) IBOutlet NSTableView *table_shell;

// view DETAIL
@property (weak) IBOutlet NSTextField *fld_identification;
@property (weak) IBOutlet NSTextField *fld_mastershiori;
@property (weak) IBOutlet NSTextField *fld_n_shells;
@property (weak) IBOutlet NSTextField *fld_makoto;

// view THUMBNAIL
@property (weak) IBOutlet NSImageView *image_thumbnail;


- (instancetype)initWithSCGhostManager:(SCGhostManager *)s NS_DESIGNATED_INITIALIZER;
-(void)showWindow:(id)sender;

// Actions
- (IBAction)findBoxUpdated:(id)sender;
- (IBAction)tateKesi:(id)sender;
- (IBAction)networkupdate:(id)sender;
- (IBAction)vanish:(id)sender;
- (IBAction)reloadLists:(id)sender;
- (IBAction)sliderScale:(id)sender;


@end
