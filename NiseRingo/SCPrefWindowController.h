//
//  SCPrefWindowController.h
//  NiseRingo
//
//  Created by apple  on 13-1-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCPrefWindowController : NSWindowController<NSWindowDelegate>

@property (assign) IBOutlet NSButton *booting_check_oldest_type;
@property (assign) IBOutlet NSButton *booting_check_inverse_type;
@property (assign) IBOutlet NSButton *booting_check_ghost_thumbnail;
@property (assign) IBOutlet NSButton *booting_check_zeropoint_balloon;

@property (assign) IBOutlet NSButton *mailcheck_check_enable;
@property (assign) IBOutlet NSTextField *mailcheck_fld_server;
@property (assign) IBOutlet NSTextField *mailcheck_fld_username;
@property (assign) IBOutlet NSSecureTextField *mailcheck_fld_password;
@property (assign) IBOutlet NSButton *mailcheck_check_autocheck;
@property (assign) IBOutlet NSTextField *mailcheck_fld_autocheck_interval;

@property (assign) IBOutlet NSButton *sstp_switch;
@property (assign) IBOutlet NSMatrix *sstp_portselect;
@property (assign) IBOutlet NSTextView *sstp_logview;

@property (assign) IBOutlet NSTableView *plugin_list;

@property (assign) IBOutlet NSMatrix *display_sb_levelselect;
@property (assign) IBOutlet NSButton *display_sb_activate_on_script;
@property (assign) IBOutlet NSTextField *display_sb_fontnamefield;
@property (assign) IBOutlet NSTextField *display_sb_fontsizefield;
@property (assign) IBOutlet NSSlider *display_sb_slider_transparency;
@property (assign) IBOutlet NSTextField *display_sb_fld_transparency;
@property (assign) IBOutlet NSButton *display_sb_balloon_fadeout;
@property (assign) IBOutlet NSButton *display_sb_balloon_clickthrough;
@property (assign) IBOutlet NSSlider *display_sb_slider_waitrate;
@property (assign) IBOutlet NSTextField *display_sb_fld_waitrate;

@property (assign) IBOutlet NSTextField *display_gm_preview_fpath;

@property (assign) IBOutlet NSButton *misc_always_show_vanish;
@property (assign) IBOutlet NSButton *misc_delete_after_online_install;
@property (assign) IBOutlet NSButton *misc_load_whole_surfaces;
@property (assign) IBOutlet NSButton *misc_disable_seriko_animation;
@property (assign) IBOutlet NSButton *misc_show_dev_interfaces;
@property (assign) IBOutlet NSTextField *misc_lightmode_on_sstp;
@property (assign) IBOutlet NSButton *misc_reset_surface_on_sstp;

+(SCPrefWindowController *)sharedPrefWindowController;

/******** callback methods ********/
-(void)_font_changed;

/************* actions ************/
- (IBAction)sstp_switch:(id)sender;
- (IBAction)sstp_portselect:(id)sender;
- (IBAction)display_sb_levelselect:(id)sender;
- (IBAction)display_sb_activate_on_script:(id)sender;
- (IBAction)display_sb_balloon_fadeout:(id)sender;
- (IBAction)display_sb_showfontpanel:(id)sender;
- (IBAction)display_sb_slider_transparency:(id)sender;
- (IBAction)display_sb_slider_waitrate:(id)sender;
- (IBAction)display_gm_preview_select:(id)sender;
- (IBAction)misc_always_show_vanish:(id)sender;
- (IBAction)misc_delete_after_online_install:(id)sender;


@end
